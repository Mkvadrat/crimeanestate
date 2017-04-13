<footer>
    <div class="footer-wrap-1">
        <div class="row">
            <div class="conteiner">
                <div class="footter-block-1">
                    <ul>
                        <li>8 (800) 234-7899</li>
                        <li>company@crimean.estate</li>
                        <li>realcrimean.estate</li>
                        <li>+7 978 807 00 57</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="footer-wrap-2">
        <div class="row">
            <div class="conteiner">
                <div class="wrap-f-2">
                    <div class="footer-block-2-1">
                        <div class="footer-block-2-1-1">
                            <a href="#"><img src="image/data/LOGO/logo_footer.png" alt=""/></a>
                        </div>
                        <div class="footer-block-2-1-2">
                            КОРПОРАТИВНАЯ СОЦИАЛЬНАЯ ОТВЕТСТВЕННОСТЬ
                            <ul>
                                <li><a href="https://www.instagram.com/CrimeanyEstaten" target="_blank"><img src="/catalog/view/theme/default/img/instagram.png" alt=""/></a></li>
                                <li><a href="https://rutube.ru/video/person/1239203/" target="_blank"><img src="/catalog/view/theme/default/img/rutube.png" alt=""/></a></li>
                                <li><a href="https://vk.com/crimeanestate" target="_blank"><img src="/catalog/view/theme/default/img/vk.png" alt=""/></a></li>
                                <li><a href="https://www.youtube.com/channel/UCpbsVZiZHxrkCbZ6oWGdL8A" target="_blank"><img src="/catalog/view/theme/default/img/youtube.png" alt=""/></a></li>
                                <li><a href="https://plus.google.com/111437357471813844386" target="_blank"><img src="/catalog/view/theme/default/img/google.png" alt=""/></a></li>
                                <li><a href="https://www.facebook.com/krimskaya.nedvigimost" target="_blank"><img src="/catalog/view/theme/default/img/facebook.png" alt=""/></a></li>
								<li><a href="https://www.linkedin.com/pub/%D0%BA%D1%80%D1%8B%D0%BC%D1%81%D0%BA%D0%B0%D1%8F-%D0%BD%D0%B5%D0%B4%D0%B2%D0%B8%D0%B6%D0%B8%D0%BC%D0%BE%D1%81%D1%82%D1%8C/bb/658/b88" target="_blank"><img src="/catalog/view/theme/default/img/linkedin.png" alt=""/></a></li>
                            </ul>
                        </div>
                        <div class="footer-block-2-1-3">
                            <a href="#" id="up">ВВЕРХ</a>
                        </div>
                    </div>
                    <div class="footer-block-2-2">
                        <ul>
                            <li><a href="/all-news">НОВОСТИ</a></li>
                            <!--<li><a href="#">СТАТЬИ</a></li>-->
                            <li><a href="/documents">ДОКУМЕНТЫ</a></li>
                            <li><a href="/index.php?route=information/faq">ВОПРОСЫ И ОТВЕТЫ</a></li>
                            <li><a href="/index.php?route=product/testimonial">ОТЗЫВЫ</a></li>
                            <li><a href="/services">УСЛУГИ</a></li>
                            <li><a href="/about_us">КОМПАНИЯ</a></li>
                            <li><a href="/index.php?route=module/favorites/favorites">ИЗБРАННОЕ</a></li>
							<li><a href="/contact">КОНТАКТЫ</a></li>
                        </ul>
                    </div>
                    <div class="footer-block-2-3">
                        <ul>
                            <li><a href="/sitemap">КАРТА САЙТА</a></li>
                            <?php if (!$logged): ?>
                            <li><a href="#regis" class="sing-in">РЕГИСТРАЦИЯ</a></li>
                            <!--<li><a href="/index.php?route=account/register">РЕГИСТРАЦИЯ</a></li>-->
                            <li><a href="#vhod" class="sing-in">АВТОРИЗАЦИЯ</a></li>
                            <!--<li><a href="/index.php?route=account/login">АВТОРИЗАЦИЯ</a></li>-->
                            <?php else : ?>
                                <li><a href="/account/">ЛИЧНЫЙ КАБИНЕТ</a></li>
                                <li><a href="/logout/">ВЫЙТИ</a></li>
                            <?php endif; ?>
                            <!--<li><a href="#card-rt" class="sing-in">ЖИВОЙ ЖУРНАЛ</a></li>-->
                            <li><a href="/index.php?route=information/information/blog">БЛОГ</a></li>
                            <!--<li><a href="#vhod-2" class="sing-in">ВИДЕОКАНАЛ</a></li>-->
                            <li><a href="https://www.youtube.com/channel/UCpbsVZiZHxrkCbZ6oWGdL8A" target="_blank">ВИДЕОКАНАЛ</a></li>
                            <li><a href="/crimea-gallery">ФОТОГАЛЕРЕЯ КРЫМА</a></li>
                        </ul>
                    </div>
                </div>
				<div class="copyright"><a href="http://mkvadrat.com/creat-site-estate">Создание и продвижение сайта агентства недвижимости</a> <div class="copyright-image"><img src="/catalog/view/theme/default/img/m2.png" alt=""/></div></div>
            </div>
			
			
        </div>
    </div>
    <div class="footer-wrap-3">
        <div class="row">
            <div class="conteiner">ВСЕ ПРАВА ЗАРЕЗЕРВИРОВАНЫ. ©КРЫМСКАЯНЕДВИЖИМОСТЬ 2015</div>
        </div>
    </div>

