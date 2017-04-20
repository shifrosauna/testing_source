// Replace js/css blocks
module.exports = {
    angular: {
        options: {
            process: true
        },
        files: {
            '<%= config.dist %>/index.html': ['<%= config.dist %>/index.html']
        }
    },
    landingpage:{
        options: {
            process: true
        },
        files:{
            
        }
    },
    support_template:{
        options: {
            process: true
        },
        files: {
            '<%= config.support_template %>/index.html': ['<%= config.support_template %>/partials/index.process.html'],
            '<%= config.support_template %>/ticketing.detail.html': ['<%= config.support_template %>/partials/ticketing.detail.process.html'],
            '<%= config.support_template %>/ticketing.grid.html': ['<%= config.support_template %>/partials/ticketing.grid.process.html'],
            '<%= config.support_template %>/ticketing.list.html': ['<%= config.support_template %>/partials/ticketing.list.process.html'],
            '<%= config.support_template %>/ticketing.open.html': ['<%= config.support_template %>/partials/ticketing.open.process.html'],
            '<%= config.support_template %>/forum.table.html': ['<%= config.support_template %>/partials/forum.table.process.html'],
            '<%= config.support_template %>/forum.grid.html': ['<%= config.support_template %>/partials/forum.grid.process.html'],
            '<%= config.support_template %>/forum.detail.html': ['<%= config.support_template %>/partials/forum.detail.process.html'],
            '<%= config.support_template %>/knowledge.3col.html': ['<%= config.support_template %>/partials/knowledge.3col.process.html'],
            '<%= config.support_template %>/knowledge.2col.html': ['<%= config.support_template %>/partials/knowledge.2col.process.html'],
            '<%= config.support_template %>/knowledge.1col.html': ['<%= config.support_template %>/partials/knowledge.1col.process.html'],
            '<%= config.support_template %>/blog.fullwidth.html': ['<%= config.support_template %>/partials/blog.fullwidth.process.html'],
            '<%= config.support_template %>/blog.grid.html': ['<%= config.support_template %>/partials/blog.grid.process.html'],
            '<%= config.support_template %>/blog.post.html': ['<%= config.support_template %>/partials/blog.post.process.html'],
            '<%= config.support_template %>/blog.smallthumb.html': ['<%= config.support_template %>/partials/blog.smallthumb.process.html'],
            '<%= config.support_template %>/blog.standard.html': ['<%= config.support_template %>/partials/blog.standard.process.html']
        }
    }
};
