'use strict';

var gulp = require('gulp');
var runSequence = require('run-sequence');

require('es6-promise').polyfill();

gulp.paths = {
    src: 'src',
    dist: 'dist'
};

require('require-dir')('./gulp_tasks');

gulp.task('serve', ['less', 'connect', 'watch']);

gulp.task('js', function (callback) {
    runSequence('copy:js-files', 'concat:js', 'uglify', callback)
});

gulp.task('html', function (callback) {
    runSequence('copy:html-files', 'processhtml', callback)
});

gulp.task('build', function (callback) {
    runSequence('clean', 'less', 'copy:files', 'copy:bower', 'copy:vendors', 'concat:js', 'concat:css', 'minify:css', 'uglify', 'processhtml', 'watch', callback);
});