<?php

namespace Http\Account;

use App\BaseController;
use Domain\Menu\MenuService;
use Domain\Users\UsersService;

class ProfileController extends BaseController {

    public function indexAction() {

        return array(
            'output' => array(
                'title' => 'Профиль',
            ),
        );
    }

    public function menuAction() {

        // ToDo
        // $menu = MenuService::getMainMenu(UsersService::current()->getId());

        $menu = array(
            array(
                'title' => 'Профиль',
                'url'   => '#/profile/edit',
                'icon'  => 'fa-user',
            ),
            array(
                'title' => 'Настройки',
                'url'   => '#/profile/password',
                'icon'  => 'fa-gear',
            ),
            array(
                'title' => 'Выйти',
                'url'   => '#/logout',
                'icon'  => 'fa-sign-out',
            ),
        );

        return $menu;
    }
}