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
  <div class="content" style="padding:40px 0px;display:block">

    <?php if (isset($topics)) { ?>
      <div class="content">
      <?php foreach ($topics as $topic) { ?>
      <div style="margin-bottom: 10px;"><a href="<?php echo $topic['href']; ?>"><?php echo $topic['title']; ?></a></div>
      <div style="margin-bottom: 40px"><?php echo $topic['description']; ?></div>
      <?php } ?>
      </div>
    <?php } else { ?>
        <?php echo $description; ?>
    <?php } ?>
  </div>
        <!--
  <div class="buttons">
    <?php if (isset($button_faq)) { ?>
    <div class="right"><a onclick="location = '<?php echo $faq; ?>'" class="button"><span><?php echo $button_faq; ?></span></a></div>
    <?php } else { ?>
    <div class="right"><a onclick="location = '<?php echo $continue; ?>'" class="button"><span><?php echo $button_continue; ?></span></a></div>
    <?php } ?>
  </div>
        -->
</div>
</div>
  <?php echo $content_bottom; ?>

<?php echo $footer; ?>
