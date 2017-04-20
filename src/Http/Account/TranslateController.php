<?php

namespace Http\Account;

use Domain\Tickets\TicketsService;
use Domain\Users\UsersService;

use App\Exceptions\BaseException;
use App\Exceptions\AccessDeniedException;

class TranslateController extends \App\BaseController {

    /**
     *  Pages
     */

    public function indexAction() {

        $text = trim(urldecode($_POST['text']));

        // exceptions
        $exceptions = array(
            'Выход'           => 'Log out',
            'Войти'           => 'Log in',
            'Загрузить архив' => 'Upload an archive',
        );

        if (empty($exceptions[$text])) {
            $response_json = file_get_contents('https://translate.yandex.net/api/v1.5/tr.json/translate?key=trnsl.1.1.20151211T125406Z.09e760acc04ce838.28e6d1bacf5e2234c0c231498bfb772b8fdd3fb7&text=' . urlencode($text) . '&lang=en');
            $response = json_decode($response_json);
            $result = ($response->code == 200) ? $response->text : $text;
        } else {
            $result = $exceptions[$text];
        }

        return array(
            'output' => array(
                'translate' => $result,
            ),
        );
    }
}