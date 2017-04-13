<?php echo $header; ?>

<?php //echo $column_left; ?><?php //echo $column_right; ?>
<?php echo $content_top; ?>
<div class="content">
<div class="conteiner article-container">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <h1><?php echo $heading_title; ?></h1>
    <?php if ($success) { ?>
    <div class="success"><?php echo $success; ?></div>
    <?php } ?>
  <div class="border">
  <h2><?php echo $text_my_account; ?></h2>
  <div class="content">
    <ul id="account-info-list">
      <li><a href="<?php echo $edit; ?>"><?php echo $text_edit; ?></a></li>
      <li><a href="<?php echo $password; ?>"><?php echo $text_password; ?></a></li>
        <li><a href="/index.php?route=module/favorites/favorites">Избранное</a></li>
        <!--
      <li style="display: <?php echo ($address_display ? 'li-row' : 'none'); ?>;"><a href="<?php echo $address; ?>"><?php echo $text_address; ?></a></li>
      <li><a href="<?php echo $wishlist; ?>"><?php echo $text_wishlist; ?></a></li>
      -->
    </ul>
  </div>
      <!--
  <h2><?php echo $text_my_orders; ?></h2>
  <div class="content">
    <ul>
      <li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
      <li><a href="<?php echo $download; ?>"><?php echo $text_download; ?></a></li>
      <?php if ($reward) { ?>
      <li><a href="<?php echo $reward; ?>"><?php echo $text_reward; ?></a></li>
      <?php } ?>
      <li><a href="<?php echo $return; ?>"><?php echo $text_return; ?></a></li>
      <li><a href="<?php echo $transaction; ?>"><?php echo $text_transaction; ?></a></li>
    </ul>
  </div>
  <h2><?php echo $text_customer_support; ?></h2>
  <div class="content">
    <ul>
      <li><a href="<?php echo $customer_support; ?>"><?php echo $entry_customer_support; ?></a></li>
    </ul>
  </div>
  <h2><?php echo $text_my_newsletter; ?></h2>
  <div class="content">
    <ul>
      <li><a href="<?php echo $newsletter; ?>"><?php echo $text_newsletter; ?></a></li>
    </ul>
  </div>
  </div>
  -->
</div>
</div>
  <?php echo $content_bottom; ?>
<?php echo $footer; ?> 