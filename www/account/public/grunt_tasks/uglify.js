// JS uglify
module.exports = {
    angular: {
        files: {
            '<%= config.dist %>/scripts/app.min.js': ['<%= config.dist %>/scripts/app.src.js']
        }
    }
};