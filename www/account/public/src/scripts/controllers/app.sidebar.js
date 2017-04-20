(function () {
    'use strict';

    angular.module('app.sidebar', [])
        .controller('AppsidebarCtrl', ['$scope', '$rootScope', '$http', function ($scope, $rootScope, $http) {

            $scope.composeEmail = function () {
                $rootScope.$broadcast('composeEmail', {});
            };

            $scope.getList = function () {

                $http
                    .post('/profile/menu')
                    .then(
                        function successCallback(response) {
                            console.log(response);
                        }, function errorCallback(response) {
                            console.log(response);
                        }
                    );
            };

            $scope.getList();
        }]);
})();
