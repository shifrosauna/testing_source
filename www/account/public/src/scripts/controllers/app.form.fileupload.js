(function () {
    'use strict';

    angular.module('app.form.fileupload', [])
        .controller('UploadCtrl', ['$scope', 'FileUploader',
            function ($scope, FileUploader) {
                $scope.uploader = new FileUploader({
                    url: 'upload.php'
                });

            }]);
})();
