<?php

namespace Domain\Menu;

use Domain\Users\UsersService;
use Infrastructure\MenuRepository;

class MenuService {

    /**
     * @param int $userId
     *
     * @return array $menu
     */
    public static function getMainMenu($userId) {

        $menu = array();

        if (empty($current)) {
            $current = strtok($_SERVER['REQUEST_URI'], '?');
        }

        $userPermissions = UsersService::getPermissionsIdsByUserId($userId);

        $rows = self::getByUserPermissions($userPermissions);
        foreach ($rows as $row) {

            if (empty($row->parent_id) || empty($menu[$row->parent_id])) {

                $menu[$row->id] = $row;
                $menu[$row->id]->classes = ($row->url == $current) ? ' ' : '';
            } else {

                if (empty($menu[$row->parent_id]->childs)) {
                    $menu[$row->parent_id]->childs = array();
                }

                $menu[$row->parent_id]->childs[$row->id] = $row;

                if ($row->url == $current) {
                    $menu[$row->parent_id]->classes .= ' ';
                }
            }
        }

        // Destroy one-child items
        foreach ($menu as $item_id => $item) {
            if (!empty($item->childs) && count($item->childs) == 1) {

                $subitem = array_shift($item->childs);
                $subitem->icon = $item->icon;

                $menu[$item_id] = $subitem;
            }
        }

        return $menu;
    }

    /**
     * @param array $permissions
     *
     * @return array $menu
     */
    public static function getByUserPermissions($permissions) {

        //$menu = array(
        //    array(
        //       'id' => '1',
        //       'title' => 'Финансы',
        //       'url' => '#',
        //       //'url' => '/payments',
        //       'weight' => '30',
        //       'parent_id' => '0',
        //       'icon' => 'fa-usd'
        //    ),
        //    array(
        //       'id' => '64',
        //       'title' => 'Выплаты',
        //       'url' => '/payments',
        //       'weight' => '1',
        //       'parent_id' => '1',
        //    ),
        //    array(
        //       'id' => '2',
        //       'title' => 'Заказать досрочную выплату',
        //       'url' => '/payments/add',
        //       'weight' => '2',
        //       'parent_id' => '1',
        //    ),
        //    array(
        //       'id' => '3',
        //       'title' => 'Корректировки',
        //       'url' => '/corrections',
        //       'weight' => '50',
        //       'parent_id' => '1',
        //    ),
        //);

        $menuRepository = new MenuRepository;

        return $menuRepository->findByUserPermissions($permissions);
    }
}