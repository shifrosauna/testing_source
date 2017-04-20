(function () {
    'use strict';

    angular.module('app.table.data', [])
        .controller('DataTableCtrl', ['$scope', '$filter', 'ngTableParams', '$http', '$templateCache', '$uibModal',
            function ($scope, $filter, ngTableParams, $http, $templateCache, $uibModal) {
                ;

                $scope.listData = [];
                $scope.List = [];

                $scope.columns = [
                    {title: 'Name', field: 'name', visible: true},
                    {title: 'Created', field: 'created_date', visible: true},
                    {title: 'Address', field: 'address', visible: true},
                    {title: 'Email', field: 'email', visible: true},
                    {title: 'Phone', field: 'phone', visible: true},
                    {title: 'Balance', field: 'balance', visible: true}
                ];

                $scope.searchStr = '';

                $scope.filters = {
                    str: ''
                };

                $scope.$watch('searchStr',
                    function (value) {
                        $scope.filters.str = value;
                    });

                var data = [];
                $scope.loading = true;
                $scope.getList = function () {
                    $http.get('datas/clients.json').success(function (response) {
                        $scope.loading = false;
                        data = response;
                        $scope.tableParams = new ngTableParams({
                            page: 1, // show first page
                            count: 50, // count per page
                            sorting: {
                                name: 'asc'     // initial sorting
                            },
                            filter: $scope.filters
                        }, {
                            total: data.length, // length of data
                            getData: function ($defer, params) {
                                //vmiert a binding nem mukodik a {$:'str'}-re... így nekunk kell ezt az objektumot eloallitani
                                var hack = params.filter().str;

                                var orderedData = params.filter() ? $filter('filter')(data, {$: hack}) : data;
                                orderedData = params.sorting() ? $filter('orderBy')(orderedData, params.orderBy()) : data;

                                $scope.users = orderedData.slice((params.page() - 1) * params.count(), params.page() * params.count());

                                params.total(orderedData.length); // set total for recalc pagination

                                $scope.pages = params.generatePagesArray(params.page(), params.total(), params.count());
                                $defer.resolve($scope.users);
                            }
                        });
                    });
                };

                $templateCache.put('ng-table/pager.html', '');
                $scope.getList();

                $scope.setAll = function (bool) {
                    for (var i = 0; i < $scope.users.length; i++) {
                        $scope.users[i].$selected = bool;
                    }
                    ;
                };

                $scope.editItem = function (item) {
                    item.$edit = true;
                    var modalInstance = $uibModal.open({
                        templateUrl: 'views/tables/datatable.details.html',
                        controller: function ($scope, $uibModalInstance, user) {
                            $scope.user = user;
                            $scope.cancel = function (e) {
                                $uibModalInstance.dismiss();
                            };
                            $scope.modify = function () {
                                $uibModalInstance.close($scope.user);
                            };
                        },
                        size: 'lg',
                        resolve: {
                            user: function () {
                                return angular.copy(item);
                            }
                        }
                    });
                    modalInstance.result.then(function (selectedItem) {
                        item.$edit = false;
                    }, function () {
                        item.$edit = false;
                    });
                };
            }]);

})();