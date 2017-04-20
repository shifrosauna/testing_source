(function () {
    'use strict';

    var offersModule = angular.module('app.offers', []);

    offersModule.controller('CreateOffersCtrl', function ($scope, FileUploader, $http, toaster, $state, SweetAlert) {

        $scope.form = {
            translates: {
                ru: {lang: "ru"},
                en: {lang: "en"}
            },
            tracking: [
                {}
            ]
        };


        //Добавление Tracking-формы
        $scope.add = function () {
            $scope.form.tracking.push({})
        };

        //Добавление Goal-формы
        $scope.addGoal = function () {
            if ($scope.form.goals) {
                $scope.form.goals.push({
                    translates: {
                        ru: {lang: "ru"},
                        en: {lang: "en"}
                    }
                })
            } else {
                $scope.form.goals = [
                    {
                        translates: {
                            ru: {lang: "ru"},
                            en: {lang: "en"}
                        }
                    }
                ];
            }
        };

        $scope.deleteGoal = function (index) {
            $scope.form.goals.splice(index, 1);
        };

        $scope.deleteTracking = function (index) {
            $scope.form.tracking.splice(index, 1);
        };


        // TODO: FILE UPLOADER
        $scope.uploader = new FileUploader({
            url: 'upload.php'
        });

        //NEXT PREVIOUS

        $scope.actualStep = 1;

        $scope.data = {};

        $scope.wizard = {};

        $scope.next = function (next) {
            $scope.actualStep = next;
        };

        $scope.prev = function (prev) {
            $scope.actualStep = prev;
        };

        $scope.finish = function () {
            $scope.finished = true;
        };

        $scope.jump = function (step) {
            var obj = 'step' + step.toString();
            if ($scope.wizard[obj] != undefined && $scope.wizard[obj].$valid) {
                $scope.actualStep = step;
            }
        };

        // TEMPLATES
        $scope.statusList = [
            {value: "active", name: "активен"},
            {value: "paused", name: "приостановлен"},
            {value: "pending", name: "на стадии ожидания"},
            {value: "deleted", name: "удален"}
        ];

        $scope.availabilityList = [
            {value: "open", name: "открытый"},
            {value: "alert", name: "по заявкам"},
            {value: "private", name: "приватный"}
        ];

        $scope.advertisers = [
            {id: 1, name: "adv"},
            {id: 2, name: "advertiser"},
            {id: 3, name: "рекл"}
        ];

        $scope.currencyList = ["RUB", "USD", "EUR"];

        $scope.devicesList = ["Iphone", "Ipad", "Android", "IOS", "BlackBerry OS"];

        $scope.countries = ["AF", "AL", "RU"];

        $scope.getOffer = function (offerId) {

            if (offerId) {

                $scope.create = false;

                $http
                    .get('/offers/edit/' + offerId)
                    .then(
                        function successCallback(response) {
                            $scope.form = response.data;
                        }
                    );

            } else {

                $scope.create = true;
            }
        };

        //Создать оффер
        $scope.createOffers = function () {

            $http
                .post('/offers/create', $scope.form)
                .then(
                    function successCallback(response) {
                        toaster.pop('success', 'Offer is successfully created!');
                    }, function errorCallback(response) {
                        toaster.pop('error', 'Offer is not created!');
                    }
                );

        };

        // Обновить Оффер
        $scope.updateOffer = function () {

            $http
                .post('/offers/update', $scope.form)
                .then(
                    function successCallback(response) {
                        toaster.pop('success', 'Offer is succesfuly updated!');
                    }, function errorCallback(response) {
                        toaster.pop('error', 'Offer is NOT updated!');
                    }
                );

        };

        //Удалить оффер
        $scope.deleteOffer = function () {

            SweetAlert.swal({
                title: "Are you sure?",
                text: "Your will not be able to recover this Offer!",
                type: "warning",
                showCancelButton: true,
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "Yes, delete it!",
                closeOnConfirm: false
            }, function (isConfirm) {
                if (isConfirm) {
                    $http
                        .post('offers/delete/' + $state.params.offerId)
                        .then(
                            function successCallback(response) {
                                SweetAlert.swal("Offer are successfully deleted!");
                                window.location.href = '#/app/offers/list';
                            }, function errorCallback(response) {
                                SweetAlert.swal("Offer are not deleted!(Internal error)");
                            }
                        );
                }
            });
        };

        $scope.getOffer($state.params.offerId);
    });

    offersModule.controller('ListOffersCtrl', function ($scope, $http) {

        $http
            .get('/offers/list')
            .then(
                function successCallback(response) {
                    $scope.offers = response.data;
                }
            );
    });

    offersModule.controller('ViewOffersCtrl', function ($scope, $state, $http) {

        $http
            .get('/offers/view/' + $state.params.offerId)
            .then(
                function successCallback(response) {
                    $scope.offer = response.data;
                }
            );
    });

})();