<?php

namespace Http\Tracker;

use App\BaseController;
use App\Exceptions\EntityNotFoundException;
use Domain\Offers\OffersService;

class IndexController extends BaseController {

    public function indexAction() {

        return [
            'output_type' => 'cli',
            'output'      => 'Wrong query',
        ];
    }

    /**
     * Основной метод трекера
     */
    public function clickAction() {

        // Разбор GET-параметров
        $offerId = $this->request->getInt('offer_id');
        $affId = $this->request->getInt('aff_id');

        if (empty($offerId) || empty($affId)) {

            return [
                'output_type' => 'cli',
                'output'      => 'Wrong params',
            ];
        }

        try {

            // ToDo
            // Получить настройки по офферу для конкретного партнера
            $offer = OffersService::findById($offerId);

        } catch (EntityNotFoundException $e) {

            // ToDo
            // log this

            return [
                'output_type' => 'cli',
                'output'      => 'Offer not found',
            ];
        }

        // ToDo
        // Проанализировать доступ партнера, таргетинг, лимиты по офферу
        // Принять решение

        // ToDo
        // Записать всё в базу (может быть асинхронно!)

        // ToDo
        // Отправить пользователя дальше
        $url = '/';
        return ['redirect' => $url];
    }

    /**
     * Получение отчета о конверсии
     */
    public function postbackAction() {

    }

    /**
     * Получение отчета о достижении цели
     */
    public function goalAction() {

    }

    /**
     * Получение отчета о показах
     */
    public function impressionAction() {

    }
}