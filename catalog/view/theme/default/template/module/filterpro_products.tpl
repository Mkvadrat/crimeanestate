<?php foreach ($products as $product) { ?>
        <li>
            <div class="novostroyki-img">
            <?php if ($product['thumb']) { ?>
                <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>"/></a>
            <?php } else { ?>
                <a href="<?php echo $product['href']; ?>"><img src="/catalog/view/theme/default/img/nophoto.png" alt="Нет изображения"/></a>
            <?php } ?>
						
			<?php if($product['badge'] && trim($product['badge'])!='sold'){ ?>
                <?php if(empty($product['price']) || empty($product['rub'])){ ?>
                    <div class="novostroyki-cena">Цена по запросу&nbsp;&nbsp;</div>
				<?php } ?>
				<?php if(!empty($product['price']) || !empty($product['rub'])){ ?>
				<div class="novostroyki-cena">
				<?php if($product['view_price_from'] == 0){ ?>
				        <?php if (!$product['special']) { ?>
                            Цена <?php echo $product['rub'] . '&nbsp;&nbsp;руб.' . '&nbsp;/&nbsp;' . $product['price'] . '&nbsp;&nbsp;$'; ?>
                        <?php } else { ?>
                        <?php if ($product['currency_id'] == 1){ ?>
                            Цена <span class="price-old"><?php echo $product['rub']; ?>  руб.</span> / <span class="price-new"><?php echo $product['special_rub']; ?>  руб.</span>
                        <?php }else{ ?>
                            Цена <span class="price-old"><?php echo $product['price']; ?>  $</span> / <span class="price-new"><?php echo $product['special']; ?>  $</span>
                        <?php } ?>
                        <?php } ?>
				<?php }else if($product['view_price_from'] == 1){ ?>
					    <?php if (!$product['special']) { ?>
                            Цена в месяц от <?php echo $product['rub'] . '&nbsp;&nbsp;руб.' . '&nbsp;/&nbsp;' . $product['price'] . '&nbsp;&nbsp;$'; ?>
                        <?php } else { ?>
                        <?php if ($product['currency_id'] == 1){ ?>
                            Цена в месяц от <span class="price-old"><?php echo $product['rub']; ?>  руб.</span> / <span class="price-new"><?php echo $product['special_rub']; ?>  руб.</span>
                        <?php }else{ ?>
                            Цена в месяц от <span class="price-old"><?php echo $product['price']; ?>  $</span> / <span class="price-new"><?php echo $product['special']; ?>  $</span>
                        <?php } ?>
                        <?php } ?>
				<?php }elseif($product['view_price_from'] == 2){ ?>
						<?php if (!$product['special']) { ?>
                            Цена в сутки от <?php echo $product['rub'] . '&nbsp;&nbsp;руб.' . '&nbsp;/&nbsp;' . $product['price'] . '&nbsp;&nbsp;$'; ?>
                        <?php } else { ?>
                        <?php if ($product['currency_id'] == 1){ ?>
                            Цена в сутки от <span class="price-old"><?php echo $product['rub']; ?>  руб.</span> / <span class="price-new"><?php echo $product['special_rub']; ?>  руб.</span>
                        <?php }else{ ?>
                            Цена в сутки от <span class="price-old"><?php echo $product['price']; ?>  $</span> / <span class="price-new"><?php echo $product['special']; ?>  $</span>
                        <?php } ?>
                        <?php } ?>
				<?php } ?>
				</div>
				<?php } ?>
			<?php }else{ ?>
			    <div class="badge-sold"><img src="/catalog/view/theme/default/images/pr-min.png" alt=""/></div>
			<?php } ?>
			
			<?php if($product['badge'] && trim($product['badge'])=='new'){ ?>
			    <div class="badge-new"><img src="/catalog/view/theme/default/images/new-min.png" alt=""/></div>
			<?php } ?>
			</div>
			
            <a href="<?php echo $product['href']; ?>"><h3><?php echo $product['name']; ?></h3></a>
            <p>
                <?php echo $product['description'] ?>
            </p>
            <!--<a href="<?php echo $product['href']; ?>">Читать описание полностью</a>-->

            <!--<div class="novostroyki-media">
                <?php if ($product['video']): ?>
                <a href="<?php echo $product['video_href']; ?>"><img src="/catalog/view/theme/default/img/Video_play.png" alt=""/></a>
                <?php endif; ?>
                <?php if ($product['thumb']): ?>
                <a href="<?php echo $product['gallery_href']; ?>"><img src="/catalog/view/theme/default/img/images_play.png" alt=""/></a>
               <?php endif; ?>
            </div>-->

        </li>

<?php } ?>