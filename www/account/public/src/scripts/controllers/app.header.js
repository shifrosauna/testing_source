(function () {
    'use strict';

    angular.module('app.header', [])
        .controller('AppheaderCtrl', ['$scope', '$aside', '$rootScope', function ($scope, $aside, $rootScope) {
            $scope.user = $rootScope.user ? $rootScope.user : {login: 'noname'};
        }]);
})();