<?php if (!empty($testimonials)): ?>
<div class="wrap-reviews">
    <span class="rev">ПОСЛЕДНИЕ ОТЗЫВЫ</span>
    <?php foreach ($testimonials as $testimonial) { ?>
    <a href="/index.php?route=product/testimonial" class="reviews">

        <p>
            <?php $testimonial['description'] = strip_tags($testimonial['description']); ?>
            <!--<img src="/catalog/view/theme/default/img/rev-foto.jpg" width="97" height="87" style="float:left;" alt="">-->
            <?php echo $testimonial['description'] ?>
        </p>
        <p class="sd-pod"><?php echo $testimonial['name'] ?></p>
        <p class="sd-pod2"><?php echo $testimonial['city'] ?></p>
    </a>
    <?php } ?>
    <a href="/index.php?route=product/testimonial" class="read-rev">Читать все отзывы</a>
</div>
<?php endif ?>
<?php if (!empty($articles)): ?>
    <div class="live-jurnal" style="margin-bottom: 40px">
    <span class="jurnal">Блог</span>
    <?php foreach ($articles as $item) { ?>
         <?php if (!isset($item['href'])) $item['href'] = $this->url->link('information/information&information_id='.$item['information_id']); ?>
        <?php if (!empty($item['image']) && $item['image']!='no_image.jpg'){ ?>
            <img src="<?php echo HTTP_IMAGE.$item['image'] ?>" alt="" height="200"/>
        <?php } else { ?>
            <img src="/catalog/view/theme/default/img/nophoto.png" alt="Нет изображения" height="200"/>
        <?php } ?>
        <div class="gg-foot">
            <div class="gg-name"><a href="<?php echo $item['href'] ?>"><?php if ($item['date_added']!='0000-00-00 00:00:00') echo date('d.m.Y',strtotime($item['date_added'])) ?></a></div>
            <p class="gg-text-1"><?php echo $item['title'] ?></p>
            <?php $description = strip_tags($description); ?>
            <p class="gg-text-2"><?php $description = strip_tags(htmlspecialchars_decode($item['description'])); if (mb_strlen($description, "UTF-8")>200) $description = mb_substr($description, 0, 200, "UTF-8").'...'; echo $description ?></p>
            <a class="gg-text-3" href="<?php echo $item['href'] ?>">ПОКАЗАТЬ ПОЛНОСТЬЮ</a>
        </div>
    <?php } ?>
    </div>
<?php endif ?>
<div class="banners-right">
    <a href="/index.php?route=product/category&path=105" class="ban1">
        <span>СПЕЦИАЛЬНЫE<br />ПРЕДЛОЖЕНИЯ<br />ДЛЯ ВАС</span>
        <img src="/catalog/view/theme/default/img/banner-r1.png" width="264" height="370" alt="">
    </a>

    <a href="/index.php?route=product/category&path=106" class="ban2">
        <img src="/catalog/view/theme/default/img/banner-r2.png" width="264" height="370" alt="">
        <span>ЭКСКЛЮЗИВЫ</span>
    </a>
</div>
<div class="youtube">
<a href="https://www.youtube.com/channel/UCpbsVZiZHxrkCbZ6oWGdL8A">
    <span class="yt"><span class="colort">КАНАЛ</span><br />КРЫМСКАЯ НЕДВИЖИМОСТЬ</span></a>
    <iframe width="260" height="160" src="https://www.youtube.com/embed/Pcc4kytz8LE" frameborder="0" allowfullscreen></iframe>
    <a href="https://www.youtube.com/channel/UCpbsVZiZHxrkCbZ6oWGdL8A" class="yt-but"></a>
</div>
<?php if ($gallimages) : ?>
<div class="fgallery">
    <span class="gal">ФОТОГАЛЕРЕЯ КРЫМА</span>

    <div class="list-foto">
    <?php foreach ($gallimages as $image) { ?>
        <a class="thumb" name="drop" href="/crimea-gallery" title="<?php echo $image['title'] ?>">
            <img src="<?php echo $image['image'] ?>" alt="<?php echo $image['title'] ?>" width="125" height="100" />
        </a>
    <?php } ?>
    </div>
</div>
<?php endif ?>

<?php if (!empty($topics)) : ?>
<div class="block-faq">
    <span class="t-faq">Вопросы и ответы</span>
    <?php $co = 0; ?>
    <?php foreach($topics as $topic): ?>
    <div class="faq">
        <?php if (!empty($topic['title'])) : ?>
            <?php $topic['title'] = strip_tags($topic['title']); ?>
            <a href="<?php echo $topic['href'] ?>" class="quest"><?php echo (mb_strlen($topic['title'],"UTF-8")>200 ? mb_substr($topic['title'],0,200,"UTF-8").'...' : $topic['title']) ?></a>
            <p>
                <?php $topic['description'] = strip_tags($topic['description']); ?>
                <?php echo (mb_strlen($topic['description'],"UTF-8")>200 ? mb_substr($topic['description'],0,200,"UTF-8").'...' : $topic['description']) ?>
            </p>
        <?php else: ?>
            <a href="/index.php?route=information/faq">
                <?php $topic['description'] = strip_tags($topic['description']); ?>
                <?php echo (mb_strlen($topic['description'],"UTF-8")>200 ? mb_substr($topic['description'],0,200,"UTF-8").'...' : $topic['description']) ?>
            </a>
        <?php endif; ?>

    </div>
        <?php $co++ ?>
        <?php if ($co>=4) break; ?>
    <?php endforeach ?>

    <a href="/index.php?route=information/faq" class="read-faq">Все вопросы</a>
</div>
<?php endif ?>



