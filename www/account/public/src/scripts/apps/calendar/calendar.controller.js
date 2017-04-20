(function () {
    'use strict';

    angular.module('calendar.controller', [])
        .controller('CalendarCtrl', ['$scope',
            function ($scope) {

                $scope.alertMessages = [];

                $scope.view = 'month';

                var date = new Date();
                var d = date.getDate();
                var m = date.getMonth();
                var y = date.getFullYear();

                $scope.changeTo = 'Hungarian';
                /* event source that pulls from google.com */
                $scope.eventSource = {
                    url: "http://www.google.com/calendar/feeds/usa__en%40holiday.calendar.google.com/public/basic",
                    className: 'gcal-event', // an option!
                    currentTimezone: 'America/Chicago' // an option!
                };
                /* event source that contains custom events on the scope */
                $scope.events = [
                    {title: 'All Day Event', start: new Date(y, m, 1)},
                    {
                        title: 'Long Event',
                        start: new Date(y, m, d - 5),
                        end: new Date(y, m, d - 2),
                        className: ['b-info']
                    },
                    {title: 'Go to the beach', start: new Date(y, m, d - 1), className: ['b-warning']},
                    {
                        id: 999,
                        title: 'Repeating Event',
                        start: new Date(y, m, d - 3, 16, 0),
                        allDay: false,
                        className: ['b-danger']
                    },
                    {
                        id: 999,
                        title: 'Repeating Event',
                        start: new Date(y, m, d + 4, 16, 0),
                        allDay: false,
                        className: ['b-danger']
                    },
                    {
                        title: 'Birthday Party',
                        start: new Date(y, m, d + 1, 19, 0),
                        end: new Date(y, m, d + 1, 22, 30),
                        allDay: false
                    },
                    {
                        title: 'Coffee',
                        start: new Date(y, m, d + 2, 9, 0),
                        end: new Date(y, m, d + 2, 12, 0),
                        allDay: false,
                        className: ['b-success']
                    },
                    {
                        title: 'Click for Google',
                        start: new Date(y, m, 28),
                        end: new Date(y, m, 29),
                        url: 'http://google.com/'
                    },
                    {title: 'Shopping', start: new Date(y, m + 1, 8)},
                ];
                /* event source that calls a function on every view switch */
                $scope.eventsF = function (start, end, callback) {
                    var s = new Date(start).getTime() / 1000;
                    var e = new Date(end).getTime() / 1000;
                    var m = new Date(start).getMonth();
                    var events = [{
                        title: 'Feed Me ' + m,
                        start: s + (50000),
                        end: s + (100000),
                        allDay: false,
                        className: ['customFeed']
                    }];
                    callback(events);
                };

                $scope.calEventsExt = {
                    color: '#f00',
                    textColor: 'yellow',
                    events: [
                        {
                            type: 'party',
                            title: 'Lunch',
                            start: new Date(y, m, d, 12, 0),
                            end: new Date(y, m, d, 14, 0),
                            allDay: false
                        },
                        {
                            type: 'party',
                            title: 'Lunch 2',
                            start: new Date(y, m, d, 12, 0),
                            end: new Date(y, m, d, 14, 0),
                            allDay: false
                        },
                        {
                            type: 'party',
                            title: 'Click for Google',
                            start: new Date(y, m, 28),
                            end: new Date(y, m, 29),
                            url: 'http://google.com/'
                        }
                    ]
                };
                /* alert on eventClick */
                $scope.alertOnEventClick = function (event, allDay, jsEvent, view) {
                    $scope.alertMessages.push(event.title + ' was clicked ');
                };
                /* alert on Drop */
                $scope.alertOnDrop = function (event, dayDelta, minuteDelta, allDay, revertFunc, jsEvent, ui, view) {
                    $scope.alertMessages.push('Event Droped to make dayDelta ' + event.start.format());
                };
                /* alert on Resize */
                $scope.alertOnResize = function (event, dayDelta, minuteDelta, revertFunc, jsEvent, ui, view) {
                    $scope.alertMessages.push('Event Resized to make dayDelta ' + event.start.format());
                };
                /* add and removes an event source of choice */
                $scope.addRemoveEventSource = function (sources, source) {
                    var canAdd = 0;
                    angular.forEach(sources, function (value, key) {
                        if (sources[key] === source) {
                            sources.splice(key, 1);
                            canAdd = 1;
                        }
                    });
                    if (canAdd === 0) {
                        sources.push(source);
                    }
                };
                /* add custom event*/
                $scope.addEvent = function () {
                    $scope.events.push({
                        title: 'New event',
                        start: new Date(y, m, d),
                        end: new Date(y, m, d + 1),
                        className: ['b-info']
                    });
                };
                /* remove event */
                $scope.remove = function (index) {
                    $scope.events.splice(index, 1);
                    $scope.renderCalender();
                };
                /* Change View */
                $scope.changeView = function (view, calendar) {
                    $scope.demoCalendar.fullCalendar('changeView', view);
                };
                /* Change View */
                $scope.renderCalender = function (calendar) {
                    $scope.demoCalendar.fullCalendar('render');
                };
                /* config object */
                $scope.uiConfig = {
                    calendar: {
                        height: 450,
                        editable: true,
                        header: {
                            //left: 'prev,next today',
                            left: 'title',
                            center: '',
                            right: 'today prev,next'
                            //right: 'month,agendaWeek,agendaDay'
                        },
                        eventClick: $scope.alertOnEventClick,
                        eventDrop: $scope.alertOnDrop,
                        eventResize: $scope.alertOnResize
                    }
                };

                $scope.changeLang = function () {
                    if ($scope.changeTo === 'Hungarian') {
                        $scope.uiConfig.calendar.dayNames = ["Vasárnap", "Hétfő", "Kedd", "Szerda", "Csütörtök", "Péntek", "Szombat"];
                        $scope.uiConfig.calendar.dayNamesShort = ["Vas", "Hét", "Kedd", "Sze", "Csüt", "Pén", "Szo"];
                        $scope.changeTo = 'English';
                    } else {
                        $scope.uiConfig.calendar.dayNames = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
                        $scope.uiConfig.calendar.dayNamesShort = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
                        $scope.changeTo = 'Hungarian';
                    }
                };

                //calendar.fullCalendar('changeView', 'agendaWeek');
                /* event sources array*/
                $scope.eventSources = [$scope.events];
                // $scope.eventSources2 = [$scope.calEventsExt, $scope.eventsF, $scope.events];

            }]);


})();