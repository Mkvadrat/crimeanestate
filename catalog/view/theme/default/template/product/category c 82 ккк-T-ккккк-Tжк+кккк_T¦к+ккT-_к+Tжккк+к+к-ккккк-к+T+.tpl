<?php echo $header; ?>

  <?php if ($categories) { ?>

    <?php if ($heading_title == '_Аренда')  { ?>

        <div class="row">
            <div class="conteiner arenda-top">
                <ul>
                <?php foreach ($categories as $category) { ?>
                    <li>
                    <?php if ($category['thumb'] && $category['name'] != 'Специальное предложение') { ?>
                        <p><span><?php echo $category['name'] ?></span></p>
                        <img src="<?php echo $category['thumb'] ?>" alt="<?php echo $category['name'] ?>"/>
                        <a href="<?php echo $category['href']; ?>">СМОТРЕТЬ</a>
                    <?php } else { ?>
                        <a href="<?php echo $category['href']; ?>" class="a-spec1">
                            <p class="arenda-spec-pred">
                                <?php if ($category['name'] == 'Специальное предложение') { ?>
                                <img class="anim-sp" src="/catalog/view/theme/default/img/icon-spec.png" alt=""/>
                                <?php } ?>
                                <?php echo $category['name'] ?>
                            </p>
                        </a>
                    <?php } ?>
                    </li>
                <?php } ?>
                </ul>
            </div>
        </div>

    <?php } else if ($heading_title == 'Найм') { ?>

        <div class="row">
            <div class="conteiner top-rent">
                <div class="top-rent-left">
                    <ul>
                    <?php $special_cat = null; ?>
                    <?php foreach ($categories as $category) { ?>
                        <?php if ($category['name'] == 'Специальное предложение') {
                            $special_cat = $category;
                            continue;
                        }
                        ?>
                        <li>
                        <?php if ($category['thumb']) { ?>
                            <img src="<?php echo $category['thumb']; ?>" alt="<?php echo $category['name']; ?>"/>
                            <div class="top-rent-left-fon"></div>
                            <div class="top-rent-left-text"><div><?php echo $category['name']; ?></div></div>
                            <a class="top-rent-but" href="<?php echo $category['href']; ?>">СМОТРЕТЬ</a>
                        <?php } else { ?>
                            <a class="sale-sp" href="<?php echo $category['href']; ?>">
                                <div>
                                    <?php echo $category['name']; ?>
                                </div>
                            </a>
                        <?php } ?>
                        </li>
                    <?php } ?>
                    </ul>
                </div>
                <div class="top-rent-right">
                    <?php if ($special_cat) { ?>
                    <a href="<?php echo $special_cat['href']; ?>">
                        <img src="/catalog/view/theme/default/img/rent10.png" alt="<?php echo $special_cat['name']; ?>"/>
                        <div class="top-rent-right-fon"></div>
                        <div class="top-rent-right-text">
                            <div><img class="anim-sp" src="/catalog/view/theme/default/img/icon-spec.png" alt=""/><?php echo $special_cat['name']; ?></div>
                        </div>
                    </a>
                    <?php } ?>
                </div>
            </div>
        </div>

    <?php } else { ?>

        <div class="row">
        <div class="conteiner top-rent">
            <div class="top-sale-left">
            <ul>
            <?php foreach ($categories as $category) { ?>
                <li>
                <?php if ($category['thumb'] && $category['name'] != 'Специальное предложение') { ?>
                        <img src="<?php echo $category['thumb']; ?>" alt="<?php echo $category['name']; ?>"/>
                        <div class="top-sale-left-fon"></div>
                        <div class="top-sale-left-text"><div><?php echo $category['name']; ?></div></div>
                        <a class="top-sale-but" href="<?php echo $category['href']; ?>">СМОТРЕТЬ</a>
                <?php } else { ?>
                    <a class="sale-sp" href="<?php echo $category['href']; ?>">
                        <div>
                            <?php if ($category['name'] == 'Специальное предложение') { ?>
                            <img class="anim-sp" src="/catalog/view/theme/default/img/icon-spec.png" alt=""/><br />
                            <?php } ?>
                            <?php echo $category['name']; ?>
                        </div>
                    </a>
                <?php } ?>
                </li>
            <?php } ?>
            </ul>
            </div>
        </div>
        </div>

        <?php } ?>
  <?php } ?>

  <?php if ($thumb && (
        $heading_title == 'Специальное предложение' ||
        $heading_title == 'Лучшие предложения' ||
        $heading_title == 'Эксклюзивы'
    )) { ?>
    <?php
    $class='top-ban-text-3';
    if ($heading_title == 'Эксклюзивы') $class = 'top-ban-text-2';
    if ($heading_title == 'Лучшие предложения') $class = 'top-ban-text';
    ?>
    <div class="row">
        <div class="conteiner">
            <div class="top-ban">
                <img src="<?php echo $thumb; ?>" class="" />
                <p class="<?php echo $class ?>">
                    <?php if ( $heading_title == 'Специальное предложение') { ?>
                    <img src="/catalog/view/theme/default/img/icon-spec.png" class="" />
                    <?php } ?>
                    <?php echo $heading_title; ?>
                </p>
            </div>
        </div>
    </div>
<?php } ?>

        <?php //echo $subCatInfo ?>

