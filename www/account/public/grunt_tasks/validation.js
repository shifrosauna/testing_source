// Html validator
module.exports = {
    validation: {
        options: {
            stoponerror: false
        },
        files: {
            src: ['<%= config.landingpage %>/*.html','<%= config.support_template %>/*.html']
        }
    }
};