// CSS minify
module.exports = {
    angular: {
        files: {
            '<%= config.dist %>/css/app.min.css': ['<%= config.dist %>/css/app.src.css']
        }
    }
};