<div id="banner<?php echo $module; ?>" class="banner">
  <?php foreach ($banners as $banner) { ?>
  <?php if ($banner['link']) { ?>
  <div><a href="<?php echo $banner['link']; ?>"><img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" title="<?php echo $banner['title']; ?>" /></a></div>
  <?php } else { ?>
  <div><img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" title="<?php echo $banner['title']; ?>" /></div>
  <?php } ?>
  <?php } ?>
</div>
<script type="text/javascript"><!--
jQuery(document).ready(function() {
	jQuery('#banner<?php echo $module; ?> div:first-child').css('display', 'block');
});

var banner = function() {
	jQuery('#banner<?php echo $module; ?>').cycle({
		before: function(current, next) {
			jQuery(next).parent().height(jQuery(next).outerHeight());
		}
	});
}

setTimeout(banner, 2000);
//--></script>