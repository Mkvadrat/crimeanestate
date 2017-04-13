<div class="dev-quest">
<form id="page-contact-form" onsubmit="return submit_page_contact_form()">
    <span class="title">Есть вопросы?</span>
    <span class="title-text">Оставьте свои контактные данные, и мы свяжемся с вами</span>
    <label>Имя</label>
    <input type="text" name="name">
    <label>Email</label>
    <input type="text" name="email">
    <label>Телефон</label>
    <input type="text" name="phone">
    <label>Сообщение</label>
    <textarea class="text-mess" name="text"></textarea>
    <input class="but-send" type="submit" value="ОТПРАВИТЬ">
</form>
</div>

<script type="text/javascript">
    function submit_page_contact_form() {
        var name = jQuery('#page-contact-form input[name=name]').val();
        var email = jQuery('#page-contact-form input[name=email]').val();
        var phone = jQuery('#page-contact-form input[name=phone]').val();
        var text = jQuery('#page-contact-form textarea[name=text]').val();

        if (email.length==0 && phone.length==0) {
            alert('Укажите свой Email или телефон');
            return false;
        }
        if (text.length==0) {
            alert('Введите сообщение');
            return false;
        }

        jQuery.post(
            'index.php?route=information/contact/page',
            {
                'name': name,
                'email': email,
                'phone': phone,
                'text': text
            },
            function(response) {
                if (!response) return;
                if (response.message.length>0) {
                    alert(response.message);
                    if (response.status) {
                        $('#page-contact-form').get(0).reset();
                    }
                }
            },
            'json'
        );

        return false;
    }
</script>