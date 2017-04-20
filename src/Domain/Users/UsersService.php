<?php

namespace Domain\Users;

use Infrastructure\UsersRepository;
use App\Configuration;
use App\Exceptions\AccessDeniedException;
use App\Exceptions\UnauthorizedException;
use App\Exceptions\UserNotFoundException;
use App\Exceptions\ValidateException;
use App\Mailer\MailerFactory;

class UsersService {

    const SCENARIO_LOGIN        = 'login';
    const SCENARIO_REGISTRATION = 'registration';

    /**
     * @var User
     */
    private static $current_user;

    /**
     * Return current authorized User
     *
     * @return User
     *
     * @throws UserNotFoundException
     */
    public static function current() {

        if (self::$current_user === null) {

            $userId = self::getAuthID();

            $usersRepository = new UsersRepository;
            $userData = $usersRepository->findById($userId);

            // ToDo
            //
            // $userData = $usersRepository->findByIdWith($id, array('permissions', 'info', 'finance', 'settings'));

            if (empty($userData)) {
                throw new UserNotFoundException(__CLASS__, $userId);
            }

            $userData->permissions = $usersRepository->getPermissionsByUserId($userId);

            self::$current_user = UsersFactory::createByData($userData);
        }

        return self::$current_user;
    }

    /**
     * Authenticate User by email and password
     *
     * @param $data
     *
     * @return User
     * @throws UserNotFoundException
     * @throws ValidateException
     */
    public static function authenticate($data) {

        self::validate($data, self::SCENARIO_LOGIN);

        $email = $data['email'];
        $pass = $data['pass'];

        $hash = self::hash($email, $pass);
        $user = self::findUserBy(array('email' => $email, 'hash' => $hash));

        $time = time() + 3600 * 24 * 30;
        $sign = self::sign($user->getId(), $email);

        setcookie('email', $email, $time, '/');
        setcookie('id', $user->getId(), $time, '/');
        setcookie('s', $sign, $time, '/');

        return $user;
    }

    /**
     * Logout - clear all cookies
     */
    public static function logout() {

        setcookie('email', '');
        setcookie('id', '');
        setcookie('s', '');
    }

    /**
     * Check authorization
     *
     * @return boolean
     **/
    public static function isAuth() {

        if (empty($_COOKIE['id']) || empty($_COOKIE['email']) || empty($_COOKIE['s']) || $_COOKIE['s'] != self::sign($_COOKIE['id'], $_COOKIE['email'])) {
            return false;
        }

        return true;
    }

    /**
     * Check authorization
     *
     * @return boolean
     *
     * @throws UnauthorizedException
     **/
    public static function checkAuth() {

        if (empty($_COOKIE['id']) || empty($_COOKIE['email']) || empty($_COOKIE['s']) || $_COOKIE['s'] != self::sign($_COOKIE['id'], $_COOKIE['email'])) {
            throw new UnauthorizedException();
        }

        return true;
    }

    /**
     * Check User access by controller, action and id
     *
     * @param string $controllerName
     * @param string $actionName
     * @param bool   $break
     *
     * @return bool
     *
     * @throws AccessDeniedException
     */
    public static function checkAccess($controllerName, $actionName, $break = false) {

        $permissions = self::current()->getPermissions();

        if (empty($permissions[$controllerName])) {

            if ($break) {
                throw new AccessDeniedException(self::current());
            }

            return false;
        }

        if (!in_array($actionName, $permissions[$controllerName])) {

            if ($break) {
                throw new AccessDeniedException(self::current());
            }

            return false;
        }

        return true;
    }

    /**
     * @param int    $userId
     * @param string $controllerName
     * @param string $actionName
     *
     * @return bool
     */
    public static function checkUserAccess($userId, $controllerName, $actionName) {

        $usersRepository = new UsersRepository;
        $permissions = $usersRepository->getPermissionsByUserId($userId);

        if (empty($permissions[$controllerName])) {
            return false;
        }

        if (in_array('*', $permissions[$controllerName])) {
            return true;
        }

        if (!in_array($actionName, $permissions[$controllerName])) {
            return false;
        }

        return true;
    }

    /**
     * Restore User by unique id
     *
     * @param int $id
     *
     * @return User
     * @throws UserNotFoundException
     */
    public static function findUserById($id) {

        $usersRepository = new UsersRepository;
        $userData = $usersRepository->findById($id);

        if (empty($userData)) {
            throw new UserNotFoundException($id);
        }

        return UsersFactory::createByData($userData);
    }

