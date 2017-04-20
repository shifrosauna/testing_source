<?php

namespace App;

use App\Exceptions\AccessDeniedException;
use App\Exceptions\ActionNotFoundException;
use App\Exceptions\ControllerNotFoundException;
use App\Exceptions\UnauthorizedException;
use App\Exceptions\ValidateException;
use App\Viewers\AbstractViewer;
use Domain\Menu\MenuService;
use Domain\Users\UsersService;

/**
 * Основной класс приложения.
 *
 * Парсинг запросов, выбор схемы, проверка авторизации и прав доступа,
 * шаблонизация представлений, логирование, конечный вывод.
 */
class Engine {

    /**
     * Экземпляр AbstractViewer
     * @var AbstractViewer
     */
    public $viewer;

    /**
     * Формат вывода (html|json|cli)
     * @var string
     */
    private $_output_type;

    /**
     * Текущий поддомен
     * @var string
     */
    private $_site_name;

    /**
     * Текущая схема
     * @var string
     */
    private $_scheme_name;

    /**
     * Массив запроса
     * @var array
     */
    private $_path;

    /**
     * Массив аргументов запроса
     * @var array
     */
    private $_args;

    /**
     * Имя контроллера
     * @var string
     */
    private $_controller_name;

    /**
     * Имя метода
     * @var string
     */
    private $_action_name;

    /**
     * Полное имя метода
     * @var string
     */
    private $_action_full_name;

    /**
     * Данные полученные из контроллера
     * @var array
     */
    private $_data;

    /**
     * Флаг: нужна ли авторизация
     * @var boolean
     */
    private $_need_auth = true;

    /**
     * Список методов, доступных без авторизации
     * @var array
     */
    private $_no_auth = array(
        'Index/login',
        'Index/logout',
    );

    /**
     * @var boolean
     */
    private $_work_access = false;

    /**
     * @var array
     */
    private $_work_always = array(
        'Index/index',
        'Index/auth',
        'Translate/index',
    );

    /**
     * Экземпляр BaseController
     * @var BaseController
     */
    private $controller;

    /**
     * Инициализация поддомена и схемы
     *
     * @param $site_name
     * @param $scheme_name
     *
     * @throws Exceptions\BaseException
     */
    public function __construct($site_name, $scheme_name) {

        $this->_site_name = $site_name;
        $this->_scheme_name = $scheme_name;
        $this->_path = [];
        $this->_args = [];

        $this->viewer = Viewers\ViewerFactory::create($this->_site_name);
        $this->viewer->setSiteName($this->_site_name);

        $this->_output_type = $this->viewer->getOutputType();
    }

    /**
     * Redirect user to the $path location
     *
     * @param string $path
     */
    public static function redirect($path) {

        header('HTTP/1.1 302 Found');
        header('Location: ' . $path);
        exit;
    }

    /**
     * Проверка текущего пользователя: авторизация и права доступа
     */
    public function checkUser() {

        try {

            if ($this->_need_auth) {
                UsersService::checkAuth();
            }

            if (!$this->_work_access) {
                UsersService::checkAccess($this->_controller_name, $this->_action_name, true);
            }

            if (!$this->_work_access && !$this->_need_auth) {
                if ($this->_output_type == 'html') {
                    self::redirect(Configuration::get('system')->default_page);
                }
            }

            Exceptions\Handlers\Control::$debug = UsersService::checkAccess('Exceptions', 'trace');

        } catch (UnauthorizedException $e) {

            if (!$this->_work_access && $this->_need_auth) {

                if ($this->_output_type == 'html') {
                    self::redirect('/#/access/login');
                }

                throw $e;
            }
        } catch (AccessDeniedException $e) {

            if (!$this->_work_access && $this->_need_auth) {

                if ($this->_output_type == 'html') {
                    self::redirect(Configuration::get('system')->default_page);
                }

                throw $e;
            }
        }
    }

