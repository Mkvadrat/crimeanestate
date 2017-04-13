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
                <?php if ($products) { ?>

                    <div class="block-3" id="grid-line-modifier" style="padding-top:0px">
                        <ul class="products-ul">
                            <?php foreach ($products as $product) { ?>

                                <li>
                                    <div class="novostroyki-img">
                                        <?php if ($product['thumb']) { ?>
                                            <img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>"/>
                                        <?php } else { ?>
                                            <img src="/catalog/view/theme/default/img/nophoto.png" alt="Нет изображения"/>
                                        <?php } ?>
                                        <div class="novostroyki-cena">
                                            <?php if (!$product['special']) { ?>
                                                Цена <?php echo $product['rub']; ?> руб. / <?php echo $product['price']; ?> $
                                            <?php } else { ?>
                                                <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
                                            <?php } ?>
                                        </div>
                                    </div>
                                    <h3><?php echo $product['name']; ?></h3>
                                    <p>
                                        <?php echo $product['description'] ?>
                                    </p>
                                    <a href="<?php echo $product['href']; ?>">Читать описание полностью</a>

                                    <div class="novostroyki-media">
                                        <?php if ($product['video']): ?>
                                            <a href="<?php echo $product['video_href']; ?>"><img src="/catalog/view/theme/default/img/Video_play.png" alt=""/></a>
                                        <?php endif; ?>
                                        <?php if ($product['thumb']): ?>
                                            <a href="<?php echo $product['gallery_href']; ?>"><img src="/catalog/view/theme/default/img/images_play.png" alt=""/></a>
                                        <?php endif; ?>
                                    </div>

                                </li>

                            <?php } ?>
                        </ul>
                    </div>
                    <!--<div class="pagination"><?php echo $pagination; ?></div>-->
                <?php } else { ?>
                    <p>Нет избранных объектов</p>
                <?php } ?>
            </div>
        </div>
    </div>
</div>
<?php echo $content_bottom; ?>
<?php echo $footer; ?>