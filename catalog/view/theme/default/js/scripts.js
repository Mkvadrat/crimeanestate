function include(scriptUrl) {
    document.write('<script src="' + scriptUrl + '"></script>');
}










/* SMOOTH SCROLLIG
 ========================================================*/
;
(function (jQuery) {
    var o = jQuery('html');
    if (o.hasClass('desktop')) {
        include('js/jquery.mousewheel.min.js');
        include('js/jquery.simplr.smoothscroll.min.js');

        jQuery(document).ready(function () {
            jQuery.srSmoothscroll({
                step: 150,
                speed: 800
            });
        });
    }
})(jQuery);


















	







