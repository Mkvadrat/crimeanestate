<?php echo $header; ?>
<?php echo $content_top; ?>
    <div class="content">
        <div class="conteiner article-container">
            <div class="breadcrumb">
                <?php foreach ($breadcrumbs as $breadcrumb) { ?>
                    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
                <?php } ?>
            </div>
            <h1><?php echo $heading_title; ?></h1>

            <div class="cont-block-rows">
                <div id="gallery">
                    <div class="controls" id="controls">
                        &nbsp;</div>
                    <div class="slideshow-container">
                        <div class="loader" id="loading">
                            &nbsp;</div>
                        <div class="slideshow" id="gal-show">
                            &nbsp;</div>
                    </div>
                </div>
                <div class="navigation" id="thumbs">

                    <?php if ($gallimages) : ?>
                    <ul class="thumbs noscript">
                        <?php foreach ($gallimages as $image) { ?>
                        <li>
                            <a class="thumb" name="drop" href="<?php echo $image['image'] ?>" title="<?php echo $image['title'] ?>">
                                <img src="<?php echo $image['image'] ?>" alt="<?php echo $image['title'] ?>" />
                            </a>
                        </li>
                        <?php } ?>
                    </ul>
                    <?php endif ?>
                </div>
            </div>

            <div class="border"><?php //echo $description ?></div>
        </div>
    </div>
<?php echo $content_bottom; ?>
<?php echo $footer; ?>

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