</footer><!-- footer -->
<div id="send_form" style="display:none;">
    <form class="in-send" rel="agent-message-form" action="index.php?route=common/footer/page">
        <p class="in-zag">Обратная связь</p>
        <div class="form-message"></div>
        <div class="wrap-cont-in">
            <div class="wrap-cont-send-form">
                <label>Имя<span>*</span></label>
                <input type="text" name="firstname">
                <label>Телефон<span>*</span></label>
                <input type="text" name="phone">
				<label>Email<span>*</span></label>
                <input type="text" name="email">
            </div>
            <label>Сообщение<span>*</span></label>
            <textarea name="text"></textarea>
            <div class="cont-in-b">
                <p>*поля обязательно к заполнению</p>
                <input class="but-in" type="submit" value="ОТПРАВИТЬ СООБЩЕНИЕ">
            </div>
        </div>
    </form>
</div>

<div id="otpr-s" style="display:none;">
    <form class="in-r" rel="agent-message-form" action="index.php?route=information/contact/agent">
        <p class="in-zag">ОТПРАВИТЬ СООБЩЕНИЕ РИЕЛТОРУ</p>
        <div class="form-message"></div>
        <div class="wrap-cont-in">
            <div class="wrap-cont-in-left">
                <label>Имя<span>*</span></label>
                <input type="text" name="firstname">
                <label>Телефон<span>*</span></label>
                <input type="text" name="phone">
            </div>
            <div class="wrap-cont-in-right">
                <label>Фамилия<span>*</span></label>
                <input type="text" name="secondname">
                <label>Email<span>*</span></label>
                <input type="text" name="email">
            </div>
            <label>Сообщение<span>*</span></label>
            <textarea name="text"></textarea>
            <div class="cont-in-b">
                <p>*поля обязательно к заполнению</p>
                <input class="but-in" type="submit" value="ОТПРАВИТЬ СООБЩЕНИЕ">
            </div>
        </div>
    </form>
</div>

<div id="vhod" style="display:none;">
    <form class="in" action="/login/" method="post">
        <p class="in-zag">ВОЙТИ</p>
        <div class="wrap-cont-in">
            <div class="wrap-cont-in-left">
                <label>Email<span>*</span></label>
                <input type="text" name="email">
            </div>
            <div class="wrap-cont-in-right">
                <label>Пароль<span>*</span></label>
                <input type="password" name="password">
            </div>
            <div class="cont-in-b">
                <p>*поля обязательно к заполнению</p>
                <input class="but-in" type="submit" value="ВХОД">
            </div>
        </div>
        <a href="javascript:void(0)" id="forget-pwd" class="in-z" onclick="jQuery('.boxer-content').html(jQuery('#vhod-2').html())" >Забыли пароль?</a>
    </form>
