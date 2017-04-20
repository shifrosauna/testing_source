var concat = require('gulp-concat');
var gulp = require('gulp');

gulp.task('concat:js', function() {
  return gulp.src([
                    'bower_components/jquery/dist/jquery.min.js',
                    'bower_components/bootstrap/dist/js/bootstrap.min.js',
                    'bower_components/angular/angular.min.js',
                    'bower_components/angular-sanitize/angular-sanitize.min.js',
                    'bower_components/angular-resource/angular-resource.min.js',
                    'bower_components/angular-cookies/angular-cookies.min.js',
                    'bower_components/angular-animate/angular-animate.js',
                    'bower_components/angular-touch/angular-touch.min.js',
                    'bower_components/angular-bootstrap/ui-bootstrap.min.js',
                    'bower_components/angular-bootstrap/ui-bootstrap-tpls.min.js',
                    'bower_components/angular-ui-router/release/angular-ui-router.min.js',
                    'bower_components/oclazyload/dist/ocLazyLoad.min.js',
                    'bower_components/angular-translate/angular-translate.min.js',
                    'bower_components/angular-translate-loader-url/angular-translate-loader-url.min.js',
                    'bower_components/angular-translate-loader-static-files/angular-translate-loader-static-files.min.js',
                    'bower_components/angularjs-breakpoint/breakpoint-0.0.1.min.js',
                    'bower_components/ngstorage/ngStorage.min.js',
                    'bower_components/ng-focus-on/ng-focus-on.min.js',
                    'bower_components/angular-loading-bar/build/loading-bar.min.js',
                    'bower_components/moment/min/moment.min.js',
                    'bower_components/angular-aside/dist/js/angular-aside.min.js',
                    'bower_components/AngularJS-Toaster/toaster.js',
                    'bower_components/angular-ui-switch/angular-ui-switch.min.js',
                    'bower_components/angular-breadcrumb/release/angular-breadcrumb.min.js',
                    'bower_components/slimScroll/jquery.slimscroll.min.js',
                    'bower_components/angular-slimscroll/angular-slimscroll.js',
                    'bower_components/angular-fullscreen/src/angular-fullscreen.js',
                    'bower_components/ngScrollTo/ng-scrollto.js',
                    'bower_components/angular-xeditable/dist/js/xeditable.js',
                    'bower_components/textAngular/dist/textAngular-rangy.min.js',
                    'bower_components/textAngular/dist/textAngular-sanitize.min.js',
                    'bower_components/textAngular/dist/textAngular.min.js',
                    'src/scripts/app.js',
                    'src/scripts/app.config.lazyload.controllers.js',
                    'src/scripts/app.config.lazyload.modules.js',
                    'src/scripts/app.config.lazyload.requires.js',
                    'src/scripts/app.config.routes.js',
                    'src/scripts/app.config.js',
                    'src/scripts/app.run.js',
                    'src/scripts/app.root.js',
                    'src/scripts/filters/*.js',
                    'src/scripts/directives/*.js'
                ])
    .pipe(concat('app.src.js'))
    .pipe(gulp.dest('./dist/scripts'));
});


gulp.task('concat:css', function() {
  return gulp.src([
                    'src/css/animate.css',
                    'src/css/app.css',
                    'bower_components/angular-ui-switch/angular-ui-switch.min.css',
                    'bower_components/AngularJS-Toaster/toaster.css',
                    'bower_components/angular-aside/dist/css/angular-aside.min.css',
                    'bower_components/angular-loading-bar/build/loading-bar.min.css',
                    'bower_components/angular-xeditable/dist/css/xeditable.css',
                    'bower_components/textAngular/dist/textAngular.css'
                ])
    .pipe(concat('app.src.css'))
    .pipe(gulp.dest('./dist/css'));
});