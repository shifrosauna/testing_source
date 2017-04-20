var gulp = require('gulp');
var connect = require('gulp-connect');

gulp.task('connect', function () {
    connect.server({
        root: 'src',
        livereload: true,
        middleware: function (connect) {
            return [
                connect.static('.tmp'),
                connect.static('src'),
                connect().use('/bower_components', connect.static('./bower_components')),
                connect().use('/js_vendors', connect.static('./js_vendors'))
            ];
        }
    });
});