    /**
     * Register User
     *
     * @param array $data
     */
    public static function register($data) {

        self::validate($data, self::SCENARIO_REGISTRATION);

        $user = UsersFactory::create();
        $user->setLogin($data['login']);
        $user->setEmail($data['email']);
        $user->setHash(self::hash($data['email'], $data['pass']));

        $usersRepository = new UsersRepository;
        $aff_id = $usersRepository->insert($user);
        $user->setId($aff_id);

        $user->setInfo($data['info']);
        $usersRepository->insertInfo($user);

        if (!empty($data['ref_id'])) {
            $usersRepository->updateRefId($aff_id, intval($data['ref_id']));
        }

        $body = 'Здравствуйте, ' . $user->getLogin() . '.<br/>
Вы успешно зарегистрировались в СPA-сети MobiOffers.ru!<br/><br/>
Для авторизации Вы можете использовать данный email и пароль, указанный при регистрации.<br/><br/>
Контакты техподдержки:<br/>
skype: mobioffers.partners<br/>
email: support@mobioffers.ru<br/><br/>

---<br/>
C уважением<br/>
команда MobiOffers.ru';

        $mailer = MailerFactory::get('POP3');
        $mailer->init(array(
            'subject' => 'Регистрация на сайте MobiOffers.ru',
            'body'    => $body,
        ));

        $mailer->sendMail($user->getEmail());
    }

    /**
     * Validate data
     *
     * @param array  $data
     * @param string $scenario
     *
     * @throws ValidateException
     */
    public static function validate($data, $scenario) {

        if (empty($data['email'])) {
            $errors['email'] = 'empty';
        }

        if (empty($data['pass'])) {
            $errors['pass'] = 'empty';
        }

        switch ($scenario) {

            case self::SCENARIO_LOGIN:

                break;

            case self::SCENARIO_REGISTRATION:

                if (!empty($data['email'])) {
                    if (!filter_var($data['email'], FILTER_VALIDATE_EMAIL)) {
                        $errors['email'] = 'Указан некорректный адрес';
                    } elseif (UsersService::isExistEmail($data['email'])) {
                        $errors['email'] = 'Этот email уже зарегистрирован в системе';
                    }
                }

                if (empty($data['login'])) {
                    $errors['login'] = 'empty';
                } elseif (UsersService::isExistLogin($data['login'])) {
                    $errors['login'] = 'Это имя уже занято';
                }

                if (!empty($data['pass']) && (strlen($data['pass']) < 4 || strlen($data['pass']) > 16)) {
                    $errors['pass'] = 'Пароль должен содержать от 4 до 16 символов';
                }

                if (empty($data['pass_confirm'])) {
                    $errors['pass_confirm'] = 'empty';
                } elseif ($data['pass'] != $data['pass_confirm']) {
                    $errors['pass_confirm'] = 'Пароли не совпадают';
                }

                if (empty($data['info']) || empty($data['info']['wmz'])) {
                    $errors['wmz'] = 'empty';
                } elseif (!preg_match("/^Z[0-9]{12}$/", $data['info']['wmz'])) {
                    $errors['wmz'] = 'Указан некорректный кошелек';
                }

                if (empty($data['info']) || empty($data['info']['skype'])) {
                    $errors['skype'] = 'empty';
                }

                if (empty($data['info']) || empty($data['info']['traffic_volumes'])) {
                    $errors['traffic_volumes'] = 'empty';
                }

                if (empty($data['info']) || empty($data['info']['traffic_subjects'])) {
                    $errors['traffic_subjects'] = 'empty';
                }

                if (empty($data['info']) || empty($data['info']['traffic_types'])) {
                    $errors['traffic_types'] = 'empty';
                }

                if (!$data['agree']) {
                    $errors['agree'] = 'Ознакомьтесь с правилами';
                }

                //if (empty($data['captcha'])) {
                //    $errors['captcha'] = 'empty';
                //} elseif ($_SESSION["code"] != $data["captcha"]) {
                //    $errors['captcha'] = 'empty';
                //}

                //if (empty($data['agree'])) {
                //    $errors['agree'] = 'empty';
                //}

                break;
        }

        if (!empty($errors)) {
            throw new ValidateException($errors);
        }
    }

    /**
     * Restore User by unique hash
     *
     * @param $filters
     *
     * @return User
     * @throws UserNotFoundException
     * @internal param string $hash
     */
    public static function findUserBy($filters) {

        $usersRepository = new UsersRepository;
        $userData = $usersRepository->findOneBy($filters);

        if (empty($userData)) {
            throw new UserNotFoundException(http_build_query($filters));
        }

        return UsersFactory::createByData($userData);
    }