<?php echo $content_top; ?>

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

    <?php if ($description) { ?>
    <div class="text-col-2">
        <?php echo $description; ?>
    </div>
    <?php } ?>



  <?php if ($products) { ?>

      <div class="row">
          <div class="arenda-nav" style="margin-top:0px">
              <div class="nav-arenda-grid-line">
                  <a class="nav-arenda-grid" href="#"></a>
                  <a class="nav-arenda-line" href="#"><img href="img/line1.png" alt=""/></a>
              </div>
              <?php if (!empty($pages_total)): ?>
              <p>ВСЕГО ПРЕДЛОЖЕНИЙ: <span><?php echo $pages_total ?></span></p>
              <?php endif; ?>
              <div class="nav-arenda-select">
                  <p>СОРТИРОВАТЬ ПО:</p>
                  <div class="s5">
                  <select id="select5" class="selector" onchange="change_list_sorting()">
                      <option value="rating">ПОПУЛЯРНОСТИ</option>
                      <option value="price-asc"><span>ЦЕНЕ</span> (от меньшей к большей)</option>
                      <option value="price-desc"><span>ЦЕНЕ</span> (от большей к меньшей)</option>
                  </select>
                  </div>
              </div>
              <div class="nav-arenda-select2">
                  <p>ПОКАЗАТЬ ПО:</p>
                  <div class="s6">
                  <select id="select6" class="selector" onchange="change_list_limit()">
                      <option value="10">10</option>
                      <option value="20">20</option>
                      <option value="50">50</option>
                  </select>
                  </div>
              </div>
              <div class="nav-arenda-page">
                  <div class="pagination"><?php echo $pagination; ?></div>
              </div>
          </div>
      </div>

  <div class="block-3" id="grid-line-modifier">
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
                        Цена <?php if($product['price_from']){echo $product['price_from'].'&nbsp;'.$product['rub'];}else{echo $product['rub'];} ?> руб. / <?php echo $product['price']; ?> $
                    <?php } else { ?>
                        <?php if ($product['currency_id'] == 1): ?>
                            Цена <span class="price-old"><?php echo $product['rub']; ?> руб.</span> / <span class="price-new"><?php echo $product['special_rub']; ?> руб.</span>
                        <?php else: ?>
                            Цена <span class="price-old"><?php echo $product['price']; ?> $</span> / <span class="price-new"><?php echo $product['special']; ?> $</span>
                        <?php endif; ?>
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

  <div class="pagination"><?php echo $pagination; ?></div>
  <?php } ?>


  <?php if (!$categories && !$products) { ?>
  <div class="content block-3"><?php echo $text_empty; ?></div>
  <?php } ?>

</div>
</div>

<?php echo $content_bottom; ?>

<?php echo $footer; ?>