</div>

<div id="vhod-2" style="display:none;">
    <form class="in2" action="/forgot-password/" method="post">
        <p class="in-zag2">ВОЙТИ</p>
        <div class="wrap-cont-in">

            <div class="wrap-cont-in-right2">
                <p class="zp-text1">Забыли пароль?</p>
                <p class="zp-text2">Введите свою электронную почту,<br/>и мы вам вышлем новый пароль.</p>
                <input type="text" name="email">
            </div>
            <div class="cont-in-b mtop">

                <input class="but-in" type="submit" value="НАПОМНИТЬ">
            </div>
        </div>
    </form>
</div>
<div id="regis" style="display:none;">
    <form class="reg" action="/register-account/" method="post">
        <div class="wrap-reg">
            <label>Имя<span>*</span></label>
            <input type="text" name="firstname">
            <label>Фамилия<span>*</span></label>
            <input type="text" name="lastname">
            <label>Email<span>*</span></label>
            <input type="text" name="email">
            <label>Телефон<span>*</span></label>
            <input type="text" name="telephone">
            <label>Пароль<span>*</span></label>
            <input type="password" name="password">
            <label>Повторите пароль<span>*</span></label>
            <input type="password" name="confirm">
            <div class="cont-reg-b">
                <p>*поля обязательно к заполнению</p>
                <div class="wrap-reg-ch">
                    <!--
                    <div class="reg-ch-left">
                        <input type="checkbox" name="newsletter" value="1">я хочу получать рассылку!
                    </div>
                    -->
                    <div class="reg-ch-right">
                        <input type="checkbox" name="agree" value="1" checked="checked">Я согласен с условиями политики безопасности
                    </div>
                </div>
                <input class="but-reg" type="submit" value="РЕГИСТРАЦИЯ">
                <p>Заполняя форму на нашем сайте, вы соглашаетесь с нашей политикой конфиденциальности.</p>
            </div>
        </div>
        <input type="hidden" name="address_1" value="   " />
        <input type="hidden" name="city" value="   " />
        <input type="hidden" name="country_id" value="176" />
        <input type="hidden" name="zone_id" value="2761" />
        <input type="hidden" name="company_id" value=" " />
        <input type="hidden" name="tax_id" value=" " />
    </form>
</div>
<!--
<div id="card-rt" style="display:none;">
    <div class="card-rielt">
        <div class="card-rielt-1">
            <p class="card-text-1">Ольга Орлова</p>
            <p class="card-text-2">Специалист<br/>по продаже недвижимости</p>
            <img class="img-card" src="/catalog/view/theme/default/img/business-makeover-09.png" alt=""/>
            <p class="card-text-3"><img class="img-card2" src="/catalog/view/theme/default/img/viber.png" alt=""/>+38050 777 55 55</p>
            <p class="card-text-3"><img class="img-card2" src="/catalog/view/theme/default/img/Email-card.png" alt=""/>orlova@info.com</p>
            <p class="card-text-3"><img class="img-card2" src="/catalog/view/theme/default/img/ring14.png" alt=""/>+38050 777 55 55</p>
            <p class="card-text-3"><img class="img-card2" src="/catalog/view/theme/default/img/Skype-card.png" alt=""/>orlova.com</p>
        </div>
        <div class="card-rielt-2">
            <p class="card-text-4">
                Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariaturSed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim reprehenderit qui in ea voluptate velit esse quam nihil molestiae
            </p>
            <input class="but-in2" type="submit" value="ОТПРАВИТЬ СООБЩЕНИЕ">
        </div>
    </div>
</div>
-->
</div><!-- wrapper -->
        <div id="call-up">
            <a href="#send_form" class="sing-in">
                <i class="glyphicon glyphicon-envelope gl-call"></i><br /><span>Заявка</span></a></div>

