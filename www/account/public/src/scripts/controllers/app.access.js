(function () {
    'use strict';

    var authModule = angular.module('app.access', []);

    authModule.controller('AccessCtrl', ['$scope', '$rootScope', '$localStorage', '$timeout', function ($scope, $rootScope, $localStorage, $timeout) {

    }]);

    authModule.controller('AccessLoginCtrl', ['$scope', 'authFactory', function ($scope, authFactory) {

        $scope.form = {
            email: "",
            pass: "",
            errors: {}
        };

        $scope.Login = function () {

            var data = {
                email: $scope.form.email,
                pass: $scope.form.pass
            };

            authFactory.login(data, function(errors){
                $scope.form.errors = errors ? errors : [];
            });
        };
    }]);

    authModule.controller('AccessLogoutCtrl', ['$scope', 'authFactory', function ($scope, authFactory) {

        $scope.Logout = function () {
            authFactory.logout()
        };
    }]);

    //заглушка фабрики, обращающейся к серверу для проверки авторизации
    authModule.factory('authFactory', ['$userProvider', '$http', '$location', '$rootScope', function ($userProvider, $http, $location, $rootScope) {

        var login = function (data, errorCallBack) {

            $http
                .post('/login', {email: data.email, pass: data.pass})
                .then(
                    function successCallback(response) {

                        if (response.data) {
                            $userProvider.setUser(response.data);
                            $rootScope.user = response.data;
                            $location.path('/app/dashboard');
                        }

                    }, function errorCallback(response) {

                        if (response.data) {
                            errorCallBack(response.data);
                        } else {
                            errorCallBack();
                        }
                    }
                );
        };

        var logout = function () {

            $http
                .post('/logout')
                .then(
                    function successCallback(response) {

                        if (response.data && response.data === true) {
                            $userProvider.setUser({});
                            $rootScope.user = {};
                            $location.path('/access/login');
                        }

                    }, function errorCallback() {

                    }
                );
        };

        return {
            login: login,
            logout: logout
        }
    }]);

    //провайдер информации о пользователе (роли, логин и тд)
    authModule.factory('$userProvider', function () {

        var user;
        var rolesEnum = {
            Admin: 0,
            User: 1
        };
        var setUser = function (u) {
            user = u;
        };
        var getUser = function () {
            return user;
        };

        return {
            getUser: getUser,
            setUser: setUser,
            rolesEnum: rolesEnum
        }
    });
})();