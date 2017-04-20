<?php

namespace Http\Account;

use App\BaseController;
use Domain\Offers\OffersService;
use Domain\Users\UsersService;

class OffersController extends BaseController {

    public function listAction() {

        // $_admin = UsersService::checkAccess('Offers', 'admin');
        // $offers = OffersService::findByUserId(UsersService::current()->getId(), $_admin);

        $offers = OffersService::findAll(['translates']);

        return OffersService::exportOffers($offers);
    }

    public function createAction() {

        $data = $this->request->input();
        OffersService::createOffer($data);

        return true;
    }

    public function editAction($id) {

        $offer = OffersService::findById(intval($id));

        return OffersService::exportOffer($offer);
    }

    public function viewAction($id = null) {

        $lang = UsersService::current()->getLang();
        $offer = OffersService::findById(intval($id), $lang, ['translates']);

        return OffersService::exportOffer($offer);
    }

    public function updateAction() {

        $data = $this->request->input();
        $offer = OffersService::findById(intval($data['id']));

        OffersService::updateOffer($offer, $data);

        return true;
    }

    public function deleteAction($id = null) {

        $offer = OffersService::findById(intval($id));

        OffersService::deleteOffer($offer);

        return true;
    }

    public function accessAction($id) {

        $offer = OffersService::findById(intval($id));
        OffersService::loadOptions($offer);

        $partners_nonapproved = array();
        $partners_approved = array();
        $partners_blocked = array();

        $partners = UsersService::findPartners();
        foreach ($partners as $partner) {
            if (in_array($partner->id, $offer->approved_affiliates)) {
                $partners_approved[] = $partner;
            } elseif (in_array($partner->id, $offer->blocked_affiliates)) {
                $partners_blocked[] = $partner;
            } else {
                $partners_nonapproved[] = $partner;
            }
        }

        return array(
            'offer'                => $offer,
            'partners_nonapproved' => $partners_nonapproved,
            'partners_approved'    => $partners_approved,
            'partners_blocked'     => $partners_blocked,
        );
    }

    public function accesssaveAction() {

        $offer_id = intval($_POST['offer_id']);
        $partner_id = intval($_POST['partner_id']);
        $status = $_POST['status'];

        $offer = OffersService::findById($offer_id);
        OffersService::accessOffer($offer, $partner_id, $status);

        return true;
    }

    public function autocompleteAction() {

        $offers = OffersService::findAllActive(['translates']);
        $lang = UsersService::current()->getLang();
        
        $output = array();
        foreach ($offers as $offer) {
            $output[] = array(
                'value' => $offer->id() . '. ' . $offer->translate($lang)->name(),
                'data'  => $offer->id(),
            );
        }

        return $output;
    }
}