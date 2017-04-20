module.exports = {
    support: {
        init: {
            autoescape: false
        },
        dest: 'src',
        src: ['<%= config.support_template %>/*.swig'],
        generateSitemap: false,
        generateRobotstxt: false,
        build: true,
        dummyDatas: {
            users: [
                {'name': 'John Doe', 'avatar': 'avatar1.jpg'},
                {'name': 'John Doe', 'avatar': 'avatar1.jpg'},
                {'name': 'John Doe', 'avatar': 'avatar1.jpg'},
                {'name': 'John Doe', 'avatar': 'avatar1.jpg'}
            ],
            ticketItems: [
                {
                    'type': 'new',
                    'title': 'Angular.merge breaks sce...',
                    'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco',
                    'tags': ['#angularjs', '#nodejs', '#html'],
                    'time': '10 mins ago',
                    'user': {'name': 'John Kun', 'avatar': 'face1.jpg', 'company': 'Ember'},
                    'assigned': [
                        {'name': 'John Kun', 'avatar': 'avatar1.jpg', 'company': 'Ember'},
                        {'name': 'John Kun', 'avatar': 'avatar2.jpg', 'company': 'Ember'}
                    ]

                },
                {
                    'type': 'new',
                    'title': 'ngJq causes warning in...',
                    'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco',
                    'tags': ['#responsive','#nodejs', '#html'],
                    'time': '2 hours ago',
                    'user': {'name': 'Jim Yo', 'avatar': 'face2.jpg', 'company': 'Angular'},
                    'assigned': [
                        {'name': 'John Kun', 'avatar': 'avatar3.jpg', 'company': 'Ember'},
                        {'name': 'John Kun', 'avatar': 'avatar4.jpg', 'company': 'Ember'},
                        {'name': 'John Kun', 'avatar': 'avatar7.jpg', 'company': 'Ember'}
                    ]

                },
                {
                    'type': 'success',
                    'title': 'Incorrect events order with...',
                    'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco',
                    'tags': ['#angularjs', '#nodejs'],
                    'time': '1 day ago',
                    'user': {'name': 'Jean Done', 'avatar': 'face3.jpg', 'company': 'Company'},
                    'assigned': [
                        {'name': 'John Kun', 'avatar': 'avatar6.jpg', 'company': 'Ember'}
                    ]

                },
                {
                    'type': 'important',
                    'title': 'How to make animations...',
                    'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco',
                    'tags': ['#responsive','#html'],
                    'time': '2 day ago',
                    'user': {'name': 'Jakum Kari', 'avatar': 'face4.jpg', 'company': 'Hit GMBH'},
                    'assigned': [
                        {'name': 'John Kun', 'avatar': 'avatar7.jpg', 'company': 'Ember'}
                    ]

                },
                {
                    'type': 'new',
                    'title': 'Mouseleave not caught in...',
                    'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco',
                    'tags': ['#angularjs', '#support', '#responsive'],
                    'time': '3 day ago',
                    'user': {'name': 'Jose Alvarez', 'avatar': 'face5.jpg', 'company': 'Tuluk Inc'},
                    'assigned': [
                        {'name': 'John Kun', 'avatar': 'avatar3.jpg', 'company': 'Ember'},
                        {'name': 'John Kun', 'avatar': 'avatar7.jpg', 'company': 'Ember'}
                    ]

                },
                {
                    'type': 'success',
                    'title': 'Context hierachy is not...',
                    'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco',
                    'tags': ['#angularjs', '#support', '#responsive'],
                    'time': '6 day ago',
                    'user': {'name': 'Bam Dohh', 'avatar': 'face6.jpg', 'company': 'Hababab'},
                    'assigned': [
                        {'name': 'John Kun', 'avatar': 'avatar1.jpg', 'company': 'Ember'}
                    ]

                },
                {
                    'type': 'important',
                    'title': 'Problem with the...',
                    'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco',
                    'tags': ['#angularjs', '#support', '#responsive'],
                    'time': '10 day ago',
                    'user': {'name': 'Hit Manner', 'avatar': 'face1.jpg', 'company': 'Anonymous'},
                    'assigned': [
                        {'name': 'John Kun', 'avatar': 'avatar5.jpg', 'company': 'Ember'}
                    ]

                },
                {
                    'type': 'new',
                    'title': '$animateCss doesnt notify...',
                    'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco',
                    'tags': ['#angularjs', '#support', '#responsive'],
                    'time': '20 day ago',
                    'user': {'name': 'Right Joe', 'avatar': 'face5.jpg', 'company': 'ASDF Co.'},
                    'assigned': [
                        {'name': 'John Kun', 'avatar': 'avatar4.jpg', 'company': 'Ember'}
                    ]

                },
                {
                    'type': 'success',
                    'title': '$window.history.back...',
                    'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco',
                    'tags': ['#angularjs', '#support', '#responsive'],
                    'time': '21 day ago',
                    'user': {'name': 'Bambam Ubui', 'avatar': 'face6.jpg', 'company': 'Hibiscus'},
                    'assigned': [
                        {'name': 'John Kun', 'avatar': 'avatar6.jpg', 'company': 'Ember'},
                        {'name': 'John Kun', 'avatar': 'avatar5.jpg', 'company': 'Ember'}
                    ]

                }
            ],
            forumItems: [
                {
                    'category_name': 'AngularJS',
                    'items': [
                        {
                            'topic_name': 'Angular + typescript + gulp',
                            'description': 'Nullam est felis, tempor luctus consequat a, aliquam ut dolor',
                            'views': 33,
                            'posts': 5,
                            'tags': ['AngularJS', 'NodeJS','Html'],
                            'user': {'name': 'Hibb Jonathan', 'avatar': 'avatar1.jpg'},
                            'time': '10 mins ago',
                            'iconClass': 'icon-arrows-question text-warning'
                        },
                        {
                            'topic_name': 'Angularjs not working when using IE 9',
                            'description': 'Nullam est felis, tempor luctus consequat a, aliquam ut dolor',
                            'views': 101,
                            'posts': 30,
                            'tags': ['Jquery', 'Responsive'],
                            'user': {'name': 'Sam Newill', 'avatar': 'avatar1.jpg'},
                            'time': '1 day ago',
                            'iconClass': 'icon-arrows-circle-check text-success'
                        },
                        {
                            'topic_name': 'How to make Asnyc call using angular ?',
                            'description': 'Nullam est felis, tempor luctus consequat a, aliquam ut dolor',
                            'views': 1310,
                            'posts': 15,
                            'tags': ['AngularJS', 'Jquery'],
                            'user': {'name': 'Jona Done', 'avatar': 'avatar1.jpg'},
                            'time': '20 day ago',
                            'iconClass': 'icon-arrows-clockwise text-primary'
                        },
                        {
                            'topic_name': 'Looking For AngularJS development projects',
                            'description': 'Nullam est felis, tempor luctus consequat a, aliquam ut dolor',
                            'views': 5454,
                            'posts': 150,
                            'tags': ['AngularJS'],
                            'user': {'name': 'Baktat Hamar', 'avatar': 'avatar1.jpg'},
                            'time': '30 day ago',
                            'iconClass': 'icon-arrows-info text-danger'
                        }
                    ]
                },
                {
                    'category_name': 'Second category',
                    'items': [
                                                {
                            'topic_name': 'Angular + typescript + gulp',
                            'description': 'Nullam est felis, tempor luctus consequat a, aliquam ut dolor',
                            'views': 33,
                            'posts': 5,
                            'tags': ['AngularJS', 'NodeJS','Html'],
                            'user': {'name': 'Hibb Jonathan', 'avatar': 'avatar1.jpg'},
                            'time': '10 mins ago',
                            'iconClass': 'icon-arrows-question text-warning'
                        },
                        {
                            'topic_name': 'Angularjs not working when using IE 9',
                            'description': 'Nullam est felis, tempor luctus consequat a, aliquam ut dolor',
                            'views': 101,
                            'posts': 30,
                            'tags': ['Jquery', 'Responsive'],
                            'user': {'name': 'Sam Newill', 'avatar': 'avatar1.jpg'},
                            'time': '1 day ago',
                            'iconClass': 'icon-arrows-circle-check text-success'
                        },
                        {
                            'topic_name': 'How to make Asnyc call using angular ?',
                            'description': 'Nullam est felis, tempor luctus consequat a, aliquam ut dolor',
                            'views': 1310,
                            'posts': 15,
                            'tags': ['AngularJS', 'Jquery'],
                            'user': {'name': 'Jona Done', 'avatar': 'avatar1.jpg'},
                            'time': '20 day ago',
                            'iconClass': 'icon-arrows-clockwise text-primary'
                        },
                        {
                            'topic_name': 'Looking For AngularJS development projects',
                            'description': 'Nullam est felis, tempor luctus consequat a, aliquam ut dolor',
                            'views': 5454,
                            'posts': 150,
                            'tags': ['AngularJS'],
                            'user': {'name': 'Baktat Hamar', 'avatar': 'avatar1.jpg'},
                            'time': '30 day ago',
                            'iconClass': 'icon-arrows-info text-danger'
                        }
                    ]
                },
                {
                    'category_name': 'Third category',
                    'items': [
                                                {
                            'topic_name': 'Angular + typescript + gulp',
                            'description': 'Nullam est felis, tempor luctus consequat a, aliquam ut dolor',
                            'views': 33,
                            'posts': 5,
                            'tags': ['AngularJS', 'NodeJS','Html'],
                            'user': {'name': 'Hibb Jonathan', 'avatar': 'avatar1.jpg'},
                            'time': '10 mins ago',
                            'iconClass': 'icon-arrows-question text-warning'
                        },
                        {
                            'topic_name': 'Angularjs not working when using IE 9',
                            'description': 'Nullam est felis, tempor luctus consequat a, aliquam ut dolor',
                            'views': 101,
                            'posts': 30,
                            'tags': ['Jquery', 'Responsive'],
                            'user': {'name': 'Sam Newill', 'avatar': 'avatar1.jpg'},
                            'time': '1 day ago',
                            'iconClass': 'icon-arrows-circle-check text-success'
                        },
                        {
                            'topic_name': 'How to make Asnyc call using angular ?',
                            'description': 'Nullam est felis, tempor luctus consequat a, aliquam ut dolor',
                            'views': 1310,
                            'posts': 15,
                            'tags': ['AngularJS', 'Jquery'],
                            'user': {'name': 'Jona Done', 'avatar': 'avatar1.jpg'},
                            'time': '20 day ago',
                            'iconClass': 'icon-arrows-clockwise text-primary'
                        },
                        {
                            'topic_name': 'Looking For AngularJS development projects',
                            'description': 'Nullam est felis, tempor luctus consequat a, aliquam ut dolor',
                            'views': 5454,
                            'posts': 150,
                            'tags': ['AngularJS'],
                            'user': {'name': 'Baktat Hamar', 'avatar': 'avatar1.jpg'},
                            'time': '30 day ago',
                            'iconClass': 'icon-arrows-info text-danger'
                        }
                    ]
                }
            ],
            knowledgebase: [
                {
                    'category_name': 'Basic questions & Answers',
                    'items': [
                        {
                            'item_icon': 'icon-basic icon-basic-life-buoy',
                            'item_name': 'Accounting',
                            'item_items': ['Upgrading Themes', 'Design and Layout', 'Finding More Plugin Help', 'Theme Development', 'Plugin Resources', 'Manual Upgrades']
                        },
                        {
                            'item_icon': 'icon-basic icon-basic-folder-multiple',
                            'item_name': 'Backup and Data Recovery',
                            'item_items': ['My Account', 'Changing My Account', 'How Can I Login', 'Increasing Email Quota', 'How do I Start FTP?', 'Lorem Ipsum']
                        },
                        {
                            'item_icon': 'icon-basic icon-basic-floppydisk',
                            'item_name': 'Conferences',
                            'item_items': ['Disabled Comments', 'Setting up attributes', 'Increasing Memory', 'Shipping Methods', 'Theme Set Up', 'Setting up attributes']
                        },
                        {
                            'item_icon': 'icon-basic icon-basic-info',
                            'item_name': 'Consulting',
                            'item_items': ['Increasing Memory', 'How Can I Login', 'Customizing Forms', 'My Account', 'Setting up attributes', 'Manual Upgrades']
                        },
                        {
                            'item_icon': 'icon-basic icon-basic-webpage-img-txt',
                            'item_name': 'E-Commerce',
                            'item_items': ['Customizing Forms', 'Setting up attributes', 'Downloadable product', 'How Can I Login', 'Increasing Memory', 'Shipping Methods']
                        },
                        {
                            'item_icon': 'icon-basic icon-basic-life-buoy',
                            'item_name': 'Financial',
                            'item_items': ['How Can I Login', 'Increasing Memory', 'Shipping Methods', 'Customizing Forms', 'How Can I Login', 'Downloadable product']
                        }

                    ]
                },
                {
                    'category_name': 'Common Questions',
                    'items': [
                        {
                            'item_icon': 'icon-basic icon-basic-life-buoy',
                            'item_name': 'Accounting',
                            'item_items': ['Upgrading Themes', 'Design and Layout', 'Finding More Plugin Help', 'Theme Development', 'Plugin Resources', 'Manual Upgrades']
                        },
                        {
                            'item_icon': 'icon-basic icon-basic-folder-multiple',
                            'item_name': 'Backup and Data Recovery',
                            'item_items': ['My Account', 'Changing My Account', 'How Can I Login', 'Increasing Email Quota', 'How do I Start FTP?', 'Lorem Ipsum']
                        },
                        {
                            'item_icon': 'icon-basic icon-basic-floppydisk',
                            'item_name': 'Conferences',
                            'item_items': ['Disabled Comments', 'Setting up attributes', 'Increasing Memory', 'Shipping Methods', 'Theme Set Up', 'Setting up attributes']
                        }

                    ]
                },
                {
                    'category_name': 'Basic questions & Answers',
                    'items': [
                        {
                            'item_icon': 'icon-basic icon-basic-life-buoy',
                            'item_name': 'Accounting',
                            'item_items': ['Upgrading Themes', 'Design and Layout', 'Finding More Plugin Help', 'Theme Development', 'Plugin Resources', 'Manual Upgrades']
                        },
                        {
                            'item_icon': 'icon-basic icon-basic-folder-multiple',
                            'item_name': 'Backup and Data Recovery',
                            'item_items': ['My Account', 'Changing My Account', 'How Can I Login', 'Increasing Email Quota', 'How do I Start FTP?', 'Lorem Ipsum']
                        },
                        {
                            'item_icon': 'icon-basic icon-basic-floppydisk',
                            'item_name': 'Conferences',
                            'item_items': ['Disabled Comments', 'Setting up attributes', 'Increasing Memory', 'Shipping Methods', 'Theme Set Up', 'Setting up attributes']
                        },
                        {
                            'item_icon': 'icon-basic icon-basic-info',
                            'item_name': 'Consulting',
                            'item_items': ['Increasing Memory', 'How Can I Login', 'Customizing Forms', 'My Account', 'Setting up attributes', 'Manual Upgrades']
                        },
                        {
                            'item_icon': 'icon-basic icon-basic-webpage-img-txt',
                            'item_name': 'E-Commerce',
                            'item_items': ['Customizing Forms', 'Setting up attributes', 'Downloadable product', 'How Can I Login', 'Increasing Memory', 'Shipping Methods']
                        },
                        {
                            'item_icon': 'icon-basic icon-basic-life-buoy',
                            'item_name': 'Financial',
                            'item_items': ['How Can I Login', 'Increasing Memory', 'Shipping Methods', 'Customizing Forms', 'How Can I Login', 'Downloadable product']
                        }

                    ]
                },
            ],
            blogItems:[
                {
                    tag:'Javascript',
                    user: {'name': 'John Kun', 'avatar': 'face1.jpg', 'company': 'Ember'},
                    time:'17th Jan 2015',
                    title:'Get Global Variables with JavaScript',
                    content:'JavaScript globals are considered bad.  And as a contributor to the MooTools project, Ive heard this on a daily basis for the better part of a decade.  MooTools got knocked for extending natives but also for placing objects in the global space, like Browser and $$.  I find the "global vars are terrible" philosophy a bit funny since even jQuery and JavaScript loaders use a global variable.',
                    likes:10,
                    comments:4,
                    img:'img/bgimg/big/27.jpg'
                },
                {
                    tag:'Programming',
                    user: {'name': 'Buck Jon', 'avatar': 'face2.jpg', 'company': 'NodeJS'},
                    time:'20th Jan 2015',
                    title:'Creating an Isomorphic Blogging app Using React and Flux',
                    content:'One of the many benefits of React is its ability to render the components on both client and server. This tutorial aims to teach you how to create isomorphic apps using React and Flux architecture. We will also create a simple blogging app to understand how exactly Flux and React fit together.',
                    likes:1,
                    comments:10,
                    img:'img/bgimg/big/26.jpg'
                },
                {
                    tag:'News',
                    user: {'name': 'Dimitry Doe', 'avatar': 'face3.jpg', 'company': 'Corp.'},
                    time:'30th June 2015',
                    title:'Googles Angular 2 Survey Results',
                    content:'JavaScript globals are considered bad.  And as a contributor to the MooTools project, Ive heard this on a daily basis for the better part of a decade.  MooTools got knocked for extending natives but also for placing objects in the global space, like Browser and $$.  I find the "global vars are terrible" philosophy a bit funny since even jQuery and JavaScript loaders use a global variable.',
                    likes:10,
                    comments:4,
                    img:'img/bgimg/big/6.jpg'
                },
                {
                    tag:'Javascript',
                    user: {'name': 'Micheal Corl', 'avatar': 'face5.jpg', 'company': 'E-corp.'},
                    time:'17th Jan 2015',
                    title:'Get Global Variables with JavaScript',
                    content:'The AngularJS team presents the results of a survey carried out by Jeff Whelpley and Patrick Stapleton. This survey treats with how developers are going to use the upcoming AngularJS 2.x branch.',
                    likes:33,
                    comments:1,
                    img:'img/bgimg/big/28.jpg'
                },
                {
                    tag:'Angular2',
                    user: {'name': 'Steven Hobbson', 'avatar': 'face6.jpg', 'company': 'Methano'},
                    time:'17th Dec 2015',
                    title:'Angular 2 Series - Part 1: Working with Pipes',
                    content:'Learn how to implement pipes (formerly known as filters) in your Angular 2 apps in this tutorial from Auth0.',
                    likes:10,
                    comments:4,
                    img:'img/bgimg/big/4.jpg'
                },
                {
                    tag:'JQuery',
                    user: {'name': 'Lisa Dohhh', 'avatar': 'face4.jpg', 'company': 'Ember'},
                    time:'17th Jan 2015',
                    title:'jQuery Foundation and Dojo Foundation to Merget',
                    content:'The jQuery Foundation and Dojo Foundation today announce plans to combine forces to form the largest, most diverse and most comprehensive Foundation committed to building the Open Web by serving developers, their projects and their communities.',
                    likes:10,
                    comments:4,
                    img:'img/bgimg/big/10.jpg'
                },
                {
                    tag:'Javascript',
                    user: {'name': 'Vegas Indie', 'avatar': 'face1.jpg', 'company': 'Ember'},
                    time:'17th Jan 2015',
                    title:'JavaScript WebM encode',
                    content:'webm.js is a simple one-page application that allows you to convert videos to WebM format, without any plugins or server-side involved. It is built upon FFmpeg which was ported to JavaScript using Emscripten. Since WebM is part of HTML5 stack, why cant we create one without leaving the browser?',
                    likes:233,
                    comments:43,
                    img:'img/bgimg/big/17.jpg'
                },
                {
                    tag:'Tipps',
                    user: {'name': 'John Kun', 'avatar': 'face1.jpg', 'company': 'Ember'},
                    time:'17th Jan 2015',
                    title:'Is Isomorphic JavaScript a good term?',
                    content:'A recent trend in the web development world is to use JavaScript on the server to assemble pages there, with the same code that is used to manage them in the client. Michael Jackson proposes the term “Universal JavaScript” instead of "Isomorphic JavaScript.”',
                    likes:22,
                    comments:12,
                    img:'img/bgimg/big/11.jpg'
                }
            ],
            blogGridItems:[
                {
                   size:5, 
                   tag:'javascript',
                   tagcolor:'info',
                   type:'main',
                   title:'Googles Angular 2 Survey Results',
                   content:'JavaScript globals are considered bad.  And as a contributor to the MooTools project, Ive heard this on a daily basis...',
                   time:'23/07/2015',
                   likes:22,
                   views:21,
                   user: {'name': 'John Kun', 'avatar': 'face1.jpg', 'company': 'Ember'}
                },
                {
                   size:3, 
                   tag:'courses',
                   type:'card',
                   title:'AngularJS courses',
                   content:'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore.',
                   cover:'bg-yellow',
                   textcolor:'text-def'
                },
                {
                   size:4, 
                   tag:'Buyer Tricks',
                   tagcolor:'primary',
                   type:'secondary',
                   title:'The Importance of Context-Shifting in UX Patterns',
                   content:'Have you ever had a day at work where you were constantly put towards a new task as you were ramping up on the current one?',
                   time:'20/08/2015',
                   likes:11,
                   views:33,
                   user: {'name': 'Oslo Jane', 'avatar': 'face6.jpg', 'company': 'Ember'}
                },
                {
                   size:4, 
                   tag:'CSS/LESS',
                   tagcolor:'primary',
                   type:'imgcard',
                   title:'The anatomy of responsive images',
                   content:'Lorem ipsum dolor sit amet',
                   cover:'img/bgimg/big/22.jpg'
                },
                {
                   size:5, 
                   tag:'JQuery',
                   tagcolor:'success',
                   type:'main',
                   title:'jQuery Foundation and Dojo Foundation to Merget',
                   content:'The jQuery Foundation and Dojo Foundation today announce plans to combine forces to form the largest, most diverse and most comprehensive...',
                   time:'21/06/2015',
                   likes:222,
                   views:211,
                   user: {'name': 'Zimbik Jones', 'avatar': 'face2.jpg', 'company': 'Ember'}
                },
                {
                   size:3, 
                   tag:'javascript',
                   type:'card',
                   title:'NodeJS tutorials',
                   content:'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.',
                   cover:'bg-purple',
                   textcolor:'text-white'
                },
                {
                   size:6, 
                   tag:'Backend dev',
                   tagcolor:'info',
                   type:'main',
                   title:'Is Isomorphic JavaScript a good term?',
                   content:'A recent trend in the web development world is to use JavaScript on the server to assemble pages there, with the same code that...',
                   time:'03/05/2015',
                   likes:22,
                   views:21,
                   user: {'name': 'Tick Tucker', 'avatar': 'face5.jpg', 'company': 'Ember'}
                },
                {
                   size:6, 
                   tag:'tipps & tricks',
                   tagcolor:'primary',
                   type:'main',
                   title:'Angular 2 Series - Part 1: Working with Pipes',
                   content:'Learn how to implement pipes (formerly known as filters) in your Angular 2 apps in this tutorial from Auth0',
                   time:'23/07/2015',
                   likes:22,
                   views:21,
                   user: {'name': 'Jon Done', 'avatar': 'face1.jpg', 'company': 'Ember'}
                },
                {
                   size:4, 
                   tag:'Tutorials',
                   tagcolor:'success',
                   type:'secondary',
                   title:'How to make Asnyc call using angular ?',
                   content:'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor.Lorem ipsum dolor sit amet...',
                   time:'10/04/2015',
                   likes:22,
                   views:21,
                   user: {'name': 'Bick Humbuj', 'avatar': 'face3.jpg', 'company': 'Ember'}
                },
                {
                   size:4, 
                   tag:'programming',
                   tagcolor:'info',
                   type:'imgcard',
                   title:'AngularJS apps',
                   content:'Sed do eiusmod tempor. Lorem ipsum dolor sit amet, consectetur... ',
                   cover:'img/bgimg/big/10.jpg'
                },
                {
                   size:4, 
                   tag:'design',
                   tagcolor:'primary',
                   type:'imgcard',
                   title:'UX inspirations',
                   content:'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor.',
                   cover:'img/bgimg/big/21.jpg'
                },
                {
                   size:3, 
                   tag:'courses',
                   type:'card',
                   title:'AngularJS courses',
                   content:'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore.',
                   cover:'bg-yellow',
                   textcolor:'text-def'
                },
                {
                   size:4, 
                   tag:'Buyer Tricks',
                   tagcolor:'success',
                   type:'secondary',
                   title:'The Importance of Context-Shifting in UX Patterns',
                   content:'Have you ever had a day at work where you were constantly put towards a new task as you were ramping up on the current one?',
                   time:'20/08/2015',
                   likes:11,
                   views:33,
                   user: {'name': 'Oslo Jane', 'avatar': 'face6.jpg', 'company': 'Ember'}
                },
                {
                   size:5, 
                   tag:'javascript',
                   tagcolor:'primary',
                   type:'main',
                   title:'Googles Angular 2 Survey Results',
                   content:'JavaScript globals are considered bad.  And as a contributor to the MooTools project, Ive heard this on a daily basis...',
                   time:'23/07/2015',
                   likes:22,
                   views:21,
                   user: {'name': 'John Kun', 'avatar': 'face1.jpg', 'company': 'Ember'}
                },
                {
                   size:4, 
                   tag:'CSS/LESS',
                   tagcolor:'success',
                   type:'imgcard',
                   title:'The anatomy of responsive images',
                   content:'Lorem ipsum dolor sit amet',
                   cover:'img/bgimg/big/22.jpg'
                },
                {
                   size:3, 
                   tag:'javascript',
                   tagcolor:'success',
                   type:'card',
                   title:'NodeJS tutorials',
                   content:'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.',
                   cover:'bg-purple',
                   textcolor:'text-white'
                },
                
                {
                   size:5, 
                   tag:'JQuery',
                   tagcolor:'info',
                   type:'main',
                   title:'jQuery Foundation and Dojo Foundation to Merget',
                   content:'The jQuery Foundation and Dojo Foundation today announce plans to combine forces to form the largest, most diverse and most comprehensive...',
                   time:'21/06/2015',
                   likes:222,
                   views:211,
                   user: {'name': 'Zimbik Jones', 'avatar': 'face2.jpg', 'company': 'Ember'}
                },
                {
                   size:3, 
                   tag:'inpspiration',
                   type:'card',
                   title:'UX/UI inspirations',
                   content:'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.',
                   cover:'bg-white',
                   textcolor:'text-def'
                },
                {
                   size:6, 
                   tag:'Backend dev',
                   tagcolor:'info',
                   type:'main',
                   title:'Is Isomorphic JavaScript a good term?',
                   content:'A recent trend in the web development world is to use JavaScript on the server to assemble pages there, with the same code that...',
                   time:'03/05/2015',
                   likes:22,
                   views:21,
                   user: {'name': 'Tick Tucker', 'avatar': 'face5.jpg', 'company': 'Ember'}
                },
                {
                   size:3, 
                   tag:'javascript',
                   type:'card',
                   title:'JQuery courses',
                   content:'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.',
                   cover:'bg-yellow',
                   textcolor:'text-def'
                },
            ]
        }
    }
};