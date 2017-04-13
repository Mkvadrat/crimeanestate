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

                <?php if ($images) { ?>

                <div id="gallery">
                    <div id="controls" class="controls"></div>
                    <div class="slideshow-container">
                        <div id="loading" class="loader"></div>
                        <div id="gal-show" class="slideshow"></div>
                    </div>

                </div>


                <div id="thumbs" class="navigation">
                    <ul class="thumbs noscript">
                        <?php if ($thumb_orig) { ?>
                            <li>
                                <a class="thumb" name="drop" href="<?php echo $thumb_orig ?>" title="<?php echo $heading_title ?>">
                                    <img src="<?php echo $thumb_orig ?>" alt="<?php echo $heading_title ?>" />
                                </a>
                            </li>
                        <?php } ?>
                        <?php foreach ($images as $image) { ?>
                        <li>
                            <a class="thumb" name="drop" href="<?php echo $image['orig'] ?>" title="<?php echo $heading_title ?>">
                                <img src="<?php echo $image['orig'] ?>" alt="<?php echo $heading_title ?>" />
                            </a>
                        </li>
                        <?php } ?>

                    </ul>
                </div>

                <?php } ?>
            </div>
        </div>

    </div>
</div>

<?php echo $content_bottom; ?>

<script type="text/javascript">
    jQuery(document).ready(function($) {
        // We only want these styles applied when javascript is enabled
        jQuery('div.navigation').css({'width' : '960px', 'float' : 'left'});

        // Initially set opacity on thumbs and add
        // additional styling for hover effect on thumbs
        var onMouseOutOpacity = 0.67;
        jQuery('#thumbs ul.thumbs li').opacityrollover({
            mouseOutOpacity:   onMouseOutOpacity,
            mouseOverOpacity:  1.0,
            fadeSpeed:         'fast',
            exemptionSelector: '.selected'
        });

        // Initialize Advanced Galleriffic Gallery
        var gallery = jQuery('#thumbs').galleriffic({
            delay:                     2500,
            numThumbs:                 6,
            preloadAhead:              10,
            enableTopPager:            true,
            enableBottomPager:         true,
            enableTopPager:            false,
            maxPagesToShow:            3,
            imageContainerSel:         '#gal-show',
            controlsContainerSel:      '#controls',
            captionContainerSel:       '#caption',
            loadingContainerSel:       '#loading',
            renderSSControls:         false,
            renderNavControls:         true,
            playLinkText:              'Play Slideshow',
            pauseLinkText:             'Pause Slideshow',
            prevLinkText:              '&lsaquo;',
            nextLinkText:              '&rsaquo;',
            nextPageLinkText:          '&rsaquo;',
            prevPageLinkText:          '&lsaquo;',
            enableHistory:             false,
            autoStart:                 false,
            syncTransitions:           true,
            defaultTransitionDuration: 900,
            onSlideChange:             function(prevIndex, nextIndex) {
                // 'this' refers to the gallery, which is an extension of $('#thumbs')
                this.find('ul.thumbs').children()
                    .eq(prevIndex).fadeTo('fast', onMouseOutOpacity).end()
                    .eq(nextIndex).fadeTo('fast', 1.0);
            },
            onPageTransitionOut:       function(callback) {
                this.fadeTo('fast', 0.0, callback);
            },
            onPageTransitionIn:        function() {
                this.fadeTo('fast', 1.0);
            }
        });
    });

</script>

<?php echo $footer; ?>