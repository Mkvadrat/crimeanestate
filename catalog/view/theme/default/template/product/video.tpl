<?php echo $header; ?><?php echo $column_right; ?>
<?php echo $content_top; ?>
<div class="content">
    <div class="conteiner">

        <div class="row">
            <div class="breadcrumb">
                <?php
                $count = count($breadcrumbs);
                $i=1;
                foreach ($breadcrumbs as $breadcrumb) {
                    if($i!=$count){
                        echo $breadcrumb['separator']; ?>
                        <a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
                    <?php
                    }
                    else{
                        echo $breadcrumb['separator']; ?><?php echo $breadcrumb['text']; ?>
                    <?php }
                    $i++;
                } ?>
            </div>

            <div class="cont-block-rows">

                <style>
                iframe {
                    width: 960px;
                    height: 540px;
                }
                </style>

                <?php if ($video) { ?>

                    <?php echo $video ?>

                <?php } ?>
            </div>
        </div>

    </div>
</div>

<?php echo $content_bottom; ?>

<?php echo $footer; ?>