    /**
     * Загрузка дефолтных элементов для html-вывода (информация о юзере, меню, языки и пр.)
     */
    public function setHTMLViews() {

        if ($this->_output_type == 'html' && $this->_need_auth && UsersService::isAuth()) {

            $user = UsersService::current();
            //UsersService::loadFinance($user);

            $this->viewer->setViews(array(
                'output' => array(
                    'user'            => json_encode(UsersService::export($user)),
                    'lang'            => UsersService::current()->getLang(),
                    // 'account_menu'    => UsersService::getAccountMenu(),
                    // 'main_menu_items' => MenuService::getMainMenu(UsersService::current()->getId()),
                ),
                'views'  => array(
                    // 'user_balance_header' => 'Users/user_balance_header',
                    // 'lang_toggle'         => 'Lang/toggle',
                    // 'main_menu'           => 'Menu/main_menu',
                    // 'account_menu'        => 'Users/account_menu',
                ),
            ));
        }
    }

    /**
     * Парсинг http-запроса.
     *
     * Преобразование запроса в массив элементов: /<arg1>/<arg2>/...
     */
    public function parseQuery() {

        $request = parse_url($_SERVER['REQUEST_URI']);
        $path = explode('/', $request['path']);

        array_shift($path);
        $this->_path = $path;
    }

    /**
     * Парсинг запроса из консоли.
     *
     * На входе массив переменных из консоли.
     *
     * @param array $args
     *
     * @throws AccessDeniedException
     * @throws ValidateException
     */
    public function parseCliQuery($args) {

        if ($this->_output_type != 'cli') {
            throw new AccessDeniedException("Not cli");
        }

        if (empty($args) || count($args) < 3) {
            throw new ValidateException("Empty params");
        }

        array_shift($args);
        $this->_path = $args;
    }

    public function checkWorkAccess() {

        if (in_array($this->_controller_name . '/' . $this->_action_name, $this->_no_auth)) {
            $this->_need_auth = false;
        }

        if (in_array($this->_controller_name . '/' . $this->_action_name, $this->_work_always)) {
            $this->_work_access = true;
        }
    }

    /**
     * Поиск контроллера и метода.
     *
     * Если контроллер не найден, берем IndexController;
     * Если метод не найден, берем indexAction;
     * Все оставшиеся элементы передаются в метод в качестве переменных.
     *
     * Пример 1: http://apk.domain/offers/view/45
     * -> findControllerAndAction()
     * -> OffersController->viewAction(45)
     *
     * Если на входе есть контроллер и/или метод, то сдвигаем разбор элементов.
     *
     * Пример 2: http://apk.domain/23/61
     * -> findControllerAndAction('Index', 'download')
     * -> IndexController->downloadAction(23,61)
     *
     * @param string $controllerShortName
     * @param string $actionShortName
     *
     * @throws ActionNotFoundException
     * @throws ControllerNotFoundException
     */
    public function findControllerAndAction($controllerShortName = '', $actionShortName = '') {

        // Если контроллер не указан явно, ищем его по первому элементу массива
        if (empty($controllerShortName)) {

            try {

                // Ищем контроллер по первому элементу массива
                $controllerShortName = (!empty($this->_path[0])) ? $this->nameWithFirstLetterUpperCase($this->_path[0]) : 'Index';
                $controllerFullName = $this->getControllerFullName($controllerShortName);

                // Контроллер найден - двигаемся дальше по массиву
                array_shift($this->_path);

            } catch (ControllerNotFoundException $e) {

                // Контроллер не найден - пробуем Index-контроллер
                $controllerShortName = 'Index';
            }
        }

        if (empty($controllerFullName)) {
            $controllerFullName = $this->getControllerFullName($controllerShortName);
        }

        $this->controller = new $controllerFullName;
        $this->_controller_name = $controllerShortName;

        // Если метод не указан явно, ищем его по первому элементу массива
        if (empty($actionShortName)) {

            try {

                // Ищем метод по первому элементу массива
                $actionShortName = (!empty($this->_path[0])) ? strtolower($this->_path[0]) : 'index';
                $actionFullName = $this->getActionFullName($actionShortName);

                // Метод найден - двигаемся дальше по массиву
                array_shift($this->_path);

            } catch (ActionNotFoundException $e) {

                // Метод не найден - пробуем Index-метод
                $actionShortName = 'index';
            }
        }

        if (empty($actionFullName)) {
            $actionFullName = $this->getActionFullName($actionShortName);
        }

        $this->_action_name = $actionShortName;
        $this->_action_full_name = $actionFullName;

        if (in_array($this->_controller_name . '/' . $this->_action_name, $this->_no_auth)) {
            $this->_need_auth = false;
        }

        if (in_array($this->_controller_name . '/' . $this->_action_name, $this->_work_always)) {
            $this->_work_access = true;
        }

        $this->_args = $this->_path;
    }

