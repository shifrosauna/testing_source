(function () {
    'use strict';

    angular.module('app.dashboard', [])
        .controller('DashboardCtrl', ['$scope', '$location', 'toaster',
            function ($scope, $location, toaster) {

                $scope.todos = [
                    {
                        content: "Database migration",
                        done: false
                    },
                    {
                        content: "Fix asset nginx server",
                        done: false
                    },
                    {
                        content: "Bladecenter vmware upgrade",
                        done: true
                    },
                    {
                        content: "Learn NodeJS",
                        done: false
                    },
                    {
                        content: "Cisco edge router ospf problem",
                        done: true
                    },
                    {
                        content: "Habba babaaa",
                        done: true
                    },
                    {
                        content: "Because i'm happy",
                        done: true
                    },
                    {
                        content: "Fix bugs",
                        done: false
                    }
                ];

                $scope.projects = [
                    {
                        id: 1,
                        name: "SPA app",
                        priority: 5,
                        status: 55
                    },
                    {
                        id: 2,
                        name: "NodeJS proxy",
                        priority: 3,
                        status: 30
                    },
                    {
                        id: 3,
                        name: "Ionic mobile app",
                        priority: 2,
                        status: 70
                    },
                    {
                        id: 4,
                        name: "SCRUM app",
                        priority: 5,
                        status: 20
                    },
                    {
                        id: 5,
                        name: "CMS express",
                        priority: 5,
                        status: 20
                    },
                    {
                        id: 6,
                        name: "Android app",
                        priority: 2,
                        status: 60
                    },
                    {
                        id: 7,
                        name: "Cisco networks",
                        priority: 3,
                        status: 10
                    },
                    {
                        id: 8,
                        name: "Webdesign",
                        priority: 1,
                        status: 30
                    },
                    {
                        id: 9,
                        name: "Webdesign",
                        priority: 1,
                        status: 5
                    },
                    {
                        id: 10,
                        name: "Music app",
                        priority: 2,
                        status: 50
                    }
                ];

                $scope.addTodo = function () {
                    if ($scope.newTodo != "") {
                        $scope.todos.unshift({content: $scope.newTodo, done: false});
                        $scope.newTodo = "";
                    }
                };

                $scope.sparkline = {
                    tickets: {
                        options: {
                            type: 'bar',
                            barColor: '#3395ff',
                            barWidth: 8,
                            barSpacing: 15,
                            height: '90px'
                        },
                        data: [3, 4, 5, 6, 4, 3, 6, 7, 3, 2, 7, 8, 3, 2]
                    },
                    tasks: {
                        options: {
                            type: 'line',
                            width: '100%',
                            height: '100px',
                            lineColor: '#65c7f9',
                            lineWidth: 2,
                            fillColor: false,
                            highlightSpotColor: '#000',
                            spotColor: false,
                            minSpotColor: false,
                            maxSpotColor: false,
                            spotRadius: 0
                        },
                        data: [4, 2, 3, 4, 4, 2, 3, 4, 3, 5, 3, 2, 1, 4, 6, 7, 8, 5, 6, 7]
                    },
                    totalviews: {
                        options: {
                            lineColor: false,
                            fillColor: '#95e578',
                            height: '100px',
                            width: '100%',
                            spotColor: false,
                            minSpotColor: false,
                            maxSpotColor: false,
                            spotRadius: 0
                        },
                        data: [4, 6, 7, 4, 7, 3, 6, 2, 4, 4, 6, 2, 10, 6, 7, 4, 6, 7, 4, 7, 3, 6, 8, 3, 4, 6, 2, 10, 6, 7, 1, 2, 4, 8]
                    }
                };

                $scope.flot = {
                    options: {
                        grid: {
                            borderColor: '#eee',
                            borderWidth: 1,
                            color: '#ccc'
                        },
                        series: {
                            lines: {
                                show: false,
                                color: 'grey'
                            },
                            splines: {
                                show: true,
                                tension: 0.3,
                                lineWidth: 0.9,
                                fill: .3
                            }
                        }
                    },
                    data: [{
                        color: "#fd8aac",
                        data: [[1, 2], [2, 5], [3, 10], [4, 13], [5, 8], [6, 26], [7, 30], [8, 12], [9, 10], [10, 15], [11, 10], [12, 20], [13, 10], [14, 40], [15, 10], [16, 15], [17, 10], [18, 2]]
                    },
                        {
                            color: "#3395ff",
                            data: [[1, 1], [2, 2], [3, 5], [4, 7], [5, 4], [6, 13], [7, 15], [8, 6], [9, 5], [10, 7], [11, 5], [12, 10], [13, 5], [14, 20], [15, 5], [16, 7], [17, 5], [18, 1]]
                        }]
                };

                $scope.easyPieChart = {
                    1: {
                        options: {
                            animate: {
                                duration: 500,
                                enabled: true
                            },
                            size: 140, barColor: '#73dd4d', lineWidth: 3, scaleColor: '#ccc'
                        },
                        percent: 55
                    },
                    2: {
                        options: {
                            animate: {
                                duration: 500,
                                enabled: true
                            },
                            size: 140, barColor: '#fec07e', lineWidth: 3, scaleColor: '#ccc'
                        },
                        percent: 75
                    },
                    3: {
                        options: {
                            animate: {
                                duration: 500,
                                enabled: true
                            },
                            size: 140, barColor: '#fc5888', lineWidth: 3, scaleColor: '#ccc'
                        },
                        percent: 95
                    }
                };

                function getRandomdata() {
                    var randomData = [[], []];
                    var random = new Rickshaw.Fixtures.RandomData(30);
                    for (var i = 0; i < 30; i++) {
                        random.addData(randomData);
                    }
                    return randomData;
                }

                var randomData = getRandomdata();

                $scope.serverData = {
                    chartoptions: {
                        renderer: 'bar', height: 150
                    },
                    series: [{
                        data: randomData[0],
                        color: "#fec07e",
                        name: "Max treshold"
                    }, {
                        data: randomData[1],
                        color: "#fed9b1",
                        name: "Min treshold"
                    }],
                    options: {
                        hover: {
                            formatter: function (series, x, y) {
                                var date = '<span class="date">' + new Date(x * 100000).toUTCString() + '</span>';
                                var swatch = '<span class="detail_swatch" style="background-color: ' + series.color + '"></span>';
                                var content = swatch + series.name + ": " + parseInt(y) + '<br>' + date;
                                return content;
                            }
                        }
                    }
                };

                $scope.otherData = {
                    options: {
                        grid: {
                            borderColor: '#eee',
                            borderWidth: 1,
                            color: '#ccc'
                        },
                        series: {
                            lines: {
                                show: true,
                                color: 'grey'
                            }
                        },
                        legend: {
                            show: false
                        },
                        yaxis: {
                            //show: false
                        },
                        xaxis: {
                            //show: false
                        }
                    },
                    data: [{
                        shadowSize: 0,
                        color: "#b6f0ea",
                        data: [[1, 5], [2, 20], [3, 30], [4, 23], [5, 18], [6, 6], [7, 0], [8, 10], [9, 10], [10, 15], [11, 10], [12, 20], [13, 10], [14, 40], [15, 10], [16, 15], [17, 10], [18, 2]]
                    },
                        {
                            shadowSize: 0,
                            color: "#e2f2fd",
                            data: [[1, 1], [2, 2], [3, 5], [4, 7], [5, 4], [6, 13], [7, 15], [8, 6], [9, 5], [10, 7], [11, 5], [12, 10], [13, 5], [14, 20], [15, 5], [16, 7], [17, 5], [18, 1]]
                        }]
                };
            }]);
})();