var gulp = require('gulp');
var processhtml = require('gulp-processhtml');

gulp.task('processhtml', function () {
    return gulp.src('./dist/index.html').pipe(processhtml({})).pipe(gulp.dest('dist'));
});