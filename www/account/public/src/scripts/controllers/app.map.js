(function () {
    'use strict';

    angular.module('app.maps', [])
        .controller('MapsCtrl', function ($scope, $filter, $stateParams, $state) {
            $scope.icons = {
                gray: 'http://maps.gstatic.com/mapfiles/ridefinder-images/mm_20_gray.png',
                red: 'http://maps.gstatic.com/mapfiles/ridefinder-images/mm_20_red.png',
            }

            $scope.options = {
                map: {
                    center: new google.maps.LatLng(0, 0),
                    zoom: 3,
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

            $scope.filters = {
                name: null,
                male: true,
                female: true
            }

            $scope.getMarkerOptions = function (person) {
                var opts = {title: person.name};
                if (person.id in $scope.filteredPeople) {
                    return angular.extend(opts, $scope.options.highlighted);
                } else {
                    return angular.extend(opts, $scope.options.unhighlighted);
                }
            };

            $scope.filterPeople = function () {
                $scope.filteredPeople = {};
                angular.forEach($scope.people, function (person) {
                    var nameMatch = ($scope.filters.name) ? ~person.name.indexOf($scope.filters.name) : true;
                    var isMale = person.gender === 'male';
                    var genderMatch = ($scope.filters.male && isMale) ||
                        ($scope.filters.female && !isMale);
                    if (nameMatch && genderMatch) {
                        $scope.filteredPeople[person.id] = person;
                    }
                });
                $scope.$broadcast('gmMarkersUpdate', 'people');
            };

            $scope.$watch('people', function () {
                $scope.filterPeople();
            });

            $scope.people = [{
                "id": 1,
                "name": "Gianna Hodges",
                "gender": "male",
                "location": {"lat": 4, "lng": 21}
            }, {
                "id": 2,
                "name": "Isabella Davidson",
                "gender": "female",
                "location": {"lat": 21, "lng": -11}
            }, {"id": 3, "name": "Aubrey Mercer", "gender": "female", "location": {"lat": -13, "lng": -22}}, {
                "id": 4,
                "name": "Hailey Milton",
                "gender": "female",
                "location": {"lat": -18, "lng": -17}
            }, {"id": 5, "name": "Charlotte Davidson", "gender": "female", "location": {"lat": 18, "lng": 7}}, {
                "id": 6,
                "name": "Isabella Higgins",
                "gender": "male",
                "location": {"lat": -15, "lng": -23}
            }, {"id": 7, "name": "Riley Brooks", "gender": "male", "location": {"lat": 3, "lng": 8}}, {
                "id": 8,
                "name": "Jessica Oldridge",
                "gender": "female",
                "location": {"lat": -25, "lng": -13}
            }, {"id": 9, "name": "Gianna Sheldon", "gender": "male", "location": {"lat": 9, "lng": 21}}, {
                "id": 10,
                "name": "Zoey Cook",
                "gender": "female",
                "location": {"lat": 16, "lng": 18}
            }, {"id": 11, "name": "Lily Turner", "gender": "male", "location": {"lat": 3, "lng": -7}}, {
                "id": 12,
                "name": "Riley Hardman",
                "gender": "male",
                "location": {"lat": 19, "lng": -14}
            }, {"id": 13, "name": "Bella Clapton", "gender": "female", "location": {"lat": 1, "lng": -24}}, {
                "id": 14,
                "name": "Trinity Higgins",
                "gender": "male",
                "location": {"lat": 2, "lng": -17}
            }, {"id": 15, "name": "Sydney Neal", "gender": "male", "location": {"lat": 17, "lng": 15}}, {
                "id": 16,
                "name": "Bailey Ford",
                "gender": "female",
                "location": {"lat": 9, "lng": -7}
            }, {"id": 17, "name": "Hannah Hodges", "gender": "male", "location": {"lat": -1, "lng": -21}}, {
                "id": 18,
                "name": "Evelyn Sherlock",
                "gender": "female",
                "location": {"lat": -3, "lng": -7}
            }, {"id": 19, "name": "Evelyn Nelson", "gender": "male", "location": {"lat": 20, "lng": 15}}, {
                "id": 20,
                "name": "Maya Gibbs",
                "gender": "male",
                "location": {"lat": 4, "lng": 12}
            }, {"id": 21, "name": "Sofia Carter", "gender": "female", "location": {"lat": -13, "lng": -18}}, {
                "id": 22,
                "name": "Victoria Conors",
                "gender": "male",
                "location": {"lat": -13, "lng": 15}
            }, {
                "id": 23,
                "name": "Savannah Galbraith",
                "gender": "female",
                "location": {"lat": 15, "lng": -2}
            }, {"id": 24, "name": "Eva Brooks", "gender": "female", "location": {"lat": -6, "lng": -7}}, {
                "id": 25,
                "name": "Caroline White",
                "gender": "female",
                "location": {"lat": -10, "lng": 9}
            }, {
                "id": 26,
                "name": "Audrey WifKinson",
                "gender": "female",
                "location": {"lat": -22, "lng": -2}
            }, {"id": 27, "name": "Faith Brown", "gender": "male", "location": {"lat": 10, "lng": -7}}, {
                "id": 28,
                "name": "Serenity Nash",
                "gender": "male",
                "location": {"lat": 4, "lng": 5}
            }, {"id": 29, "name": "Mariah Nathan", "gender": "female", "location": {"lat": 6, "lng": 19}}, {
                "id": 30,
                "name": "Makayla White",
                "gender": "female",
                "location": {"lat": 0, "lng": 20}
            }, {
                "id": 31,
                "name": "Katherine Thornton",
                "gender": "female",
                "location": {"lat": -9, "lng": 14}
            }, {"id": 32, "name": "Nevaeh Cramer", "gender": "female", "location": {"lat": 9, "lng": -18}}, {
                "id": 33,
                "name": "Valeria Hoggarth",
                "gender": "male",
                "location": {"lat": 20, "lng": 17}
            }, {
                "id": 34,
                "name": "Aaliyah Carrington",
                "gender": "male",
                "location": {"lat": 23, "lng": 13}
            }, {"id": 35, "name": "Aaliyah Gilmore", "gender": "female", "location": {"lat": -25, "lng": 6}}, {
                "id": 36,
                "name": "Faith Wesley",
                "gender": "male",
                "location": {"lat": -1, "lng": -11}
            }, {"id": 37, "name": "Emily Bush", "gender": "male", "location": {"lat": -24, "lng": 19}}, {
                "id": 38,
                "name": "Jessica Gardner",
                "gender": "female",
                "location": {"lat": 12, "lng": -22}
            }, {
                "id": 39,
                "name": "Elizabeth Crossman",
                "gender": "female",
                "location": {"lat": -3, "lng": -19}
            }, {"id": 40, "name": "Payton Ward", "gender": "male", "location": {"lat": -22, "lng": -3}}, {
                "id": 41,
                "name": "Jocelyn Freeman",
                "gender": "female",
                "location": {"lat": 11, "lng": -15}
            }, {
                "id": 42,
                "name": "Serenity Hoggarth",
                "gender": "female",
                "location": {"lat": 5, "lng": -17}
            }, {"id": 43, "name": "Kayla Vaughan", "gender": "female", "location": {"lat": 20, "lng": 9}}, {
                "id": 44,
                "name": "Arianna Hancock",
                "gender": "male",
                "location": {"lat": 25, "lng": 3}
            }, {"id": 45, "name": "Katherine Haig", "gender": "male", "location": {"lat": -2, "lng": -12}}, {
                "id": 46,
                "name": "Zoe Gerald",
                "gender": "male",
                "location": {"lat": -12, "lng": 8}
            }, {"id": 47, "name": "Sofia Molligan", "gender": "male", "location": {"lat": 16, "lng": 7}}, {
                "id": 48,
                "name": "Mia Day",
                "gender": "female",
                "location": {"lat": 13, "lng": 17}
            }, {"id": 49, "name": "Amelia Carey", "gender": "female", "location": {"lat": 10, "lng": -12}}, {
                "id": 50,
                "name": "Kimberly Gerald",
                "gender": "female",
                "location": {"lat": 7, "lng": -8}
            }];


        }).controller('DragMarkerCtrl', function ($scope) {

        $scope.houses = [
            {
                id: 0,
                name: 'House A',
                lat: 46,
                lng: -122
            },
            {
                id: 1,
                name: 'House B',
                lat: 48,
                lng: -120
            }
        ];

        $scope.options = {
            map: {
                center: new google.maps.LatLng(46, -122),
                zoom: 3,
                mapTypeId: google.maps.MapTypeId.ROADMAP
            },
            marker: function (house) {
                return {
                    clickable: false,
                    draggable: true,
                    title: house.name
                }
            }
        };

        $scope.setHouseLocation = function (house, marker) {
            alert();
            var position = marker.getPosition();
            house.lat = position.lat();
            house.lng = position.lng();
        };
    }).controller('VectorMapCtrl', function ($scope, $http) {
        $scope.mapOptions = {
            map: 'world_mill_en',
            scaleColors: ['#ccc', '#aaa'],
            normalizeFunction: 'polynomial',
            hoverOpacity: 0.7,
            hoverColor: false,
            regionStyle: {
                initial: {
                    fill: '#ddd'
                }
            },
            markerStyle: {
                initial: {
                    fill: '#007aff',
                    stroke: '#fff'
                }
            },
            backgroundColor: 'transparent',
            markers: [
                {latLng: [41.90, 12.45], name: 'Vatican City'},
                {latLng: [43.73, 7.41], name: 'Monaco'},
                {latLng: [-0.52, 166.93], name: 'Nauru'},
                {latLng: [-8.51, 179.21], name: 'Tuvalu'},
                {latLng: [43.93, 12.46], name: 'San Marino'},
                {latLng: [47.14, 9.52], name: 'Liechtenstein'},
                {latLng: [7.11, 171.06], name: 'Marshall Islands'},
                {latLng: [17.3, -62.73], name: 'Saint Kitts and Nevis'},
                {latLng: [3.2, 73.22], name: 'Maldives'},
                {latLng: [35.88, 14.5], name: 'Malta'},
                {latLng: [12.05, -61.75], name: 'Grenada'},
                {latLng: [13.16, -61.23], name: 'Saint Vincent and the Grenadines'},
                {latLng: [13.16, -59.55], name: 'Barbados'},
                {latLng: [17.11, -61.85], name: 'Antigua and Barbuda'},
                {latLng: [-4.61, 55.45], name: 'Seychelles'},
                {latLng: [7.35, 134.46], name: 'Palau'},
                {latLng: [42.5, 1.51], name: 'Andorra'},
                {latLng: [14.01, -60.98], name: 'Saint Lucia'},
                {latLng: [6.91, 158.18], name: 'Federated States of Micronesia'},
                {latLng: [1.3, 103.8], name: 'Singapore'},
                {latLng: [1.46, 173.03], name: 'Kiribati'},
                {latLng: [-21.13, -175.2], name: 'Tonga'},
                {latLng: [15.3, -61.38], name: 'Dominica'},
                {latLng: [-20.2, 57.5], name: 'Mauritius'},
                {latLng: [26.02, 50.55], name: 'Bahrain'},
                {latLng: [0.33, 6.73], name: 'São Tomé and Príncipe'}
            ]
        };

        $scope.mapOptions2 = {};
        $scope.getMapOptions = function () {
            $http.get('datas/vectormap.json')
                .success(function (data) {
                    var val = 2009;
                    var statesValues = 2005;
                    var metroPopValues = 2005;
                    var metroUnemplValues = 2005;
                    $scope.mapOptions2 = {
                        map: 'us_aea_en',
                        markers: data.metro.coords,
                        backgroundColor: 'transparent',
                        scaleColors: ['#ccc', '#aaa'],
                        regionStyle: {
                            initial: {
                                fill: '#ddd'
                            }
                        },
                        markerStyle: {
                            initial: {
                                fill: '#007aff',
                                stroke: '#fff'
                            }
                        },
                        onMarkerTipShow: function (event, label, index) {
                            label.html(
                                '<b>' + data.metro.names[index] + '</b><br/>' +
                                '<b>Population: </b>' + data.metro.population[val][index] + '</br>' +
                                '<b>Unemployment rate: </b>' + data.metro.unemployment[val][index] + '%'
                            );
                        },
                        onRegionTipShow: function (event, label, code) {
                            label.html(
                                '<b>' + label.html() + '</b></br>' +
                                '<b>Unemployment rate: </b>' + data.states[val][code] + '%'
                            );
                        }
                    };
                });
        };
    });
})();


