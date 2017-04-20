<?php

namespace Http\Account;

use Domain\Users\UsersService;
use App\BaseController;
use App\Configuration;
use App\Exceptions\UserNotFoundException;
use App\SimpleCaptcha;

class IndexController extends BaseController {

    /**
     * @return array
     */
    public function indexAction() {

        return array(
            'output_type' => 'html',
        );
    }

    /**
     * @return \stdClass
     */
    public function loginAction() {

        $data = $this->request->input();

        $user = UsersService::authenticate($data);

        return UsersService::export($user);
    }

    /**
     * @return bool
     */
    public function logoutAction() {

        UsersService::logout();

        return true;
    }

    public function passwordAction() {

        return array(
            'view'   => 'Users/password',
            'layout' => 'notlogged',
            'output' => array(
                'title' => 'Восстановление парооля',
            ),
        );
    }

    public function resetAction() {

        if (empty($_POST['email'])) {
            return array(
                'output' => array(
                    'errors' => array(
                        'email' => 'empty',
                    ),
                ),
            );
        }

        try {

            UsersService::resetPassword($_POST['email']);

        } catch (UserNotFoundException $e) {

            return array(
                'http_code' => 400,
                'output'    => array(
                    'message' => 'Пользователь с таким email не найден.',
                ),
            );
        }

        return array(
            'output' => array(
                'status'  => 'success',
                'message' => 'Новый пароль отправлен на Вашу почту',
            ),
        );
    }

    public function registrationAction() {

        return array(
            'view'   => 'Users/registration',
            'layout' => 'notlogged',
            'output' => array(
                'title' => 'Регистрация',
            ),
        );
    }

    public function registerAction() {

        $data = array(
            'login'        => (!empty($_POST['login'])) ? $_POST['login'] : '',
            'email'        => (!empty($_POST['email'])) ? $_POST['email'] : '',
            'pass'         => (!empty($_POST['pass'])) ? $_POST['pass'] : '',
            'pass_confirm' => (!empty($_POST['pass_confirm'])) ? $_POST['pass_confirm'] : '',
            'info'         => (!empty($_POST['info'])) ? $_POST['info'] : array(),
            'agree'        => (!empty($_POST['agree']) && $_POST['agree'] == 1),
            'captcha'      => (!empty($_POST['captcha'])) ? $_POST['captcha'] : '',
            'ref_id'       => (!empty($_COOKIE['ref_id'])) ? $_COOKIE['ref_id'] : 0,
        );

        UsersService::register($data);
        UsersService::authenticate($data);

        return array(
            'output' => array(
                'status'   => 'success',
                'action'   => 'continue',
                'location' => '/',
                'message'  => 'Регистрация прошла успешно',
            ),
        );
    }

    public function regAction() {

        $config = Configuration::get('users');

        if (!empty($config->reg_ref_id)) {
            setcookie('ref_id', $config->reg_ref_id);
        }

        return array(
            'redirect' => '/registration',
        );
    }

    public function captchaAction() {

        $captcha = new SimpleCaptcha();

        $captcha->resourcesPath = "resources";
        $captcha->session_var = 'captcha';
        $captcha->scale = 2;
        $captcha->blur = false;
        $captcha->wordsFile = 'words/es.php';
        $captcha->imageFormat = 'jpeg';
        $captcha->lineWidth = 0;

        $captcha->CreateImage();
        exit;
    }
}