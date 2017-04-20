(function () {
    'use strict';

    angular.module('app.table.smart', [])
        .controller('SmartTableCtrl', function ($scope, $filter, $http, $templateCache, $timeout) {

            var nameList = ['Pierre', 'Pol', 'Jacques', 'Robert', 'Elisa'];
            var familyName = ['Dupont', 'Germain', 'Delcourt', 'bjip', 'Menez'];

            $scope.isLoading = false;
            $scope.rowCollection = [];


            function createRandomItem() {
                var
                    firstName = nameList[Math.floor(Math.random() * 4)],
                    lastName = familyName[Math.floor(Math.random() * 4)],
                    age = Math.floor(Math.random() * 100),
                    email = firstName + lastName + '@whatever.com',
                    balance = Math.random() * 3000;

                return {
                    firstName: firstName,
                    lastName: lastName,
                    age: age,
                    email: email,
                    balance: balance
                };
            }

            $scope.columns = ['firstName', 'lastName', 'age', 'email', 'balance'];

            for (var i = 0; i < 50; i++) {
                $scope.rowCollection.push(createRandomItem());
            }

            $scope.displayed = [];
            for (var j = 0; j < 50; j++) {
                $scope.displayed.push(createRandomItem());
            }


        })
        .directive('stPaginationScroll', ['$timeout', function (timeout) {
            return {
                require: 'stTable',
                link: function (scope, element, attr, ctrl) {
                    var itemByPage = 20;
                    var pagination = ctrl.tableState().pagination;
                    var lengthThreshold = 50;
                    var timeThreshold = 400;
                    var handler = function () {
                        //call next page
                        ctrl.slice(pagination.start + itemByPage, itemByPage);
                    };
                    var promise = null;
                    var lastRemaining = 9999;
                    var container = angular.element(element.parent());

                    container.bind('scroll', function () {
                        var remaining = container[0].scrollHeight - (container[0].clientHeight + container[0].scrollTop);

                        //if we have reached the threshold and we scroll down
                        if (remaining < lengthThreshold && (remaining - lastRemaining) < 0) {

                            //if there is already a timer running which has no expired yet we have to cancel it and restart the timer
                            if (promise !== null) {
                                timeout.cancel(promise);
                            }
                            promise = timeout(function () {
                                handler();

                                //scroll a bit up
                                container[0].scrollTop -= 500;

                                promise = null;
                            }, timeThreshold);
                        }
                        lastRemaining = remaining;
                    });
                }

            };
        }])
        .directive('pageSelect', function () {
            return {
                restrict: 'E',
                template: '<input type="text" class="select-page" ng-model="inputPage" ng-change="selectPage(inputPage)">',
                link: function (scope, element, attrs) {
                    scope.$watch('currentPage', function (c) {
                        scope.inputPage = c;
                    });
                }
            }
        });
})();

