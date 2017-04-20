module.exports = {
    angular: {
        options: {
            removeComments: true,
            collapseWhitespace: true
        },
        files: [
            {
                expand: true, // Enable dynamic expansion.
                cwd: '<%= config.dist %>/views/', // Src matches are relative to this path.
                src: ['**/*.html'], // Actual pattern(s) to match.
                dest: '<%= config.dist %>/views/'   // Destination path prefix.
            }
        ]
    }
};