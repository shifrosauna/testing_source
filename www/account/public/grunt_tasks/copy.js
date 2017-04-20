// Copy files
module.exports = {
    angular: {
        files: [
            {expand: true, src: "**", cwd: 'bower_components', dest: '<%= config.dist %>/bower_components'},
            {expand: true, src: "**", cwd: 'js_vendors', dest: '<%= config.dist %>/js_vendors'},
            {expand: true, src: "**", cwd: '<%= config.app %>/datas', dest: '<%= config.dist %>/datas'},
            {expand: true, src: "**", cwd: '<%= config.app %>/fonts', dest: '<%= config.dist %>/fonts'},
            {expand: true, src: "**", cwd: '<%= config.app %>/icons', dest: '<%= config.dist %>/icons'},
            {expand: true, src: "**", cwd: '<%= config.app %>/img', dest: '<%= config.dist %>/img'},
            {expand: true, src: "**", cwd: '<%= config.app %>/js', dest: '<%= config.dist %>/js'},
            {expand: true, src: "**", cwd: '<%= config.app %>/l10n', dest: '<%= config.dist %>/l10n'},
            {expand: true, src: "**", cwd: '<%= config.app %>/scripts', dest: '<%= config.dist %>/scripts'},
            {expand: true, src: "**", cwd: '<%= config.app %>/views', dest: '<%= config.dist %>/views'},
            {src: '<%= config.app %>/favicon.ico', dest: '<%= config.dist %>/favicon.ico'},
            {src: '<%= config.app %>/index.html', dest: '<%= config.dist %>/index.html'}
        ]
    }
};