(function () {
    'use strict';

    angular.module('tasks.service', [])
        .service('Tasks', function () {
            this.getTaskLists = function () {
                return [
                    {
                        list_id: 1,
                        list_name: "Feature request",
                        created_by: "Jesse Holmes",
                        created_date: "2014-09-25 19:30:00",
                        todos: [
                            {
                                description: 'Refactor the Console component for lazy-loading of commands',
                                created: "2014-09-25 19:30:00",
                                createdBy: "Jesse Holmes",
                                solved: "",
                                solvedBy: "",
                                assignTo: "",
                                dueDate: "",
                                important: false
                            },
                            {
                                description: 'Check whether value is valid or not',
                                created: "2014-09-25 19:00:00",
                                createdBy: "Jesse Holmes",
                                solved: "",
                                solvedBy: "",
                                assignTo: "",
                                dueDate: "",
                                important: true
                            },
                            {
                                description: 'Add helpers for the new console style guide',
                                created: "2014-09-25 19:00:00",
                                createdBy: "Jesse Holmes",
                                solved: "",
                                solvedBy: "",
                                assignTo: "",
                                dueDate: "",
                                important: false
                            },
                            {
                                description: 'Add "truncate" method to Formatter helper',
                                created: "2014-09-25 19:00:00",
                                createdBy: "Jesse Holmes",
                                solved: "",
                                solvedBy: "",
                                assignTo: "",
                                dueDate: "",
                                important: false
                            },
                            {
                                description: 'fix(ngModel): allow setting model to NaN',
                                created: "2014-09-25 19:00:00",
                                createdBy: "Jesse Holmes",
                                solved: "",
                                solvedBy: "",
                                assignTo: "",
                                dueDate: "",
                                important: false
                            },
                            {
                                description: 'fix(ngAnimate): ensure that minified repaint code isnt removed',
                                created: "2014-09-25 19:00:00",
                                createdBy: "Jesse Holmes",
                                solved: "",
                                solvedBy: "",
                                assignTo: "",
                                dueDate: "",
                                important: false
                            },
                            {
                                description: 'chore(version-info): modify versioning for < v1.0.2',
                                created: "2014-09-25 19:00:00",
                                createdBy: "Jesse Holmes",
                                solved: "",
                                solvedBy: "",
                                assignTo: "",
                                dueDate: "",
                                important: false
                            },
                            {
                                description: 'fix($parse): fix parse errors on older Android WebViews which choke',
                                created: "2014-09-25 19:00:00",
                                createdBy: "Jesse Holmes",
                                solved: "",
                                solvedBy: "",
                                assignTo: "",
                                dueDate: "",
                                important: false
                            }


                        ],
                        completed: []
                    },
                    {
                        list_id: 2,
                        list_name: "BUGS",
                        created_by: "Jesse Holmes",
                        created_date: "2014-09-25 19:30:00",
                        todos: [
                            {
                                description: 'Inability to update a users roles after login',
                                created: "2014-09-25 19:00:00",
                                createdBy: "Jesse Holmes",
                                solved: "",
                                solvedBy: "",
                                assignTo: "",
                                dueDate: "",
                                important: true
                            },
                            {
                                description: 'ContainerAwareEventDispatcher::lazyLoad() is not lazy enough',
                                created: "2014-09-25 19:00:00",
                                createdBy: "Jesse Holmes",
                                solved: "",
                                solvedBy: "",
                                assignTo: "",
                                dueDate: "",
                                important: false
                            },
                            {
                                description: 'SortableIteratorTest not passing.',
                                created: "2014-09-25 19:00:00",
                                createdBy: "Jesse Holmes",
                                solved: "",
                                solvedBy: "",
                                assignTo: "",
                                dueDate: "",
                                important: true
                            },
                            {
                                description: 'Fix volatile tests',
                                created: "2014-09-25 19:00:00",
                                createdBy: "Jesse Holmes",
                                solved: "",
                                solvedBy: "",
                                assignTo: "",
                                dueDate: "",
                                important: false
                            },
                            {
                                description: 'style(ngStyle): remove unused $log param',
                                created: "2014-09-25 19:00:00",
                                createdBy: "Jesse Holmes",
                                solved: "",
                                solvedBy: "",
                                assignTo: "",
                                dueDate: "",
                                important: false
                            },
                            {
                                description: 'feat(travis): run unit tests on iOS 8',
                                created: "2014-09-25 19:00:00",
                                createdBy: "Jesse Holmes",
                                solved: "",
                                solvedBy: "",
                                assignTo: "",
                                dueDate: "",
                                important: false
                            }
                        ],
                        completed: []
                    },
                    {
                        list_id: 3,
                        list_name: "Meeting",
                        created_by: "Jesse Holmes",
                        created_date: "2014-09-25 19:30:00",
                        todos: [],
                        completed: [
                            {
                                description: 'ContainerAwareEventDispatcher::lazyLoad() is not lazy enough',
                                created: "2014-09-25 19:00:00",
                                createdBy: "Jesse Holmes",
                                solved: "",
                                solvedBy: "",
                                assignTo: "",
                                dueDate: "",
                                important: false
                            },
                            {
                                description: 'SortableIteratorTest not passing.',
                                created: "2014-09-25 19:00:00",
                                createdBy: "Jesse Holmes",
                                solved: "",
                                solvedBy: "",
                                assignTo: "",
                                dueDate: "",
                                important: true
                            },
                            {
                                description: 'Fix volatile tests',
                                created: "2014-09-25 19:00:00",
                                createdBy: "Jesse Holmes",
                                solved: "",
                                solvedBy: "",
                                assignTo: "",
                                dueDate: "",
                                important: false
                            }
                        ]
                    }
                ];
            };
        });
})();