<div class="row bg-slider-2">
    <div class="conteiner_parnters">
        <h2>НАШИ ПАРТНЕРЫ</h2>
        <div class="slider2">
            <?php foreach ($banners as $banner) { ?>
            <div class="slide">
                <p>
                   <a href="<?php echo $banner['link']; ?>"><img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" title="<?php echo $banner['title']; ?>" /></a>
                </p>
				<p class="title_partners"><?php echo $banner['title']; ?></p>
            </div>
            <?php } ?>
        </div>
    </div>
</div>