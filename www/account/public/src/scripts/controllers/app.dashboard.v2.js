(function () {
    'use strict';

    angular.module('app.dashboard.v2', [])
        .controller('DashboardV2Ctrl', ['$scope', '$location', 'toaster',
            function ($scope, $location, toaster) {

                var randomData = [[], []];
                $scope.mainChartData = [];
                $scope.mainChartOptions = {renderer: 'area', height: 360};

                var random = new Rickshaw.Fixtures.RandomData(40);
                for (var i = 0; i < 40; i++) {
                    random.addData(randomData);
                }

                $scope.mainChartData = [{
                    data: randomData[0],
                    color: "#3395ff",
                    name: "New users"
                }, {
                    data: randomData[1],
                    color: "#fd8aac",
                    name: "Returning users"
                }];

                $scope.mainDataOptions = {
                    hover: {
                        formatter: function (series, x, y) {
                            var date = '<span class="date">' + new Date(x * 1000).toUTCString() + '</span>';
                            var swatch = '<span class="detail_swatch" style="background-color: ' + series.color + '"></span>';
                            var content = swatch + series.name + ": " + parseInt(y) + '<br>' + date;
                            return content;
                        }
                    },
                    yAxis: {
                        tickFormat: 'formatKMBT'
                    }
                };
                function euroFormatter(v, axis) {
                    return v.toFixed(axis.tickDecimals);
                }

                var position = 'right';
                $scope.flotOptions = {
                    series: {
                        lines: {
                            show: true,
                            lineWidth: 1,
                            fill: true,
                            fillColor: {
                                colors: [
                                    {
                                        opacity: 0.0
                                    },
                                    {
                                        opacity: 0.0
                                    }
                                ]
                            }
                        }
                    },
                    xaxes: [
                        {
                            mode: 'time'
                        }
                    ],
                    xaxis: {
                        tickDecimals: 0
                    },
                    colors: ["#aaa"],
                    grid: {
                        color: "#ccc",
                        hoverable: true,
                        clickable: true,
                        tickColor: "#eee",
                        borderWidth: 0
                    },
                    legend: {
                        show: false
                    },
                    tooltip: true,
                    tooltipOpts: {
                        content: "x: %x, y: %y"
                    }

                };

                function getRandomDatas(min, max, now) {
                    var $Return = [];
                    for (var i = 0; i < 100; i++) {
                        $Return.push([Math.floor(now + i * 100000000), ~~(Math.random() * (max - min + 1)) + min]);
                    }
                    return $Return;
                }
                ;

                $scope.flotData = [
                    {
                        shadowSize: 0,
                        label: "line",
                        color: "#3395ff",
                        data: getRandomDatas(50, 80, Date.now())
                    }
                ];

                $scope.flotData2 = [
                    {
                        shadowSize: 0,
                        label: "line",
                        color: "#fd8aac",
                        data: getRandomDatas(20, 70, Date.now())
                    }
                ];

                $scope.tileData = {
                    1: {
                        options: {
                            type: 'line',
                            width: '100%',
                            height: '50px',
                            lineColor: '#3395ff',
                            lineWidth: 2,
                            fillColor: false,
                            highlightSpotColor: '#000',
                            spotColor: false,
                            minSpotColor: false,
                            maxSpotColor: false,
                            spotRadius: 0
                        },
                        data: [4, 2, 3, 4, 4, 2, 3, 4, 3, 5, 3, 2, 1]
                    },
                    2: {
                        options: {
                            type: 'line',
                            width: '100%',
                            height: '50px',
                            lineColor: '#3395ff',
                            lineWidth: 2,
                            fillColor: false,
                            highlightSpotColor: '#000',
                            spotColor: false,
                            minSpotColor: false,
                            maxSpotColor: false,
                            spotRadius: 0
                        },
                        data: [4, 3, 5, 3, 2, 1, 4, 2, 3, 4, 4, 2, 3]
                    },
                    3: {
                        options: {
                            type: 'line',
                            width: '100%',
                            height: '50px',
                            lineColor: '#3395ff',
                            lineWidth: 2,
                            fillColor: false,
                            highlightSpotColor: '#000',
                            spotColor: false,
                            minSpotColor: false,
                            maxSpotColor: false,
                            spotRadius: 0
                        },
                        data: [0, 2, 0, 4, 4, 0, 3, 4, 0, 0, 0, 0, 0]
                    },
                    4: {
                        options: {
                            type: 'line',
                            width: '100%',
                            height: '50px',
                            lineColor: '#3395ff',
                            lineWidth: 2,
                            fillColor: false,
                            highlightSpotColor: '#000',
                            spotColor: false,
                            minSpotColor: false,
                            maxSpotColor: false,
                            spotRadius: 0
                        },
                        data: [4, 2, 3, 1, 2, 1, 3, 1, 3, 1, 1, 1, 0]
                    }
                };
            }]);

})();