<div class="box">
  <div class="box-heading"><?php echo $heading_title; ?></div>
  <div class="box-content">
    <div class="box-gallery">
  <?php foreach ($gallimages as $gallimage) { ?>
  <div style="width:<?php echo $widthdiv; ?>px;">
  <?php if ($gallimage['link']) { ?>
  <div class="image"><a href="<?php echo $gallimage['popup']; ?>" title="<?php echo $gallimage['title']; ?>" class="colorbox<?php echo $module; ?>"><img src="<?php echo $gallimage['image']; ?>" alt="<?php echo $gallimage['title']; ?>" title="<?php echo $gallimage['title']; ?>" /></a></div>
  <?php if ($gallimage['title']) { ?>
  <div class="name"><a href="<?php echo $gallimage['link']; ?>"><?php echo $gallimage['title']; ?></a></div>
  <?php } ?>
  <?php } else { ?>
  <div class="image"><a href="<?php echo $gallimage['popup']; ?>" title="<?php echo $gallimage['title']; ?>" class="colorbox<?php echo $module; ?>"><img src="<?php echo $gallimage['image']; ?>" alt="<?php echo $gallimage['title']; ?>" title="<?php echo $gallimage['title']; ?>" /></a></div>
  <?php if ($gallimage['title']) { ?>
  <div class="name"><?php echo $gallimage['title']; ?></div>
  <?php } ?>
  <?php } ?>
  </div>
  <?php } ?>
	</div>
  </div>
</div>
<script type="text/javascript"><!--
$(document).ready(function() {
	$('.colorbox<?php echo $module; ?>').colorbox({
		overlayClose: true,
		opacity: 0.5,
		rel: "colorbox<?php echo $module; ?>"
	});
});
//--></script> 
<style type="text/css">
.box-gallery {
	width: 100%;
	overflow: auto;
}
.box-gallery > div {
	display: inline-block;
	text-align:center;
	vertical-align: top;
	margin-left:6px;
	margin-right:6px;
	margin-top: 8px;
	margin-bottom: 8px;
	padding:8px;
}
.box-gallery .image {
	display: block;
	margin-bottom: 10px;
}
.box-gallery .image img {
	padding: 3px;
	border:1px solid #EEE;
}
.box-gallery .name {
	margin-bottom: 4px;
}
.box-gallery .name a {
	font-weight: bold;
	text-decoration: none;
	display: block;
}
</style>