    public function execute() {

        $this->_data = call_user_func_array(array($this->controller, $this->_action_full_name), $this->_args);
    }

    /**
     * Вывод данных в соответствующем формате.
     *
     * Контроллер также может сам определить формат вывода.
     *
     * @throws Exceptions\BaseException
     */
    public function output() {

        if (is_array($this->_data)) {

            if (!empty($this->_data['redirect'])) {
                self::redirect($this->_data['redirect']);
            }

            if (!empty($this->_data['output_type']) && $this->_data['output_type'] != $this->_output_type) {
                $this->viewer = Viewers\ViewerFactory::create($this->_site_name, $this->_data['output_type']);
                $this->viewer->setSiteName($this->_site_name);
            }
        }

        $this->prepareToOutput($this->viewer->getOutputType());

        $this->viewer->output($this->_data);
    }

    public function setLanguage() {

        if (!empty($_GET['lang'])) {
            setcookie('lang', $_GET['lang'], time() + 180 * 24 * 3600);
            $_COOKIE['lang'] = $_GET['lang'];
        }
    }

    public function setDefaultTimezone() {

        ini_set('date.timezone', 'Etc/GMT-3');
        date_default_timezone_set('Etc/GMT-3');
    }

    /**
     * @param string $viewer_type
     *
     * @throws Exceptions\BaseException
     */
    public function setExceptionsHandler($viewer_type = '') {

        //Exceptions\Handlers\Control::$debug = false; // UsersService::checkAccess('Exceptions', 'trace');
        Exceptions\Handlers\Control::setupEnvironment(dirname(__FILE__) . DIRECTORY_SEPARATOR . 'phperror.log');
        Exceptions\Handlers\Control::setupHandlersOutput();

        if ($viewer_type == $this->_output_type || empty($viewer_type)) {
            Exceptions\Handlers\Control::setupHandlersViewer($this->viewer);
        } else {
            $viewer = Viewers\ViewerFactory::create($this->_site_name, $viewer_type);
            $viewer->setSiteName($this->_site_name);
            Exceptions\Handlers\Control::setupHandlersViewer($viewer);
        }

        Exceptions\Handlers\Control::$debug = (Configuration::get('system')->environment != 'production');
        Exceptions\Handlers\Control::setupHandlersLog(new Exceptions\Handlers\LogSimple());
    }

    /**
     * Поиск полного имени контроллера в соответствии с текущей схемой
     *
     * @param $controllerShortName
     *
     * @return string $controllerFullName
     * @throws ControllerNotFoundException
     */
    private function getControllerFullName($controllerShortName) {

        $controllerName = $controllerShortName . 'Controller';
        $controllerFullName = '\\Http\\' . $this->_scheme_name . '\\' . $controllerName;

        if (!class_exists($controllerFullName)) {
            throw new ControllerNotFoundException("{$controllerName} not found.");
        }

        return $controllerFullName;
    }

    /**
     * Поиск полного имени метода в текущем контроллере
     *
     * @param string $actionShortName
     *
     * @return string $actionFullName
     * @throws ActionNotFoundException
     */
    private function getActionFullName($actionShortName) {

        $actionFullName = $actionShortName . 'Action';

        if (!method_exists($this->controller, $actionFullName)) {
            throw new ActionNotFoundException("{$actionFullName} not found for {$this->_controller_name}.");
        }

        return $actionFullName;
    }

    /**
     * @param string $outputType
     */
    private function prepareToOutput($outputType) {

        if ($outputType == 'html') {
            $this->_data['view'] = (!empty($this->_data['view'])) ? $this->_data['view'] : $this->_controller_name . '/' . $this->_action_name;
        }
    }

    /**
     * Перевод строки в нижний регистр с первой заглавной буквой (StudlyCaps)
     *
     * @param string $name
     *
     * @return string $result
     */
    private function nameWithFirstLetterUpperCase($name) {

        $result = strtolower($name);
        $result[0] = strtoupper($result[0]);

        return $result;
    }
}