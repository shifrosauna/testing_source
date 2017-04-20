(function () {
    'use strict';

    angular.module('tasks.controller', [])
        .controller('TaskCtrl', ['$scope', '$timeout', 'focus', '$state', '$stateParams', '$filter', 'Tasks',
            function ($scope, $timeout, focus, $state, $stateParams, $filter, Tasks) {

                $scope.selectedTodo = {};
                $scope.selectedList = {};

                $scope.newTodo = '';
                $scope.newList = '';

                $scope.createMode = false;

                $scope.solveTimeOut = {};

                $scope.list = {};

                $scope.sortableOptions = {
                    connectWith: ".task-list",
                    handle: ".drag"
                };

                $scope.tasks = Tasks.getTaskLists();

                function getTaskListId() {
                    var max = 0;
                    for (var i = 0; i < $scope.tasks.length; i++) {
                        if ($scope.tasks[i].list_id > max) {
                            max = $scope.tasks[i].list_id;
                        }
                    }
                    return ++max;
                }
                ;

                $scope.submitTaskList = function () {
                    if ($scope.newList !== '') {
                        var taskListId = getTaskListId();
                        $scope.selectedList.addMode = false;
                        $scope.tasks.unshift({
                            list_id: taskListId,
                            list_name: $scope.newList,
                            created_by: "You",
                            created_date: "2014-09-25 19:30:00",
                            todos: [],
                            completed: []
                        });
                        $scope.selectedList = $scope.tasks[0];
                        $scope.selectedList.addMode = true;
                        $scope.cancelSubmitList();
                        $scope.selectTaskList($filter('filter')($scope.tasks, {list_id: taskListId})[0]);
                        $state.go('app.tasks.view', {taskId: taskListId});
                        focus('newFocus');
                    }
                };

                $scope.cancelSubmitList = function () {
                    $scope.newList = '';
                    $scope.createMode = false;
                };

                $scope.showAllList = function () {
                    $scope.unSelectAllList();
                };

                $scope.selectTaskList = function (list) {
                    $scope.unSelectAllList();
                    list.selected = true;
                    $scope.list = list;
                };

                $scope.unSelectAllList = function () {
                    $scope.tasks.forEach(function (row) {
                        row.selected = false;
                    });
                };

                $scope.submitTask = function (todo) {
                    if (todo.text !== '') {
                        $scope.selectedList.todos.push({
                            description: todo.text,
                            created: "",
                            solved: "",
                            assignTo: "",
                            dueDate: "",
                            priority: false
                        });
                        todo.text = '';
                    }
                };

                $scope.createTaskList = function () {
                    $scope.createMode = true;
                    focus('createMode');
                };

                $scope.editList = function (list) {
                    $scope.selectedTodo.selected = false;
                    $scope.selectedList.edited = false;
                    $scope.selectedList = list;
                    $scope.selectedList.edited = true;
                };

                $scope.submitEditList = function (list) {
                    $scope.selectedList.edited = false;
                };

                $scope.deleteList = function (list) {
                    $scope.tasks.splice($scope.tasks.indexOf(list), 1);
                };

                $scope.cancelSubmit = function () {
                    $scope.newTodo = '';
                    $scope.selectedList.addMode = false;
                };

                $scope.addTask = function (list) {
                    $scope.selectedList.addMode = false;
                    $scope.selectedList = list;
                    $scope.selectedList.addMode = true;
                };

                $scope.delTask = function (list, type, task) {
                    var listIndex = $scope.tasks.indexOf(list);
                    $scope.tasks[listIndex][type].splice($scope.tasks[listIndex][type].indexOf(task), 1);
                };

                $scope.solveTask = function (list, task) {
                    if (task.solved) {
                        $timeout.cancel($scope.solveTimeOut);
                        task.solved = false;
                    }
                    else {
                        task.solved = true;
                        $scope.solveTimeOut = $timeout(function () {
                            list.completed.push(task);
                            list.todos.splice(list.todos.indexOf(task), 1);
                        }, 200);
                    }
                };

                $scope.pushBack = function (list, task) {
                    if (task.solved === false) {
                        $timeout.cancel($scope.solveTimeOut);
                        task.solved = true;
                    }
                    else {
                        task.solved = false;
                        $scope.solveTimeOut = $timeout(function () {
                            list.todos.push(task);
                            list.completed.splice(list.completed.indexOf(task), 1);
                        }, 200);
                    }
                };

                $scope.selectTodo = function (todo) {
                    $scope.selectedList.edited = false;
                    $scope.selectedList.addMode = false;

                    $scope.selectedTodo.selected = false;
                    delete $scope.selectedTodo;
                    $scope.selectedTodo = todo;
                    $scope.selectedTodo.selected = true;
                };

                $scope.doneEdit = function (todo) {
                    todo.selected = false;
                };

                $scope.showCompleted = function (list) {
                    list.showCompleted = !list.showCompleted;
                };

                $scope.setTaskImportant = function (task) {
                    if (task.hasOwnProperty('important')) {
                        task.important = !task.important;
                    }
                    else {
                        task.important = true;
                    }
                };

                if ($stateParams.taskId !== undefined) {
                    $scope.selectTaskList($filter('filter')($scope.tasks, {list_id: $stateParams.taskId})[0]);
                }
            }]);
})();