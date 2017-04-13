<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
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

<div class="content-contact">
<h1>Контакты - Компании «Крымская Недвижимость» - г. Ялта</h1>

<?php foreach($setting as $settings){ ?>
    <div class="content-text-contact"> <?php echo $settings["text"]; ?></div>
</div><!-- End content-contact -->

<div class="maps maps-contact">
		<h3>Мы на карте:</h3>
		<div id="map" style="width:978px; height:326px"></div>
		    <script src="http://api-maps.yandex.ru/2.0/?load=package.standard&lang=ru-RU" type="text/javascript"></script>
                <?php if($settings["adress"]){ ?>
                    <script type="text/javascript">
                        var myMap;
                        ymaps.ready(init);
                        function init()
                        {
                            ymaps.geocode('<?php echo $settings["adress"]; ?>', {
                                results: 1
                            }).then
                            (
                                function (res)
                                {
                                    var firstGeoObject = res.geoObjects.get(0),
                                        myMap = new ymaps.Map
                                        ("map",
                                            {
                                                center: firstGeoObject.geometry.getCoordinates(),
                                                zoom: 15
                                            }
                                        );
                                    var myPlacemark = new ymaps.Placemark
                                    (
                                        firstGeoObject.geometry.getCoordinates(),
                                        {
                                            iconContent: ''
                                        },
                                        {
                                            preset: 'twirl#blueStretchyIcon'
                                        }
                                    );
                                    myMap.geoObjects.add(myPlacemark);
                                    myMap.controls.add(new ymaps.control.ZoomControl()).add(new ymaps.control.ScaleLine()).add('typeSelector');
                                },
                                function (err)
                                {
                                    alert(err.message);
                                }
                            );
                        }
                    </script>
                <?php } ?>
</div>
<?php } ?>
  <!--<div>
  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">

    <h1><?php echo $text_contact; ?></h1>
    <div>
    <div style="float:left;margin-right:20px">
        <b><?php echo $entry_name; ?></b><br />
        <input type="text" name="name" value="<?php echo $name; ?>" />
        <br />
        <?php if ($error_name) { ?>
        <span class="error"><?php echo $error_name; ?></span>
        <?php } ?>
        <br />
    </div>
    <div>
        <b><?php echo $entry_email; ?></b><br />
        <input type="text" name="email" value="<?php echo $email; ?>" />
        <br />
        <?php if ($error_email) { ?>
        <span class="error"><?php echo $error_email; ?></span>
        <?php } ?>
        <br />
     </div>
    <div>
        <b><?php echo $entry_enquiry; ?></b><br />
        <textarea name="enquiry" cols="40" rows="10" style="width: 99%;"><?php echo $enquiry; ?></textarea>
        <br />
        <?php if ($error_enquiry) { ?>
        <span class="error"><?php echo $error_enquiry; ?></span>
        <?php } ?>
        <br />
        <b><?php echo $entry_captcha; ?></b><br />
        <input type="text" name="captcha" value="<?php echo $captcha; ?>" />
        <br />
        <img src="index.php?route=information/contact/captcha" alt="" />
        <?php if ($error_captcha) { ?>
        <span class="error"><?php echo $error_captcha; ?></span>
        <?php } ?>
        </div>
        <div class="buttons">
          <div class="right"><input type="submit" value="<?php echo $button_continue; ?>" class="button" /></div>
        </div>
     </div>
  </form>
  </div>-->
</div>
</div>
<?php echo $content_bottom; ?>
<?php echo $footer; ?>