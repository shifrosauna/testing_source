'use strict';

module.exports = function (grunt) {
    
    // Load grunt tasks automatically
    require('load-grunt-tasks')(grunt);

    // Time how long tasks take. Can help when optimizing build times
    require('time-grunt')(grunt);

    var gtx = require('gruntfile-gtx').wrap(grunt);
    
    // Configurable paths for the application
    var appConfig = {
        app: require('./bower.json').appPath || 'src',
        dist: 'dist'
    };
    
    // Define the configuration for all the tasks
    var gruntConfig = require('./grunt_tasks'); 
    gruntConfig.package = grunt.file.readJSON('./package.json'); // Grunt packages
    gruntConfig.config = appConfig; // Project settings
    
    // Set gtx config
    gtx.config(gruntConfig);

    // Load tasks
    gtx.loadNpm([
        'grunt-contrib-less',
        'grunt-contrib-watch'
    ]);
    
    gtx.alias('serve', ['less','connect:livereload', 'watch']); // For development
    gtx.alias('build:angular', ['clean','less','copy:angular','concat:angular','cssmin:angular','uglify:angular','processhtml:angular']); // Build the app
    gtx.alias('validate', ['validation']); // html validation
    
    // End
    gtx.finalise();
    
};