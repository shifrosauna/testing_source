(function () {
    'use strict';

    angular.module('mail.controller', [])
        .controller('MailCtrl', ['$scope', '$filter', '$uibModal', '$state', '$stateParams', 'Mails',
            function ($scope, $filter, $uibModal, $state, $stateParams, Mails) {

                $scope.selectedEmail = {};
                $scope.selectMails = false;

                $scope.orderProperties = ['date', 'sender', 'title', 'content'];

                $scope.order = {
                    by: "date",
                    sort: true
                };
                $scope.selectedMailsCounter = 0;

                $scope.setOrderProperty = function (prop) {
                    $scope.order.by = prop;
                };

                $scope.seeEmail = function (mail) {
                    if (!$scope.selectMails) {
                        $scope.selectedEmail = mail;
                        $scope.selectedEmail.read = true;
                    }
                };

                $scope.seeEmailById = function (id) {
                    $scope.seeEmail($filter('filter')($scope.mails, {id: id})[0]);
                };

                $scope.selectEmail = function (mail) {
                    mail.selected ? $scope.selectedMailsCounter++ : '';
                    !mail.selected ? $scope.selectedMailsCounter-- : '';
                };

                $scope.setEdit = function () {
                    delete $scope.selectedEmail;
                    $scope.selectMails = !$scope.selectMails;
                    if ($scope.selectMails) {
                        $state.go('mail.edit');
                    }
                    else {
                        $state.go('mail.inbox');
                    }
                };

                $scope.delEmail = function () {
                    if ($scope.selectMails) {
                        var i = $scope.mails.length;
                        while (i--) {
                            if ($scope.mails[i].selected) {
                                $scope.mails.splice(i, 1);
                            }
                        }
                        $scope.selectMails = false;
                        $state.go('mail.inbox');
                    }
                    else {
                        var index = $scope.mails.indexOf($scope.selectedEmail);
                        $scope.mails.splice(index, 1);
                        $state.go('mail.inbox');
                        delete $scope.selectedEmail;
                        $scope.stateParamChange();
                    }
                };

                $scope.setEmails = function (type, value) {
                    if ($scope.selectMails) {
                        for (var i = 0; i < $scope.mails.length; i++) {
                            if ($scope.mails[i].selected) {
                                $scope.mails[i][type] = value;
                                $scope.mails[i].selected = false;
                            }
                        }
                        $scope.selectMails = false;
                        $state.go('mail.inbox');
                    }
                };

                $scope.getUnreadCount = function () {
                    return $filter('filter')($scope.mails, {read: false}).length;
                };

                $scope.setFlag = function (flag) {
                    $scope.selectedEmail.read = true;
                    $scope.selectedEmail.flag = flag;
                };

                $scope.markUnread = function () {
                    $scope.setFlag('');
                    $scope.selectedEmail.read = false;
                };

                $scope.stateParamChange = function () {
                    if ($stateParams.emailId !== undefined) {
                        $scope.seeEmailById($stateParams.emailId);
                    }
                };

                $scope.mails = Mails.getAll();
                $scope.stateParamChange();

                if ($state.includes('mail.edit')) {
                    $scope.setEdit();
                }

                $scope.composeEmail = function (mail) {
                    var mail = {};
                    var modalInstance = $uibModal.open({
                        templateUrl: 'views/mail/compose.html',
                        controller: function ($scope, $uibModalInstance, contacts, email) {
                            $scope.contacts = contacts;
                            $scope.email = email;
                            $scope.ok = function (e) {
                                $uibModalInstance.close();
                            };
                            $scope.cancel = function (e) {
                                $uibModalInstance.dismiss();
                            };
                        },
                        size: 'lg',
                        resolve: {
                            contacts: function () {
                                return [
                                    {
                                        name: "John Doe",
                                        email: "jonh@doe.com"
                                    },
                                    {
                                        name: "Jesse Holmes",
                                        email: "jesse@pinkman.com"
                                    },
                                    {
                                        name: "Walter White",
                                        email: "walter@white.com"
                                    },
                                    {
                                        name: "Damon Pope",
                                        email: "damon@pope.com"
                                    }
                                ];
                            },
                            email: function () {
                                return mail;
                            }
                        }
                    });
                };

                $scope.$on('composeEmail', function (event, param) {
                    $scope.composeEmail();
                });

            }])
})();