jQuery.extend(jQuery.easing, {
    def: 'easeOutQuad',
    easeInOutExpo: function (x, t, b, c, d) {
        if (t == 0)
            return b;
        if (t == d)
            return b + c;
        if ((t /= d / 2) < 1)
            return c / 2 * Math.pow(2, 10 * (t - 1)) + b;
        return c / 2 * (-Math.pow(2, -10 * --t) + 2) + b;
    }
});

function yScrollEvent(){
    var nav = $('#header');
    var yPos = window.pageYOffset;
    var bWidth = $(window).width();
    var sOffset = bWidth>768 ? 300 : 300;
    nav.removeClass("navbar-styled");
    $("#brand-logo").attr("src","img/yeapp-logo-dk.png");
    if (yPos > sOffset) {
        nav.addClass("navbar-styled");
        $("#brand-logo").attr("src","img/mobioffers-logo.png"); 
    }
}

function resizeEvent(){
    setHomeHeight($(window).height());
    yScrollEvent();
}

function setHomeHeight(height){
    $('#home').css('height',height+'px');
}

NProgress.start();
$(window).load(function(){
    $(window).scroll(yScrollEvent);
    $(window).resize(resizeEvent);
    yScrollEvent();
    resizeEvent();
    $("body").addClass('site-loaded');
    NProgress.done();
});

$(document).ready(function() {
    
});

WOW = new WOW({
    boxClass: 'wow', // animated element css class (default is wow)
    animateClass: 'animated', // animation css class (default is animated)
    offset: 0, // distance to the element when triggering the animation (default is 0)
    mobile: false        // trigger animations on mobile devices (true is default)
});
WOW.init();

$(document).on('click.app', '[data-ride="scroll"]', function (e) {
    e.preventDefault();
    var $target = this.hash;
    var top = 59;
    $target === "#home" ? top = 0 : "";
    var offset = Math.abs(Math.round($($target).offset().top - top));
    $target = $target.replace("#", "");

    $('html, body').animate({
        'scrollTop': offset
    }, 1000, 'easeInOutExpo', function () {
        window.location.hash = '#' + $target;
        return false;
    });
    return false;
});