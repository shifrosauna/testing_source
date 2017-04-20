(function () {
    'use strict';

    angular.module('app.ui.grid', ['ngTouch', 'ui.grid', 'ui.grid.exporter', 'ui.grid.selection', 'ui.grid.pagination', 'ui.grid.pinning'])
        .controller('TableUiGridCtrl', function ($scope, $http, $interval, $q) {


            var fakeI18n = function (title) {
                var deferred = $q.defer();
                $interval(function () {
                    deferred.resolve('col: ' + title);
                }, 1000, 1);
                return deferred.promise;
            };

            $scope.gridOptions = {
                exporterMenuCsv: false,
                enableGridMenu: true,
                enableFiltering: true,
                gridMenuTitleFilter: fakeI18n,
                columnDefs: [
                    {name: 'name'},
                    {name: 'email'},
                    {name: 'gender', enableHiding: false, enableFiltering: false},
                    {name: 'company'},
                    {name: 'balance', enableHiding: false, enableFiltering: false},
                ],
                gridMenuCustomItems: [
                    {
                        title: 'Rotate Grid',
                        action: function ($event) {
                            this.grid.element.toggleClass('rotated');
                        }
                    }
                ],
                onRegisterApi: function (gridApi) {
                    $scope.gridApi = gridApi;

                    // interval of zero just to allow the directive to have initialized
                    $interval(function () {
                        gridApi.core.addToGridMenu(gridApi.grid, [{title: 'Dynamic item'}]);
                    }, 0, 1);

                    gridApi.core.on.columnVisibilityChanged($scope, function (changedColumn) {
                        $scope.columnChanged = {name: changedColumn.colDef.name, visible: changedColumn.colDef.visible};
                    });
                }
            };

            $scope.gridOptions2 = {};
            $scope.gridOptions2.columnDefs = [
                {name: 'id', width: 50, enablePinning: false},
                {name: 'name', width: 100, pinnedLeft: true},
                {name: 'age', width: 100, pinnedRight: true},
                {name: 'address.street', width: 150},
                {name: 'address.city', width: 150},
                {name: 'address.state', width: 50},
                {name: 'address.zip', width: 50},
                {name: 'company', width: 100},
                {name: 'email', width: 100},
                {name: 'phone', width: 200},
                {name: 'about', width: 300},
                {name: 'friends[0].name', displayName: '1st friend', width: 150},
                {name: 'friends[1].name', displayName: '2nd friend', width: 150},
                {name: 'friends[2].name', displayName: '3rd friend', width: 150},
            ];

            $http.get('datas/complex.json')
                .success(function (data) {
                    $scope.gridOptions.data = data;
                    $scope.gridOptions2.data = data;
                });


        });
})();