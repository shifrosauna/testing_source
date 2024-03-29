(function () {
    'use strict';

    angular.module('app')
        .directive('focusMe', ['$timeout', '$parse', function ($timeout, $parse) {
            return {
                link: function (scope, element, attrs) {
                    var model = $parse(attrs.focusMe);
                    scope.$watch(model, function (value) {
                        if (value === true) {
                            $timeout(function () {
                                element[0].focus();
                            }, 30);
                        }
                    });
                }
            };
        }]);
})();