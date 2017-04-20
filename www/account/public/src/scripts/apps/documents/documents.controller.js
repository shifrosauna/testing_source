(function () {
    'use strict';

    angular.module('documents.controller', [])
        .controller('DocumentCtrl', ['$scope', '$filter', '$stateParams', '$state', 'Documents',
            function ($scope, $filter, $stateParams, $state, Documents) {

                $scope.editMode = false;
                $scope.optionsShow = false;

                $scope.document = {};
                $scope.documents = {};

                $scope.documentShow = 'comments';

                $scope.comment = '';

                $scope.documents = Documents.getDocuments();

                $scope.selected_document = 0;
                $scope.document = $scope.documents[0];

                $scope.sendComment = function () {
                    if ($scope.comment) {
                        $scope.document.comments.push(
                            {
                                user: 'Saul Doe',
                                owner: true,
                                datetime: moment().format('YYYY-MM-DD H:mm:ss'),
                                comment: $scope.comment,
                                avatar: 'img/avatar2.jpg'
                            }
                        );
                        $scope.comment = '';
                    }
                };

                $scope.delDocument = function () {
                    $scope.documents.splice($scope.documents.indexOf($scope.document), 1);
                    $scope.setEditMode(false);
                    $scope.optionsShow = false;
                    $state.go('app.documents.all');
                };

                $scope.getOptions = function () {
                    $scope.optionsShow = !$scope.optionsShow;
                }

                $scope.selectDocument = function (document_id, bool) {
                    if (bool === undefined) {
                        $scope.editMode = false;
                    }
                    else {
                        $scope.editMode = bool;
                    }
                    $scope.selected_document = document_id;
                    $scope.document = $filter('filter')($scope.documents, {document_id: document_id})[0];
                };

                $scope.setFav = function (document) {
                    document.favourite = !document.favourite;
                };

                $scope.create = function () {

                    var document_id = $scope.documents[$scope.documents.length - 1].document_id + 1;
                    $scope.documents.push({
                        document_id: document_id,
                        title: '',
                        content: '',
                        created_by: 'Saul Doe',
                        created_date: moment().format('YYYY-MM-DD H:mm:ss'),
                        last_update: [],
                        versions: [],
                        comments: [],
                        favourite: false
                    });

                    $state.go('app.documents.view', {docId: document_id});

                    $scope.selectDocument(document_id, true);
                };

                $scope.save = function () {
                    $scope.document.last_update.push({
                        user: 'You',
                        datetime: moment().format('YYYY-MM-DD H:mm:ss'),
                        avatar: 'img/avatar1.jpg'
                    });
                    $scope.editMode = false;
                };

                $scope.setEditMode = function (bool) {
                    $scope.editMode = bool;
                };

                if ($stateParams.docId !== undefined) {
                    $scope.selectDocument($stateParams.docId);
                }
            }]);

})();
