(function () {
    'use strict';

    angular.module('app.dashboard.v3', [])
        .controller('DashboardV3Ctrl', ['$scope', '$location', 'toaster', '$timeout', '$rootScope',
            function ($scope, $location, toaster, $timeout, $rootScope) {

                $scope.icons = {
                    gray: 'http://flat-edge.com/assets/up_pin.png',
                    red: 'http://flat-edge.com/assets/down_pin.png',
                };

                $rootScope.app.settings.asideDocked = true;

                $scope.$on('$destroy', function () {
                    $rootScope.app.settings.asideDocked = false;
                });

                $scope.showServers = true;

                $scope.zoom = 11;

                $scope.options = {
                    map: {
                        center: new google.maps.LatLng(52.3702157, 4.895167899999933),
                        zoom: $scope.zoom,
                        mapTypeId: google.maps.MapTypeId.ROADMAP,
                        disableDefaultUI: true,
                        styles: [{
                            featureType: 'water',
                            elementType: 'all',
                            stylers: [{
                                hue: '#e9ebed'
                            }, {
                                saturation: -78
                            }, {
                                lightness: 67
                            }, {
                                visibility: 'simplified'
                            }]
                        }, {
                            featureType: 'landscape',
                            elementType: 'all',
                            stylers: [{
                                hue: '#ffffff'
                            }, {
                                saturation: -100
                            }, {
                                lightness: 100
                            }, {
                                visibility: 'simplified'
                            }]
                        }, {
                            featureType: 'road',
                            elementType: 'geometry',
                            stylers: [{
                                hue: '#bbc0c4'
                            }, {
                                saturation: -93
                            }, {
                                lightness: 31
                            }, {
                                visibility: 'simplified'
                            }]
                        }, {
                            featureType: 'poi',
                            elementType: 'all',
                            stylers: [{
                                hue: '#ffffff'
                            }, {
                                saturation: -100
                            }, {
                                lightness: 100
                            }, {
                                visibility: 'off'
                            }]
                        }, {
                            featureType: 'road.local',
                            elementType: 'geometry',
                            stylers: [{
                                hue: '#e9ebed'
                            }, {
                                saturation: -90
                            }, {
                                lightness: -8
                            }, {
                                visibility: 'simplified'
                            }]
                        }, {
                            featureType: 'transit',
                            elementType: 'all',
                            stylers: [{
                                hue: '#e9ebed'
                            }, {
                                saturation: 10
                            }, {
                                lightness: 69
                            }, {
                                visibility: 'on'
                            }]
                        }, {
                            featureType: 'administrative.locality',
                            elementType: 'all',
                            stylers: [{
                                hue: '#2c2e33'
                            }, {
                                saturation: 7
                            }, {
                                lightness: 19
                            }, {
                                visibility: 'on'
                            }]
                        }, {
                            featureType: 'road',
                            elementType: 'labels',
                            stylers: [{
                                hue: '#bbc0c4'
                            }, {
                                saturation: -93
                            }, {
                                lightness: 31
                            }, {
                                visibility: 'on'
                            }]
                        }, {
                            featureType: 'road.arterial',
                            elementType: 'labels',
                            stylers: [{
                                hue: '#bbc0c4'
                            }, {
                                saturation: -93
                            }, {
                                lightness: -2
                            }, {
                                visibility: 'simplified'
                            }]
                        }]
                    },
                    highlighted: {
                        icon: $scope.icons.red
                    },
                    unhighlighted: {
                        icon: $scope.icons.gray
                    },
                };

                function getRandomData() {
                    var randData = [];
                    for (var i = 0; i < 24; i++) {
                        randData.push(~~(Math.random() * (6 - 1 + 1)) + 1);
                    }
                    return randData;
                }

                function getRandomCoord(lat, lng) {
                    var latO = 52.3702157;
                    var lngO = 4.895167899999933;
                    return {"lat": latO + lat, "lng": lngO + lng};
                }

                $scope.getMarkerOptions = function (datacenter) {
                    var opts = {title: datacenter.name};
                    if (datacenter.up) {
                        return angular.extend(opts, $scope.options.unhighlighted);
                    }
                    else {
                        return angular.extend(opts, $scope.options.highlighted);
                    }

                };

                $timeout(function () {
                    //fix grey area bug
                    $scope.mapLoaded = true;
                }, 1000);

                $scope.sparkline = {
                    options: {
                        type: 'bar',
                        barColor: '#eaeaea',
                        barWidth: 12,
                        barSpacing: 2,
                        height: '30px'
                    }
                };


                $scope.dataCenters = [
                    {
                        id: 1,
                        name: 'BladeCenter #1',
                        description: 'BigData server cluster',
                        updated: '3 hours ago',
                        up: true,
                        data: getRandomData(),
                        coord: getRandomCoord(0.1, -0.02)
                    },
                    {
                        id: 2,
                        name: 'Vmware virtual park',
                        description: 'Critical services',
                        updated: '1 hours ago',
                        up: true,
                        data: getRandomData(),
                        coord: getRandomCoord(-0.01, 0.05)
                    },
                    {
                        id: 3,
                        name: 'Test environment',
                        description: 'Dummy routers',
                        updated: '50 min ago',
                        up: false,
                        data: getRandomData(),
                        coord: getRandomCoord(0.02, 0.01)
                    },
                    {
                        id: 4,
                        name: 'Hadoop cluster',
                        description: 'Webservices',
                        updated: '10 sec ago',
                        up: true,
                        data: getRandomData(),
                        coord: getRandomCoord(0.01, 0.05)
                    },
                    {
                        id: 5,
                        name: 'BladeCenter #2',
                        description: 'Assets',
                        updated: '20 min ago',
                        up: false,
                        data: getRandomData(),
                        coord: getRandomCoord(-0.07, -0.08)
                    },
                    {
                        id: 6,
                        name: 'BigData clusters',
                        description: 'Lorem ipsums',
                        updated: '10 sec ago',
                        up: true,
                        data: getRandomData(),
                        coord: getRandomCoord(-0.01, 0.08)
                    },
                    {
                        id: 7,
                        name: 'Cisco ASR-100',
                        description: 'Edge network',
                        updated: '10 sec ago',
                        up: true,
                        data: getRandomData(),
                        coord: getRandomCoord(-0.025, 0.033)
                    },
                    {
                        id: 8,
                        name: 'Hadoop cluster #3',
                        description: 'Webservices + assets',
                        updated: '10 sec ago',
                        up: false,
                        data: getRandomData(),
                        coord: getRandomCoord(-0.005, -0.003)
                    },
                    {
                        id: 9,
                        name: 'BladeCenter #1',
                        description: 'BigData server cluster',
                        updated: '3 hours ago',
                        up: true,
                        data: getRandomData(),
                        coord: getRandomCoord(-0.0999, -0.0099)
                    },
                    {
                        id: 10,
                        name: 'Vmware virtual park',
                        description: 'Critical services',
                        updated: '1 hours ago',
                        up: true,
                        data: getRandomData(),
                        coord: getRandomCoord(0.03, 0.09)
                    },
                    {
                        id: 11,
                        name: 'Test environment',
                        description: 'Dummy routers',
                        updated: '50 min ago',
                        up: false,
                        data: getRandomData(),
                        coord: getRandomCoord(0.06, -0.08)
                    },
                    {
                        id: 12,
                        name: 'BladeCenter #1',
                        description: 'BigData server cluster',
                        updated: '3 hours ago',
                        up: true,
                        data: getRandomData(),
                        coord: getRandomCoord(0.09, 0.02)
                    },
                    {
                        id: 13,
                        name: 'Vmware virtual park',
                        description: 'Critical services',
                        updated: '1 hours ago',
                        up: true,
                        data: getRandomData(),
                        coord: getRandomCoord(0.03, 0.06)
                    },
                ];


            }]);


})();