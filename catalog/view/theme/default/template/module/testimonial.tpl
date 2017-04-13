<div class="row bg-slider-1">
    <div class="conteiner">
        <h2>НАШИ КЛИЕНТЫ</h2>
        <div class="slider1">
            <?php foreach ($testimonials as $testimonial) { ?>
            <div class="slide">
                <div class="kav"><img src="/catalog/view/theme/default/img/kav-s.png" alt=""/></div>
                <p>
                    <?php echo $testimonial['description'] ; ?>
                </p>
                <p class="sd-pod"><?php echo $testimonial['name'] ?></p>
                <p class="sd-pod2"><?php echo $testimonial['city']; ?></p>
            </div>
            <?php } ?>
        </div>
    </div>
</div>