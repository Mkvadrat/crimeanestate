<div class="container-fluid">
 <div class="row">

  <a href="#" class="box-heading feature-block"><?php echo $heading_title; ?><span class="caret"></span></a>
     <div class="bl-content">
   <?php foreach ($products as $product) { ?>
	<div class="cont" style="width: 300px; height:140px; margin-bottom:10px; overflow: hidden;">
        <?php if ($product['thumb']) { ?>

        <div class="image" >
<a href="<?php echo $product['href']; ?>">
<span class="name"><?php echo $product['name']; ?></span>
<img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" />

</a></div>
        <?php } ?>
    </div>

  <?php } ?>
  </div>
 </div>
</div>
<script>
    jQuery('.feature-block').click(function(){
        $(this).parent().parent().offset(function(i,val){
            jQuery('html, body').animate({scrollTop:val.top-10}, 'fast');
        });
    });

</script>