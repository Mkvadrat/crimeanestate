<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
<?php echo $content_top; ?>
<div class="content">
<div class="conteiner article-container">

  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <h1><?php echo $heading_title; ?></h1>
  <div class="border">
  <?php if ($article) { ?>
  <div class="product-list">
    <?php foreach ($article as $articles) { ?>
    <div>
	<?php if ($articles['thumb']) { ?>
      <div class="image"><a href="<?php echo $articles['href']; ?>"><img src="<?php echo $articles['thumb']; ?>" title="<?php echo $articles['name']; ?>" alt="<?php echo $articles['name']; ?>" /></a></div>
      <?php } ?>
<span class="news-dates">29.11.14</span>
      <div class="news-story-title"><a href="<?php echo $articles['href']; ?>"><?php echo $articles['name']; ?></a> </div>
      <div class="description"><?php echo $articles['description']; ?></div>
	  <?php if ($articles['acom']) { ?>
	  <span class="news-dates"><?php echo $text_comments; ?>: <?php echo $articles['total_comments']; ?></span>
	  <?php } ?>
	  <div class="read_more"><a  href="<?php echo $articles['href']; ?>"><?php echo $button_more; ?></a></div>
    </div>
    <?php } ?>
  </div>
  <div class="pagination"><?php echo $pagination; ?></div>
  <?php } ?>
  <?php if (!$article) { ?>
  <div class="content"><?php echo $text_empty; ?></div>
  <div class="buttons">
    <div class="right"><a href="<?php echo $continue; ?>" class="button"><span><?php echo $button_continue; ?></span></a></div>
  </div>
  <?php } ?>
  </div>
</div>
</div>
  <?php echo $content_bottom; ?>
    <script type="text/javascript">
        window.onload = function(){
            jQuery('html, body').animate({scrollTop:580}, 'fast');
        }
    </script>
<?php echo $footer; ?>