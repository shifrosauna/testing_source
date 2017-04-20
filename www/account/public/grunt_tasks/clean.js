// Empties folders to start fresh
module.exports = {
    clean: {
        dist: {
            files: [{
                    dot: true,
                    src: [
                        '<%= config.dist %>/{,*/}*',
                        '!<%= config.dist %>/.git*'
                    ]
                }]
        },
        server: '.tmp'
    }
};