    /**
     * Check email for exist
     *
     * @param string $email
     *
     * @return boolean
     */
    public static function isExistEmail($email) {

        $usersRepository = new UsersRepository;
        $userData = $usersRepository->findOneBy(array('email' => $email));

        return (!empty($userData));
    }

    /**
     * Check login for exist
     *
     * @param string $login
     *
     * @return boolean
     */
    public static function isExistLogin($login) {

        $usersRepository = new UsersRepository;
        $userData = $usersRepository->findOneBy(array('login' => $login));

        return (!empty($userData));
    }

    public static function resetPassword($email) {

        $user = self::findUserBy(array('email' => $email));
        $pass = self::generatePassword(8);

        $hash = self::hash($email, $pass);
        $user->setHash($hash);

        $usersRepository = new UsersRepository;
        $usersRepository->updateHash($user);

        $body = 'Здравствуйте, ' . $user->getLogin() . '.<br/><br/>
        
Ваш новый пароль для доступа в MobiOffers.ru: <b>' . $pass . '</b><br/><br/>

---<br/>
C уважением,<br/>
команда MobiOffers.ru';

        $mailer = MailerFactory::get('POP3');
        $mailer->init(array(
            'subject' => 'Восстановление пароля на сайте MobiOffers.ru',
            'body'    => $body,
        ));

        $mailer->sendMail($user->getEmail());
    }

    /**
     * Return user's permissions as int[]
     *
     * @param int $userId
     *
     * @return array
     */
    public static function getPermissionsIdsByUserId($userId) {

        $usersRepository = new UsersRepository;

        return $usersRepository->getPermissionsIdsByUserId($userId);
    }

    public static function loadFinance($user) {

        $usersRepository = new UsersRepository;
        $user->finance = $usersRepository->getFinance($user->getId());
    }

    public static function loadInfo($user) {

        $usersRepository = new UsersRepository;
        $info = $usersRepository->getInfo($user->getId());

        $user->setInfo($info);
    }

    public static function findPartners() {

        $usersRepository = new UsersRepository;

        return $usersRepository->findPartners(array('info', 'referrals'));
    }

    public static function findAllActive() {

        $usersRepository = new UsersRepository;

        return $usersRepository->findPartners(array());
    }

    /**
     * Get account menu
     *
     * @return array $menu
     */
    public static function getAccountMenu() {

        // $current = strtok($_SERVER['REQUEST_URI'], '?');

        $menu = array();
        $stub = array(
            array(
                'title' => 'Профиль',
                'url'   => '/profile/edit',
                'icon'  => 'fa-user',
            ),
            array(
                'title' => 'Настройки',
                'url'   => '/profile/password',
                'icon'  => 'fa-gear',
            ),
            array(
                'title' => 'Выйти',
                'url'   => '/logout',
                'icon'  => 'fa-sign-out',
            ),
        );

        foreach ($stub as $item) {
            $menu[] = (object)$item;
        }

        return $menu;
    }

    /**
     * @param User $user
     *
     * @return \stdClass
     */
    public static function export($user) {

        $obj = new \stdClass;

        $obj->id = $user->getId();
        $obj->email = $user->getEmail();
        $obj->login = $user->getLogin();
        $obj->lang = $user->getLang();

        return $obj;
    }

    /**
     * Get User's id from cookies
     *
     * @return int $id
     * @throws UnauthorizedException
     **/
    private static function getAuthID() {

        if (empty($_COOKIE['id']) || empty($_COOKIE['email']) || empty($_COOKIE['s']) || $_COOKIE['s'] != self::sign($_COOKIE['id'], $_COOKIE['email'])) {
            throw new UnauthorizedException();
        }

        return intval($_COOKIE['id']);
    }

    /**
     * @param int    $id
     * @param string $email
     *
     * @return string
     */
    private static function sign($id, $email) {

        return md5(str_replace(array('{id}', '{email}'), array(
            md5($id),
            md5($email),
        ), Configuration::get('users')->template_sign));
    }

    /**
     * @param string $email
     * @param string $pass
     *
     * @return string
     */
    private static function hash($email, $pass) {

        return md5(str_replace(array('{email}', '{pass}'), array(
            $email,
            $pass,
        ), Configuration::get('users')->template_hash));
    }

    /**
     * STUB METHODS
     */

    private static function generatePassword($length = 8) {

        return substr(md5(time()), 0, $length);
    }

    public function findGroups() {

        $usersRepository = new UsersRepository;

        return $usersRepository->findGroups(array('info', 'referrals'));
    }
}