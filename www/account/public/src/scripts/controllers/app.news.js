(function () {
    'use strict';

    const format = 'yyyy-MM-dd';

    var newsModule = angular.module('app.news', []);

    newsModule.controller('CreateNewsCtrl', function ($scope, toaster, $http) {

        $scope.format = format; // ISO formatted date

        $scope.popup = {
            opened: false
        };

        $scope.open = function () {
            $scope.popup.opened = true;
        };

        $scope.item = {
            date: new Date(),
            ruTitle: "",
            ruText: "",
            enTitle: "",
            enText: ""
        };

        $scope.createNews = function () {

            var data = {
                date: $scope.item.date,
                langs: {
                    en: {title: $scope.item.enTitle, description: $scope.item.enText},
                    ru: {title: $scope.item.ruTitle, description: $scope.item.ruText}
                }
            };

            $http
                .post('/news/create', data)
                .then(
                    function successCallback(response) {
                        toaster.pop('success', 'News is successfully created!');
                    }, function errorCallback(response) {
                        toaster.pop('error', 'News is not created!');
                    }
                );
        };

    });

    newsModule.controller('ListNewsCtrl', function ($scope, $http) {
        $http
            .get('/news/list')
            .then(
                function successCallback(response) {
                    console.log(response);
                    $scope.news = response.data;
                }, function errorCallback(response) {

                }
            );
    });

    newsModule.controller('ViewNewsCtrl', function ($scope, $state, $http) {
        $http
            .get('/news/view/' + $state.params.newsId)
            .then(
                function successCallback(response) {                    
                    $scope.item = response.data;
                    console.log($scope.item);
                }, function errorCallback(response) {

                }
            );
    });

    newsModule.controller('EditNewsCtrl', function ($scope, $state, toaster, $http, SweetAlert) {

        $scope.format = format;// ISO formatted date

        $scope.popup = {
            opened: false
        };

        $scope.open = function () {
            $scope.popup.opened = true;
        };

        $http
            .get('/news/edit/' + $state.params.newsId)
            .then(
                function successCallback(response) {
                    $scope.item = response.data;
                    $scope.item.date = new Date($scope.item.date);

                }, function errorCallback(response) {

                }
            );

        $scope.updateNews = function () {
            var data = {
                id: $state.params.newsId,
                date: $scope.item.date,
                langs: {
                    en: {title: $scope.item.langs.en.title, description: $scope.item.langs.en.description},
                    ru: {title: $scope.item.langs.ru.title, description: $scope.item.langs.ru.description}
                }
            };
            $http
                .post('/news/update', data)
                .then(
                    function successCallback(response) {
                        toaster.pop('success', 'News is succesfuly updated!');
                    }, function errorCallback(response) {
                        toaster.pop('error', 'News is NOT updated!');
                    }
                );
        };

        $scope.deleteNews = function () {

            SweetAlert.swal({
                title: "Are you sure?",
                text: "Your will not be able to recover this Item!",
                type: "warning",
                showCancelButton: true,
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "Yes, delete it!",
                closeOnConfirm: false
            }, function (isConfirm) {
                if (isConfirm) {
                    $http
                        .post('news/delete/' + $state.params.newsId)
                        .then(
                            function successCallback(response) {
                                SweetAlert.swal("Item are successfully deleted!");
                                window.location.href = '#/app/news/list';
                            }, function errorCallback(response) {
                                SweetAlert.swal("Item are not deleted!(Internal error)");
                            }
                        );
                }
            });
        };
    });

})();













