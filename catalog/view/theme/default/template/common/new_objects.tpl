<?php if (!empty($products)) : ?>
<div class="row bg-grey">
    <div class="conteiner">
        <div class="block-3">
            <h2>НОВОСТРОЙКИ <a href="<?php echo $category_href ?>">СМОТРЕТЬ ВСЕ</a></h2>

            <ul>
                <?php foreach ($products as $product) { ?>

                    <li>
                        <div class="novostroyki-img">
                            <?php if ($product['thumb']) { ?>
                                <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>"/></a>
                            <?php } else { ?>
                                <a href="<?php echo $product['href']; ?>"><img src="/catalog/view/theme/default/img/nophoto.png" alt="Нет изображения"/></a>
                            <?php } ?>
                            <div class="novostroyki-cena">
                                <?php if (!$product['special']) { ?>
                                    Цена <?php echo $product['rub']; ?> руб. / <?php echo $product['price']; ?> $
                                <?php } else { ?>
                                    <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
                                <?php } ?>
                            </div>
                        </div>
                        <a href="<?php echo $product['href']; ?>"><h3><?php echo $product['name']; ?></h3></a>
                        <p>
                            <?php echo $product['description'] ?>
                        </p>
                        <!--<a href="<?php echo $product['href']; ?>">Читать описание полностью</a>-->

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
    </div>
</div>
<?php endif; ?>