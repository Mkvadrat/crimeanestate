<?php
/*
Template name: Booking page
Theme URI: http://sandbay.ru
Description: Тема для сайта sandbay.ru
Author: M2
Author URI: http://mkvadrat.com/
Version: 1.0
*/

get_header(); 

?>







<style>#tl-search-form{display:none;}</style>

<!-- start booking form 2.0 -->
<div id="tl-booking-form"></div>
<script type="text/javascript">
(function(w){
  var q=[
    ['setContext', 'TL-INT-sandbay', 'ru'],
    ['embed', 'booking-form', {container: 'tl-booking-form'}]
  ];
  var t=w.travelline=(w.travelline||{}),ti=t.integration=(t.integration||{});ti.__cq=ti.__cq?ti.__cq.concat(q):q;
  if (!ti.__loader){ti.__loader=true;var d=w.document,p=d.location.protocol,s=d.createElement('script');s.type='text/javascript';s.async=true;s.src=(p=='https:'?p:'http:')+'//ibe.tlintegration.com/integration/loader.js';(d.getElementsByTagName('head')[0]||d.getElementsByTagName('body')[0]).appendChild(s);}
})(window);
</script>
<!-- end booking form 2.0 -->


<?php get_footer(); ?>