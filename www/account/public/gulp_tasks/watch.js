var gulp = require('gulp');
var watch = require('gulp-watch');
var connect = require('gulp-connect');

gulp.task('watch', function () {
    gulp.watch('../less/**/*.less',['less']);
    gulp.watch('./src/scripts/**/*',['js']);
    gulp.watch('./src/scripts/*',['js']);
    gulp.watch('./src/views/**/*',['html']);
});