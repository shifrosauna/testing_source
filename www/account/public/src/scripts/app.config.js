(function () {
    'use strict';

    angular.module('app')
        .factory('httpInterceptor', ['$log', '$q', 'cfpLoadingBar', '$location', 'toaster',
            function ($log, $q, cfpLoadingBar, $location, toaster) {
                return {

                    request: function (config) {

                        if (config.method == 'POST') {
                            cfpLoadingBar.start();
                        }

                        return config;
                    },

                    requestError: function (response) {

                        if (response.config && response.config.method == 'POST') {
                            cfpLoadingBar.complete();
                        }

                        return response;
                    },

                    response: function (response) {

                        if (response.config && response.config.method == 'POST') {
                            cfpLoadingBar.complete();
                        }

                        return response;
                    },

                    responseError: function (response) {

                        if (response.config && response.config.method == 'POST') {
                            cfpLoadingBar.complete();
                        }

                        switch (response.status) {
                            case 400:
                                break;
                            case 401:
                                $location.path('/access/login');
                                break;
                            case 403:
                                $location.path('/app/dashboard');
                                break;
                            case 404:
                                break;
                            default:
                                if (response.data) {
                                    toaster.pop({
                                        type: 'error',
                                        title: response.data.exception,
                                        body: '<br/>' + response.data.message + '<br/><br/>' + response.data.filename + ' (' + response.data.line + ')',
                                        timeout: 10000,
                                        showCloseButton: true,
                                        bodyOutputType: 'trustedHtml'
                                    });
                                }
                        }

                        return $q.reject(response);
                    }
                };
            }])
        .config(['$ocLazyLoadProvider', '$translateProvider', '$httpProvider', '_MODULES', '_CONTROLLERS',
            function ($ocLazyLoadProvider, $translateProvider, $httpProvider, _MODULES, _CONTROLLERS) {

                $httpProvider.defaults.headers.common['X-Requested-With'] = 'XMLHttpRequest';
                $httpProvider.interceptors.push('httpInterceptor');

                $ocLazyLoadProvider.config({
                    debug: true,
                    events: true,
                    loadedModules: ['app'],
                    modules: _MODULES.concat(_CONTROLLERS)
                });

                $translateProvider.useStaticFilesLoader({
                    prefix: 'l10n/locale-',
                    suffix: '.json'
                });

                $translateProvider.preferredLanguage('en_US');
            }]);
})(); 