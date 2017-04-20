<?php

namespace Http\Api;

use Domain\Offers\OffersService;
use Domain\Users\UsersService;

use App\Exceptions\BaseException;
use App\Exceptions\AccessDeniedException;
use App\Exceptions\EntityNotFoundException;
use App\Exceptions\NotFoundException;
use App\Exceptions\ValidateException;
use App\Exceptions\UserNotFoundException;

class ApkController extends \App\BaseController {

    public function uploadAction() {

        if (empty($_POST['user_id'])) {

            return array(
                'http_code'   => 401,
                'output_type' => 'json',
                'output'      => array(
                    'error' => 'Unauthorized',
                ),
            );
        }

        $user_id = intval($_POST['user_id']);

        if (empty($_POST['offer_id']) || empty($_FILES) || empty($_FILES['apk'])) {

            return array(
                'http_code'   => 400,
                'output_type' => 'json',
                'output'      => array(
                    'error' => 'Wrong data',
                ),
            );
        }

        if (!UsersService::checkUserAccess($user_id, 'Api\Apk', 'upload')) {

            return array(
                'http_code'   => 403,
                'output_type' => 'json',
                'output'      => array(
                    'error' => 'Access denied',
                ),
            );
        }

        $data = array(
            'user_id'  => $user_id,
            'offer_id' => intval($_POST['offer_id']),
            'apk'      => (!empty($_FILES) && !empty($_FILES['apk'])) ? $_FILES['apk'] : array(),
        );

        OffersService::multipleApkUpload($data);

        return array(
            'output_type' => 'json',
            'output'      => array(
                'status' => 'success',
            ),
        );
    }

    public function statusAction() {

        if (empty($_GET['offer_id'])) {

            return array(
                'http_code'   => 400,
                'output_type' => 'json',
                'output'      => array(
                    'error' => 'Wrong data',
                ),
            );
        }

        return array(
            'output_type' => 'json',
            'output'      => OffersService::multipleApkStatus(intval($_GET['offer_id'])),
        );
    }

    public function downloadAction() {

        if (empty($_GET['session_id'])) {

            return array(
                'http_code'   => 400,
                'output_type' => 'json',
                'output'      => array(
                    'error' => 'Wrong data',
                ),
            );
        }

        $apk = OffersService::multipleApkDownload($_GET['session_id']);

        if ($apk->status != 'SUCCESS' || !file_exists($apk->wrapped_filepath)) {
            return array(
                'http_code'   => 500,
                'output_type' => 'json',
                'output'      => array(
                    'status' => 'error',
                ),
            );
        }

        header('Content-Description: File Transfer');
        header('Content-Type: application/vnd.android.package-archive');
        header('Content-Disposition: attachment; filename="' . basename($apk->filename) . '"');
        header('Expires: 0');
        header('Cache-Control: must-revalidate');
        header('Pragma: public');
        header('Content-Length: ' . filesize($apk->wrapped_filepath));

        readfile($apk->wrapped_filepath);
        exit;
    }
}