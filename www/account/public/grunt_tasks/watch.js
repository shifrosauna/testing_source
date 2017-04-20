// Watches files for changes and runs tasks based on the changed files
module.exports = {
    less: {
        files: ['src/less/**/*.less'],
        tasks: ['less'],
        options: {
            livereload: '<%= connect.options.livereload %>'
        }
    },
    js: {
        files: ['<%= config.app %>/scripts/**/*.js'],
        options: {
            livereload: '<%= connect.options.livereload %>'
        }
    },
    html: {
        files: ['<%= config.app %>/views/**/*.html'],
        options: {
            livereload: '<%= connect.options.livereload %>'
        }
    },
    livereload: {
        options: {
            livereload: '<%= connect.options.livereload %>'
        },
        files: [
            '<%= config.app %>/views/**/*.html',
            '<%= config.app %>/scripts/**/*.js'
        ]
    }
};


