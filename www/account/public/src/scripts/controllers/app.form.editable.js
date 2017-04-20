(function () {
    'use strict';

    angular.module('app.form.editable', [])
        .run(function (editableOptions) {
            editableOptions.theme = 'bs3';
        })
        .controller('EditableFormCtrl', ['$scope', '$filter', '$http',
            function ($scope, $filter, $http) {
                $scope.user = {
                    id: 1,
                    name: 'awesome user',
                    status: 2,
                    group: 4,
                    groupName: 'admin'
                };

                $scope.user2 = {
                    email: 'email@example.com',
                    tel: '123-45-67',
                    number: 29,
                    range: 10,
                    url: 'http://example.com',
                    search: 'blabla',
                    color: '#6a4415',
                    date: null,
                    time: '12:30',
                    datetime: null,
                    month: null,
                    week: null
                };

                $scope.user3 = {
                    desc: 'Awesome user \ndescription!'
                };
                $scope.user4 = {
                    remember: true
                };

                $scope.user5 = {
                    status: [2, 3]
                };

                $scope.user6 = {
                    status: 2
                };

                $scope.user7 = {
                    dob: new Date(1984, 4, 15)
                };

                $scope.user8 = {
                    time: new Date(1984, 4, 15, 19, 20)
                };


                $scope.user9 = {
                    state: 'Arizona'
                };


                $scope.statuses = [
                    {value: 1, text: 'status1'},
                    {value: 2, text: 'status2'},
                    {value: 3, text: 'status3'},
                    {value: 4, text: 'status4'}
                ];

                $scope.statuses2 = [
                    {value: 1, text: 'status1'},
                    {value: 2, text: 'status2'},
                    {value: 3, text: 'status3'}
                ];

                $scope.groups = [];
                $scope.loadGroups = function () {
                    $scope.groups = [
                        {id: 1, text: 'Owner'},
                        {id: 2, text: 'Publisher'},
                        {id: 3, text: 'User'},
                        {id: 4, text: 'Admin'}
                    ];
                    /*return $scope.groups.length ? null : $http.get('/groups').success(function(data) {
                     $scope.groups = data;
                     });*/
                };

                $scope.showGroup = function () {
                    if ($scope.groups.length) {
                        var selected = $filter('filter')($scope.groups, {id: $scope.user.group});
                        return selected.length ? selected[0].text : 'Not set';
                    } else {
                        return $scope.user.groupName;
                    }
                };

                $scope.checkName = function (data) {
                    if (data !== 'awesome' && data !== 'error') {
                        return "Username should be `awesome` or `error`";
                    }
                };

                $scope.saveUser = function () {
                    // $scope.user already updated!
                    /*return $http.post('/saveUser', $scope.user).error(function(err) {
                     if (err.field && err.msg) {
                     // err like {field: "name", msg: "Server-side error for this username!"} 
                     $scope.editableForm.$setError(err.field, err.msg);
                     } else {
                     // unknown error
                     $scope.editableForm.$setError('name', 'Unknown error!');
                     }
                     });*/
                };

                $scope.showStatus = function () {
                    var selected = $filter('filter')($scope.statuses, {value: $scope.user.status});
                    return ($scope.user.status && selected.length) ? selected[0].text : 'Not set';
                };

                $scope.showStatus2 = function () {
                    var selected = [];
                    angular.forEach($scope.statuses, function (s) {
                        if ($scope.user5.status.indexOf(s.value) >= 0) {
                            selected.push(s.text);
                        }
                    });
                    return selected.length ? selected.join(', ') : 'Not set';
                };

                $scope.showStatus3 = function () {
                    var selected = $filter('filter')($scope.statuses, {value: $scope.user6.status});
                    return ($scope.user.status && selected.length) ? selected[0].text : 'Not set';
                };


                $scope.states = ['Alabama', 'Alaska', 'Arizona', 'Arkansas', 'California', 'Colorado', 'Connecticut', 'Delaware', 'Florida', 'Georgia', 'Hawaii', 'Idaho', 'Illinois', 'Indiana', 'Iowa', 'Kansas', 'Kentucky', 'Louisiana', 'Maine', 'Maryland', 'Massachusetts', 'Michigan', 'Minnesota', 'Mississippi', 'Missouri', 'Montana', 'Nebraska', 'Nevada', 'New Hampshire', 'New Jersey', 'New Mexico', 'New York', 'North Dakota', 'North Carolina', 'Ohio', 'Oklahoma', 'Oregon', 'Pennsylvania', 'Rhode Island', 'South Carolina', 'South Dakota', 'Tennessee', 'Texas', 'Utah', 'Vermont', 'Virginia', 'Washington', 'West Virginia', 'Wisconsin', 'Wyoming'];
            }]);

})();
