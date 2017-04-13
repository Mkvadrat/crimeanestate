<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
    <?php echo $content_top; ?>
<div class="content">
    <div class="conteiner  article-container">
        <div class="breadcrumb">
            <?php foreach ($breadcrumbs as $breadcrumb) { ?>
                <?php if (empty($breadcrumb['current'])): ?>
                    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
                <?php else: ?>
                    <?php echo $breadcrumb['separator']; ?><span rel="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></span>
                <?php endif; ?>
            <?php } ?>
        </div>
        <?php if (isset($blog_head)) //echo $blog_head; ?>
        <h1><?php echo $heading_title; ?></h1>
        <div class="border">
            <?php if (!empty($image)): ?>
                <img src="<?php echo $image ?>" style="display:block;max-height:300px;margin:20px auto" />
            <?php endif; ?>
            <?php echo $description; ?>

        </div>
</div>
</div>
        <?php echo $content_bottom; ?>
<?php echo $footer; ?>