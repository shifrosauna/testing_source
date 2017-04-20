(function () {
    'use strict';

    angular.module('app.components.sortable', [])
        .controller('SortableCtrl', ['$scope', function ($scope) {
            $scope.sortableData = [
                {
                    item: {text: 'Node a'},
                    children: []
                },
                {
                    item: {text: 'Node b'},
                    children: [
                        {
                            item: {text: 'Node c'},
                            children: []
                        },
                        {
                            item: {text: 'Node d'},
                            children: [
                                {
                                    item: {text: 'Node e'},
                                    children: []
                                },
                                {
                                    item: {text: 'Node f'},
                                    children: [
                                        {
                                            item: {text: 'Node g'},
                                            children: []
                                        }
                                    ]
                                }
                            ]
                        }
                    ]
                },
                {
                    item: {text: 'Node h'},
                    children: [
                        {
                            item: {text: 'Node i'},
                            children: [
                                {
                                    item: {text: 'Node j'},
                                    children: []
                                }
                            ]
                        }
                    ]
                },
                {
                    item: {text: 'Node k'},
                    children: [
                        {
                            item: {text: 'Node l'},
                            children: []
                        }
                    ]
                }
            ];

            $scope.sortableTasks = [
                {
                    title: 'Remove git conflict-marked areas',
                    class: ''
                },
                {
                    title: 'Add machine readable events',
                    class: 'b-warning'
                },
                {
                    title: '[Form] Deprecated "cascade_validation',
                    class: ''
                },
                {
                    title: 'Make Request::get more performant.',
                    class: 'b-success'
                },
                {
                    title: '[Translation] Add a hasId method',
                    class: 'b-danger'
                }
            ];
        }]);
})();