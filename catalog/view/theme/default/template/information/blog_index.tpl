<?php echo $header; ?>
    <?php echo $content_top; ?>
<div class="content">
    <div class="conteiner">
        <div class="breadcrumb">
            <?php foreach ($breadcrumbs as $breadcrumb) { ?>
                <?php if ($breadcrumb['current']): ?>
                    <?php echo $breadcrumb['separator']; ?><span rel="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></span>
                <?php else: ?>
                    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
                <?php endif; ?>
            <?php } ?>
        </div>
        <?php //echo $blog_head; ?>
        <div id="blog-list">

            <div class="block-3" id="grid-line-modifier" style="padding-top:0px">
                <ul>
                    <?php foreach ($articles as $item) { ?>
                        <li>
                            <?php if (!isset($item['href'])) $item['href'] = $this->url->link('information/information&information_id='.$item['information_id']); ?>
                            <div class="novostroyki-img">
                                <?php if (!empty($item['image']) && $item['image']!='no_image.jpg'){ ?>
                                    <img src="<?php echo HTTP_IMAGE.$item['image'] ?>" alt=""/>
                                <?php } else { ?>
                                    <img src="/catalog/view/theme/default/img/nophoto.png" alt="Нет изображения"/>
                                <?php } ?>
                                <div class="novostroyki-cena">
                                    <?php if ($item['date_added']!='0000-00-00 00:00:00') echo date('d.m.Y',strtotime($item['date_added'])) ?>
                                </div>
                            </div>
                            <h3><?php echo $item['title'] ?></h3>
                            <p>
                                <?php $description = strip_tags(htmlspecialchars_decode($item['description'])); if (mb_strlen($description, "UTF-8")>200) $description = mb_substr($description, 0, 200, "UTF-8").'...'; echo $description ?>
                            </p>
                            <a href="<?php echo $item['href'] ?>">Читать описание полностью</a>
                        </li>

                    <?php } ?>
                </ul>
            </div>


</div>
</div>
        <?php echo $content_bottom; ?>

<?php echo $footer; ?>