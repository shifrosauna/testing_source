var gulp = require('gulp');
var uglify = require('gulp-uglify');
var rename = require('gulp-rename');
 
gulp.task('uglify', function() {
  return gulp.src('./dist/scripts/app.src.js')
    .pipe(uglify())
    .pipe(rename("app.min.js"))
    .pipe(gulp.dest('dist/scripts'));
});