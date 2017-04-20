<?php

namespace Http\Cli;

use App\BaseController;
use Domain\Offers\OffersService;

class OffersController extends BaseController {

    public function settingsAction() {

        $offers = OffersService::findAll();
        echo 'offers: ' . count($offers) . PHP_EOL;

        // ToDo
        // Get $offersSettings: trackings, goals, users access, limits

        // ToDo
        // Send $offersSettings to tracker
    }
}