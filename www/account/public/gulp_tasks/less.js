var gulp = require('gulp');
var less = require('gulp-less');
var gutil=require('gulp-util');
var connect = require('gulp-connect');

gulp.task('less', function () {
    return gulp.src('../less/app.less')
            .pipe(less({}))
            .on('error',gutil.log)
            .pipe(gulp.dest('./src/css'))
            .pipe(connect.reload());
});