<a href="javascript:void(0)" class="left-arrow-up"><span class="ico"></span>Вверх</a>
<a href="javascript:void(0)" class="back">Назад</a>
<script type="text/javascript">
    jQuery(document).ready(function(){
       jQuery('.left-arrow-up').click(function(e){
           e.stopPropagation();
           e.preventDefault();
           jQuery('html, body').animate({scrollTop:0},1000);
       })
    });
</script>

<script type="text/javascript">
jQuery(document).ready(function(){
	jQuery('.back').click(function(){
		parent.history.back();
		return false;
	});
});
</script>

<!--<?php if(preg_match( "#sale#", $_SERVER['REQUEST_URI']) || preg_match( "#hire#", $_SERVER['REQUEST_URI']) || preg_match( "#category#", $_SERVER['REQUEST_URI'])){ ?>
<script type="text/javascript">
    $(".sing-in").boxer({
        fixed: true,
        callback: function() {
        }
    });

</script>
<?php } else {?>
<script type="text/javascript">
    jQuery(".sing-in").boxer({
        fixed: true,
        callback: function() {
        }
    });

</script>
<?php } ?>-->

<script type="text/javascript">
    jQuery(".sing-in").boxer({
        fixed: true,
        callback: function() {
        }
    });

</script>

<script type="text/javascript">
    jQuery(document).ready(function(){
        jQuery('body').on('submit', 'form[rel=agent-message-form]', function(e){
            e.stopPropagation();
            e.preventDefault();

            var data = jQuery(this).serialize();

            if (jQuery('input[name=agent-user-id]').length) {
                data += '&user_id='+jQuery('input[name=agent-user-id]').val();
            }
			
			if (jQuery('input[name=object_id]').length) {
                data += '&object_id='+jQuery('input[name=object_id]').val();
            }

            jQuery.post(
                jQuery(this).attr('action'),
                data,
                function(response) {
                    if (!response) return;
                    if (response.status) {
                        jQuery('form[rel=agent-message-form]').find('.form-message').html('<div class="message">'+response.message+'</div>');
                        window.setTimeout("jQuery('.boxer-close').trigger('click');",3000);
                    } else {
                        jQuery('form[rel=agent-message-form]').find('.form-message').html('<div class="error">'+response.message+'</div>');
                    }
                },
                'json'
            )
        });
    });

</script>



<!-- Yandex.Metrika informer -->
<a class="metrika" href="https://metrika.yandex.ru/stat/?id=33452795&from=informer"
target="_blank" rel="nofollow"><img src="//informer.yandex.ru/informer/33452795/1_0_3EECC1FF_1ECCA1FF_0_pageviews"
style="width:80px; height:15px; border:0;" alt="Яндекс.Метрика" title="Яндекс.Метрика: данные за сегодня (просмотры)" /></a>
<!-- /Yandex.Metrika informer -->

<!-- Yandex.Metrika counter -->
<script type="text/javascript">
(function (d, w, c) {
(w[c] = w[c] || []).push(function() {
try {
w.yaCounter33452795 = new Ya.Metrika({id:33452795,
webvisor:true,
clickmap:true,
trackLinks:true,
accurateTrackBounce:true,
trackHash:true});
} catch(e) { }
});

var n = d.getElementsByTagName("script")[0],
s = d.createElement("script"),
f = function () { n.parentNode.insertBefore(s, n); };
s.type = "text/javascript";
s.async = true;
s.src = (d.location.protocol == "https:" ? "https:" : "http:") + "//mc.yandex.ru/metrika/watch.js";

if (w.opera == "[object Opera]") {
d.addEventListener("DOMContentLoaded", f, false);
} else { f(); }
})(document, window, "yandex_metrika_callbacks");
</script>
<noscript><div><img src="//mc.yandex.ru/watch/33452795" style="position:absolute; left:-9999px;" alt="" /></div></noscript>
<!-- /Yandex.Metrika counter -->

</body>
</html>
