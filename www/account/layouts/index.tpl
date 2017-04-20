<!DOCTYPE html>
<html data-ng-app="app" data-resize-browser>
<head>
    <meta charset="UTF-8" />
    <meta name="description" content="MobiOffers" />
    <meta name="viewport" content="width=device-width" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />

    <title>MobiOffers</title>

    <link rel="stylesheet" href="fonts/opensans/font.css" type="text/css" />
    <link rel="stylesheet" href="icons/font-awesome-4.2.0/css/font-awesome.min.css" type="text/css" />
    <link rel="stylesheet" href="css/app.min.css" />

    <script>
        window.user = <?php echo $view->user ?? '{}'; ?>;
    </script>
</head>
<body
    data-ng-controller="RootCtrl"
    class="{{$root.app.settings.theme}}"
    data-breakpoint="{0:'screen-xs', 768:'screen-sm', 992:'screen-md', 1200:'screen-lg'}"
    data-ng-class="{
        'app-aside-folded':!$root.app.settings.asideFolded,
        'app-aside-show':$root.app.settings.asideFolded,
        'app-aside-fixed':$root.app.settings.asideFixed,
        'app-aside-docked':$root.app.settings.asideDocked,
        'app-aside-hover':$root.app.settings.asideHover,
        'app-header-fixed':$root.app.settings.headerFixed,
        'app-footer-fixed':$root.app.settings.footerFixed,
        'app-layout-application':$root.app.settings.layoutApplication}">

    <!--[if lt IE 8]>
    <p class="browsehappy">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
    <![endif]-->

    <!-- start: App Preloader -->
    <div id="app-preloader" data-ng-class="{'nodisplay':$root.systemLoaded}">
        <div id="app-preloader-wrapper">
            <img src="img/logos/mobioffers-logo.png" class="normal-logo">
            <!-- <img src="img/preloader.gif" alt="preloader"> -->
        </div>
    </div>
    <!-- end: App Preloader -->

    <!-- start: App Holder -->
    <div class="app" data-ui-view></div>
    <!-- end: App Holder -->

    <!-- start: Toaster directive -->
    <div data-toaster-container></div>
    <!-- end: Toaster directive -->

    <!-- start: App Top Dropdown -->
    <div class="app-top-dropdown" data-app-top-drop-down data-ng-include data-src="'views/app.topdropdown.html'"></div>
    <!-- end: App Top Dropdown -->

    <!-- start: App Search -->
    <div class="app-search" data-app-search data-ng-include data-src="'views/app.search.html'"></div>
    <!-- end: App Search -->

    <!-- start: App Quickview -->
    <div class="app-quickview" data-app-quickview data-ng-include data-src="'views/app.quickview.html'"></div>
    <!-- end: App Quickview -->

    <!-- start: App settings (just for the demo) -->
    <!--div id="app-settings-demo" data-ng-class="{'closed':!settingsSide}" data-ng-init="settingsSide = false" data-ng-include data-src="'views/app.settings.html'"></div-->
    <!-- end: App settings -->

    <!--[if lt IE 9]>
    <script src="bower_components/es5-shim/es5-shim.js"></script>
    <script src="bower_components/json3/lib/json3.js"></script>
    <![endif]-->

    <script src="scripts/app.min.js"></script>
</body>
</html>