var gulp = require('gulp');

gulp.task('copy:files', function () {
    return gulp.src([
        './src/datas/**/*',
        './src/fonts/**/*',
        './src/icons/**/*',
        './src/img/**/*',
        './src/l10n/**/*',
        './src/scripts/**/*',
        './src/views/**/*',
        './src/favicon.ico',
        './src/index.html'
    ], {
        "base": "./src"
    }).pipe(gulp.dest('./dist'));
});

gulp.task('copy:js-files', function () {
    return gulp.src(['./src/datas/**/*', './src/scripts/**/*'], {
        "base": "./src"
    }).pipe(gulp.dest('./dist'));
});

gulp.task('copy:html-files', function () {
    return gulp.src(['./src/views/**/*', './src/index.html'], {
        "base": "./src"
    }).pipe(gulp.dest('./dist'));
});

gulp.task('copy:bower', function () {
    return gulp.src([
        './bower_components/**/*'
    ]).pipe(gulp.dest('./dist/bower_components'));
});

gulp.task('copy:vendors', function () {
    return gulp.src([
        './js_vendors/**/*'
    ]).pipe(gulp.dest('./dist/js_vendors'));
});