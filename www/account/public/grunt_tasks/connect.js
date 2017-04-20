// The actual grunt server settings
module.exports = {
    options: {
        port: 9000,
        // Change this to '0.0.0.0' to access the server from outside.
        hostname: 'localhost',
        //hostname: '10.254.254.240',
        livereload: 35729
    },
    livereload: {
        options: {
            open: true,
            middleware: function (connect) {
                return [
                    connect.static('.tmp'),
                    connect.static('src'),
                    connect().use('/bower_components', connect.static('./bower_components')),
                    connect().use('/js_vendors', connect.static('./js_vendors'))
                ];
            }
        }
    }
};