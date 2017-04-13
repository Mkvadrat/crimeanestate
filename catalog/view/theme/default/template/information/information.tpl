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
  <?php echo $description; ?>
  <!--
  <div class="buttons">
    <div class="right"><a href="<?php echo $continue; ?>" class="button"><?php echo $button_continue; ?></a></div>
  </div>
  -->
  
<?php if($downloads){ ?>
<?php foreach($downloads as $download){ ?>
<div class="downloads-table">
	<table>
		<tr class="downloads-tr">
			<?php if(!empty($download['description'])){?>
				<td class="downloads-td-1">
					<?php echo $download['description']; ?>
				</td>
			<?php }else{ ?>
				<td class="downloads-td-1-1"><?php echo $download['name']; ?></td>
			<?php } ?>
				<td class="downloads-td-2">
					<div class="download-link"><a href="<?php echo $download['href']; ?>" title=""><img src="catalog/view/theme/default/img/download.png"><div class="title-download">Скачать</div></a></div>
				</td>
		</tr>
	</table>
</div>
<?php } ?>
<?php } ?>
  
  </div>
</div>
</div>
<?php echo $content_bottom; ?>
<?php echo $footer; ?>