<script type="text/javascript">
$("div.top-rent-right-text").empty();
$("a[href='http://crimean.estate/index.php?route=product/category&path=94_104']").attr('href', 'http://crimean.estate/exclusive');
    var docCookies = {
        getItem: function (sKey) {
            if (!sKey) { return null; }
            return decodeURIComponent(document.cookie.replace(new RegExp("(?:(?:^|.*;)\\s*" + encodeURIComponent(sKey).replace(/[\-\.\+\*]/g, "\\$&") + "\\s*\\=\\s*([^;]*).*$)|^.*$"), "$1")) || null;
        },
        setItem: function (sKey, sValue, vEnd, sPath, sDomain, bSecure) {
            if (!sKey || /^(?:expires|max\-age|path|domain|secure)$/i.test(sKey)) { return false; }
            var sExpires = "";
            if (vEnd) {
                switch (vEnd.constructor) {
                    case Number:
                        sExpires = vEnd === Infinity ? "; expires=Fri, 31 Dec 9999 23:59:59 GMT" : "; max-age=" + vEnd;
                        break;
                    case String:
                        sExpires = "; expires=" + vEnd;
                        break;
                    case Date:
                        sExpires = "; expires=" + vEnd.toUTCString();
                        break;
                }
            }
            document.cookie = encodeURIComponent(sKey) + "=" + encodeURIComponent(sValue) + sExpires + (sDomain ? "; domain=" + sDomain : "") + (sPath ? "; path=" + sPath : "") + (bSecure ? "; secure" : "");
            return true;
        },
        removeItem: function (sKey, sPath, sDomain) {
            if (!this.hasItem(sKey)) { return false; }
            document.cookie = encodeURIComponent(sKey) + "=; expires=Thu, 01 Jan 1970 00:00:00 GMT" + (sDomain ? "; domain=" + sDomain : "") + (sPath ? "; path=" + sPath : "");
            return true;
        },
        hasItem: function (sKey) {
            if (!sKey) { return false; }
            return (new RegExp("(?:^|;\\s*)" + encodeURIComponent(sKey).replace(/[\-\.\+\*]/g, "\\$&") + "\\s*\\=")).test(document.cookie);
        },
        keys: function () {
            var aKeys = document.cookie.replace(/((?:^|\s*;)[^\=]+)(?=;|$)|^\s*|\s*(?:\=[^;]*)?(?:\1|$)/g, "").split(/\s*(?:\=[^;]*)?;\s*/);
            for (var nLen = aKeys.length, nIdx = 0; nIdx < nLen; nIdx++) { aKeys[nIdx] = decodeURIComponent(aKeys[nIdx]); }
            return aKeys;
        }
    };

    $(document).ready(function(){
        $('.nav-arenda-grid-line a.nav-arenda-grid').click(function(e){
           e.stopPropagation();
           e.preventDefault();

           $('#grid-line-modifier').removeClass('wiev-line');
            $('.nav-arenda-grid-line a').removeClass('active');
            $(this).addClass('active');

            docCookies.setItem('gridlinevalue','grid', Infinity, '/', '.'+window.location.host);
        });
        $('.nav-arenda-grid-line a.nav-arenda-line').click(function(e){
            e.stopPropagation();
            e.preventDefault();

            $('#grid-line-modifier').addClass('wiev-line');
            $('.nav-arenda-grid-line a').removeClass('active');
            $(this).addClass('active');

            docCookies.setItem('gridlinevalue','line', Infinity, '/', '.'+window.location.host);
        });

        var gridlinevalue = docCookies.getItem('gridlinevalue');
        if (!gridlinevalue || gridlinevalue=='grid') {
            $('.nav-arenda-grid-line a.nav-arenda-grid').addClass('active');
        } else if (gridlinevalue && gridlinevalue=='line') {
            $('.nav-arenda-grid-line a.nav-arenda-line').trigger('click');
        }
    });

    function change_list_sorting() {
        var sorting = $('#select5').val();

        if (sorting == 'price-asc') {
            setSort('sort=p.price&order=ASC');
        } else if (sorting == 'price-desc') {
            setSort('sort=p.price&order=DESC');
        } else {
            setSort('sort=p.sort_order&order=ASC');
        }
    }

    function change_list_limit() {
        var limit = $('#select6').val();
        setLimit(limit);
    }
</script>