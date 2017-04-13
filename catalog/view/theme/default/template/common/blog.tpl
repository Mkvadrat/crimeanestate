<?php if (!empty($articles)) : ?>
<div class="row block-five">
    <div class="conteiner">
        <div class="block-5">
            <h2>БЛОГ</h2>
            <ul>
                <?php foreach ($articles as $item) { ?>
                <?php if (!isset($item['href'])) $item['href'] = $this->url->link('information/information&information_id='.$item['information_id']); ?>
                <li>
                    <?php if (!empty($item['image']) && $item['image']!='no_image.jpg'){ ?>
                        <img src="<?php echo HTTP_IMAGE.$item['image'] ?>" />
                    <?php } else { ?>
                        <img src="/catalog/view/theme/default/img/nophoto.png" alt="Нет изображения"/>
                    <?php } ?>
                    <div class="gg-foot">
                        <div class="gg-name"><a href="<?php echo $item['href'] ?>" class="sing-in"><?php if ($item['date_added']!='0000-00-00 00:00:00') echo date('d.m.Y',strtotime($item['date_added'])) ?></a></div>
                        <p class="gg-text-1"><?php echo $item['title'] ?></p>
                        <p class="gg-text-2"><?php $description = trim(strip_tags(htmlspecialchars_decode($item['description']))); if (mb_strlen($description, "UTF-8")>150) $description = mb_substr($description, 0, 150, "UTF-8").'...'; echo $description ?></p>
                        <a class="gg-text-3" href="<?php echo $item['href'] ?>">ПОКАЗАТЬ ПОЛНОСТЬЮ</a>
                        <!--<a class="gg-text-4" href="<?php echo $item['href'] ?>"></a>-->
                    </div>
                </li>
                <?php } ?>
            </ul>
        </div>
    </div>
</div>
<?php endif; ?>