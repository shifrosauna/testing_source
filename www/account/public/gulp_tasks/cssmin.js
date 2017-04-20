var cssnano = require('gulp-cssnano');
var gulp = require('gulp');
var rename = require('gulp-rename');

gulp.task('minify:css', function () {
    return gulp.src('dist/css/app.src.css')
            .pipe(cssnano({discardComments: {removeAll: true}}))
            .pipe(rename('app.min.css'))
            .pipe(gulp.dest('dist/css'));
});