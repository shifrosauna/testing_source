(function () {
    'use strict';

    angular.module('app.form.wizard', [])
        .controller('FormWizardCtrl', function ($scope) {

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
        });
})();

