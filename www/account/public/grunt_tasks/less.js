module.exports = {
    development: {
        options: {
            compress: false
        },
        files: {
            '<%= config.app %>/css/app.css': '../less/app.less'
        }
    }
};