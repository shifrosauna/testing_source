(function () {
    'use strict';

    angular.module('app.breadcrumb', [])
        .controller('BookingDayCtrl', function ($scope, $rootScope, $state, $stateParams, rooms) {
            $rootScope.reservationDate = new Date($stateParams.year, $stateParams.month - 1, $stateParams.day);

            if (!$scope.between($rootScope.reservationDate).length) {
                $state.go('^');
            }

            $scope.getRoom = function (id) {
                return _.findWhere(rooms, {roomId: parseInt(id)});
            }
        })
        .controller('BookingDetailCtrl', function ($scope, $stateParams, dateUtils, reservations, rooms) {
            $scope.addDays = dateUtils.addDays;
            $scope.reservation = _.findWhere(reservations, {reservationId: parseInt($stateParams.reservationId)});
            $scope.room = _.findWhere(rooms, {roomId: parseInt($scope.reservation.roomId)});
            $scope.dismiss = function () {
                $scope.$dismiss();
            };
        })
        .controller('BookingListCtrl', function ($scope, $rootScope, $state, dateUtils, reservations) {

            // Some hardcoded data ;
            $scope.reservations = reservations;

            $scope.$watch('reservationDate', function (newValue, oldValue) {
                $scope.dpModel = $rootScope.reservationDate;
            });


            $scope.$watch('dpModel', function (newValue, oldValue) {
                if (newValue && !angular.equals(newValue, oldValue)) {
                    $state.go('app.components.breadcrumb.booking.day', {
                        year: newValue.getFullYear(),
                        month: newValue.getMonth() + 1,
                        day: newValue.getDate()
                    });
                }
            });

            $scope.between = function (date) {
                return _.filter($scope.reservations, function (reservation) {
                    var from = reservation.from;
                    var to = dateUtils.addDays(reservation.nights, reservation.from);
                    return from <= date && date < to;
                });
            };

        })
        .controller('RoomDetailCtrl', function ($scope, $state, $stateParams, rooms) {
            $scope.rooms = rooms;
            if ($stateParams.from) {
                $scope.from = $stateParams.from.split('|')[0];
                $scope.reservationDate = new Date(parseInt($stateParams.from.split('|')[1]));
            }

            if ($stateParams.roomId) {
                $scope.room = _.findWhere(rooms, {roomId: parseInt($stateParams.roomId)});
                if ($scope.room) {
                    $scope.model = angular.copy($scope.room);
                } else {
                    $state.go('^');
                }

            }

            $scope.save = function () {
                if ($scope.model.roomId) {
                    angular.extend($scope.room, $scope.model);
                } else {
                    var ids = _.map(rooms, function (room) {
                        return room.roomId;
                    });
                    $scope.model.roomId = _.max(ids) + 1;
                    rooms.push($scope.model);
                }
                $state.go('^');
            }

        })
        .controller('RoomListCtrl', function ($scope, rooms) {
            $scope.rooms = rooms;
        })
        .value('rooms', [
            {roomId: 1, roomNumber: 101, type: 'Double'},
            {roomId: 2, roomNumber: 102, type: 'Double'},
            {roomId: 3, roomNumber: 103, type: 'Single'},
            {roomId: 4, roomNumber: 104, type: 'Double'}
        ])
        .factory('reservations', function (dateUtils) {
            return [
                {reservationId: 1, guestName: 'Robert Smith', roomId: '2', from: dateUtils.addDays(-1), nights: 3},
                {reservationId: 2, guestName: 'John Doe', roomId: '3', from: dateUtils.addDays(-8), nights: 5},
                {reservationId: 3, guestName: 'William Gordon', roomId: '1', from: dateUtils.addDays(3), nights: 6},
                {reservationId: 4, guestName: 'Michael Robinson', roomId: '2', from: dateUtils.addDays(6), nights: 2},
                {reservationId: 5, guestName: 'Tracy Marschall', roomId: '3', from: dateUtils.addDays(12), nights: 1}
            ];
        })
        .factory('dateUtils', function () {
            return {
                addDays: function (days, date) {
                    if (!date) {
                        var todayTime = new Date();
                        todayTime.setHours(0, 0, 0, 0);
                        date = new Date(todayTime);
                    }

                    var newDate = new Date(date);
                    newDate.setDate(date.getDate() + days);
                    return newDate;
                }
            }
        })
        .run(function ($rootScope, $state, $breadcrumb) {
            $rootScope.isActive = function (stateName) {
                return $state.includes(stateName);
            }
        });

})();
