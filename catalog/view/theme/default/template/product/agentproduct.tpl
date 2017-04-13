<?php echo $header; ?>

<div class="content">
<div class="conteiner">
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
    
	<?php foreach($agent_inf as $information){ ?>
	<div class="block_agent_inf">
	    <?php if(!empty($information['image'])){ ?><div class="image_agent"><img src="<?php echo $information['image']; ?>"/></div><?php } ?>
		   <?php if(!empty($information['name'])){ ?><div class="name_agent"><?php echo $information['name']; ?></div><?php } ?>
			    <?php if(!empty($information['email'])){ ?><div class="email_agent">Email: <?php echo $information['email']; ?></div><?php } ?>
				    <?php if(!empty($information['phone_1'])){ ?><div class="phone_1_agent">Номер телефона: <?php echo $information['phone_1']; ?></div><?php } ?> 
					    <?php if(!empty($information['phone_2'])){ ?><div class="phone_2_agent">Номер телефона: <?php echo $information['phone_2']; ?></div><?php } ?> 
						    <?php if(!empty($information['skype'])){ ?><div class="skype_agent">Skype: <?php echo $information['skype']; ?></div><?php } ?> 
	
	<?php if(!empty($information['name'])){ ?>
    <div class="agent_send">
            <a href="#otpr-s" class="sing-in">ОТПРАВИТЬ СООБЩЕНИЕ</a>
            <input type="hidden" name="agent-user-id" value="<?php echo $information['user_id'] ?>" readonly="readonly" />
	</div>
	</div>
	<?php } ?> 
	<?php } ?>


    <?php if ($products) { ?>
    <div class="title_object">Объекты агента</div>
    <div class="block-agent-object">
    <ul class="products-ul">
        <?php foreach ($products as $product) { ?>
            <li>
            <div class="novostroyki-img">
            <?php if ($product['thumb']) { ?>
                <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>"/></a>
            <?php } else { ?>
                <a href="<?php echo $product['href']; ?>"><img src="/catalog/view/theme/default/img/nophoto.png" alt="Нет изображения"/></a>
            <?php } ?>
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
				<?php }elseif($product['view_price_from'] == 1){ ?>
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
            </div>
            <a href="<?php echo $product['href']; ?>"><h3><?php echo $product['name']; ?></h3></a>
            <p>
                <?php echo $product['description'] ?>
            </p>
            </li>

        <?php } ?>
    </ul>
    </div>

    <div class="pagination"><?php echo $pagination; ?></div>
    <?php } ?>

</div>
</div>

<?php echo $footer; ?>