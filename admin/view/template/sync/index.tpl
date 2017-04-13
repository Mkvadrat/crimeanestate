<?php echo $header; ?>
<div id="content">
    <div class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
            <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
        <?php } ?>
    </div>
    <?php if ($error_warning) { ?>
        <div class="warning"><?php echo $error_warning; ?></div>
    <?php } ?>
    <div id="msg"></div>
    <div class="box">
        <div class="heading">
            <h1><img src="view/image/user.png" alt="" /> <?php echo $heading_title; ?></h1>
            <div class="buttons"><a onclick="start_syncing()" class="button"><?php echo $button_start; ?></a></div>
        </div>
        <div class="content">
            <div id="dumps-list-wrapper">
            <?php echo $dumps ?>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    function start_syncing() {
        if (Syncer.active) {
            alert('Синхронизация уже активна');
            return;
        }
        Syncer.start();
    }

    Syncer = {
        break: false,
        inprogress: false,
        waiting_answer: false,
        cmd: '',
        data: null,
        content: null,
        active: false,
        open_wnd: function() {
            Syncer.active = true;
            Syncer.break = false;
            Syncer.inprogress = false;
            Syncer.waiting_answer = false;
            $('#syncer_wnd').remove();
            $('body').append('<div id="syncer_wnd" />');
            $('#syncer_wnd').css({
                'position': 'absolute',
                'z-index': '9999',
                'width': '600px',
                'height': '400px',
                'left': ($(window).width()-600)/2+$(window).scrollLeft(),
                'top': ($(window).height()-400)/2+$(window).scrollTop(),
                'background': '#fff',
                'border': '1px solid #777',
                'border-radius': '10px',
                'box-shadow': '0px 0px 10px #000',
                'padding': '20px'
            });
        },
        set_wnd_content: function(content) {
            $('#syncer_wnd').html(content);
        },
        close_wnd: function() {
            Syncer.active = false;
            $('#syncer_wnd').remove();
        },
        open_console: function() {
            Syncer.open_wnd();
            Syncer.set_wnd_content('<div id="syncer_console_content" style="width:580px;height:330px;padding:10px;overflow:scroll;border:1px solid #aaa;background: #fff;color:#000" /><input id="syncer_console_input" name="syncer_console_input" style="width:580px;padding:0px 20px;height:20px;margin:15px 0px 0px;padding: 0px 10px;border:1px solid #aaa;background: #fff;color:#000" placeholder=">" />');
            $('#syncer_console_input').focus();
            $('#syncer_console_input').keydown(function(e){
                if (e.keyCode == 13) {
                    var cmd = $('#syncer_console_input').val();
                    if (cmd.length>0) Syncer.console_message('> '+cmd);
                    $('#syncer_console_input').attr('value','');
                    if (cmd == 'stop' || cmd == 'break') {
                        Syncer.stop();
                    } else if (cmd == 'y' || cmd == 'Y' || cmd == 'n' || cmd == 'N' || cmd.length == 0) {
                        if (cmd.length == 0 || cmd == 'Y') cmd = 'y';
                        if (cmd == 'N') cmd = 'n';
                        Syncer.onAnswer(cmd);
                    } else if (!Syncer.waiting_answer) {
                        Syncer.exec(cmd);
                    } else if (Syncer.waiting_answer) {
                        Syncer.console_message('Да или нет ? [ y / n ]');
                    }
                }
            });
            Syncer.enableInput();
        },
        console_message: function(msg) {
            $('#syncer_console_content').append('<p>'+msg+'</p>');
            $('#syncer_console_content').animate({'scrollTop': $('#syncer_console_content').get(0).scrollHeight},100);
        },
        console_success: function(msg) {
            $('#syncer_console_content').append('<p style="color:green">'+msg+'</p>');
            $('#syncer_console_content').animate({'scrollTop': $('#syncer_console_content').get(0).scrollHeight},100);
        },
        console_error: function(msg) {
            $('#syncer_console_content').append('<p style="color:red">'+msg+'</p>');
            $('#syncer_console_content').animate({'scrollTop': $('#syncer_console_content').get(0).scrollHeight},100);
        },
        stop: function() {
            Syncer.break = true;
            Syncer.console_message('Breaking...');
            window.setTimeout("Syncer.close_wnd();", 1000);
        },
        disableInput: function() {
            //$('#syncer_console_input').attr('disabled','disabled');
            $('#syncer_console_input').attr('placeholder','Подождите...');
        },
        enableInput: function() {
            //$('#syncer_console_input').removeAttr('disabled');
            $('#syncer_console_input').attr('placeholder','>');
        },
        onAnswer: function(answer) {
            if (!Syncer.waiting_answer) return;
            Syncer.waiting_answer = false;
            if (answer == 'y' && typeof(Syncer.onAnswerYes != 'undefined')) {
                Syncer.onAnswerYes();
            } else if (answer == 'n' && typeof(Syncer.onAnswerNo != 'undefined')) {
                Syncer.onAnswerNo();
            }
            if (answer == 'n') Syncer.onExecSuccess = null;
        },
        onAnswerYes: function(){},
        onAnswerNo: function() {},
        ask: function(question, onAnswerYes, onAnswerNo) {
            Syncer.onAnswerYes = onAnswerYes;
            Syncer.onAnswerNo = onAnswerNo;
            Syncer.console_message(question);
            Syncer.console_message("[ y / n ] - введите 'n', если нет, 'y' или 'Enter', если да");
            Syncer.waiting_answer = true;

            $('#syncer_console_input').focus();
        },
        exec: function(cmd) {
            if (Syncer.break) return;
            if (Syncer.inprogress || Syncer.waiting_answer) {
                Syncer.console_message('Подождите окончания процесса');
                return;
            }
            Syncer.inprogress = true;
            Syncer.cmd = cmd;
            Syncer.disableInput();

            var sync_data =  {
                'cmd': cmd
            };
            if (Syncer.data!=null) sync_data.data = Syncer.data;

            $.post(
                '<?php echo html_entity_decode($this->url->link('sync/index', 'token=' . $this->session->data['token'] , 'SSL')) ?>',
                sync_data,
                function(response) {
                    if (Syncer.break) return;
                    Syncer.inprogress = false;
                    Syncer.enableInput();

                    if (!response) {
                        Syncer.console_error('Возникла ошибка');
                    } else {
                        if (typeof(response.data)!='undefined') {
                            Syncer.data = response.data;
                        } else {
                            Syncer.data = null;
                        }
                        if (typeof(response.content)!='undefined') {
                            Syncer.content = response.content;
                        } else {
                            Syncer.content = null;
                        }
                        if (response.message.length>0) {
                            if (response.status == 'error') {
                                Syncer.console_error(response.message);
                            } else {
                                Syncer.console_message(response.message);
                            }
                        }
                        if (response.status == 'ok') {
                            Syncer.console_success('Завершено');
                            Syncer.cmd = '';
                            if (typeof(Syncer.onExecSuccess)!='undefined' && Syncer.onExecSuccess) {
                                Syncer.onExecSuccess();
                            }
                        } else if (response.status == 'error') {
                            Syncer.ask('Возникла ошибка. Попробовать снова ?',
                                        function(){
                                            if (Syncer.cmd.length>0) {
                                                Syncer.console_message('Повтор...');
                                                Syncer.exec(Syncer.cmd);
                                            }
                                        }, function(){
                                                Syncer.console_error('Не выполнено');
                                        });
                        }
                    }
                },
                'json'
            ).fail(function(response){
                Syncer.inprogress = false;
                Syncer.enableInput();

                if (typeof(response.responseText)!='undefined') {
                    Syncer.console_message(response.responseText);
                }
                Syncer.console_error('Возникла ошибка');
            });
        },
        onExecSuccess: function(){},
        sync_dump_local: function() {
            Syncer.console_message('Снятие дампа локальной базы ...');
            Syncer.exec('dump local');
        },
        sync_dump_remote: function() {
            Syncer.console_message('Снятие дампа удаленной базы ...');
            Syncer.exec('dump remote');
        },
        sync_new_products: function() {
            Syncer.console_message('Синхронизация новых объектов ...');
            Syncer.exec('sync new products');
        },
        upload_new_products: function() {
            if (Syncer.content==null) {
                Syncer.console_message('Поиск файлов ...');
            } else {
                Syncer.console_message('Загрузка '+Syncer.content+' ...');
            }
            Syncer.exec('upload new products');
        },
        update_new_products: function() {
            Syncer.console_message('Обновление строк новых объектов ...');
            Syncer.exec('update new products');
        },
        sync_existing_products: function() {
            Syncer.console_message('Синхронизация существующих объектов ...');
            Syncer.exec('sync existing products');
        },
        upload_existing_products: function() {
            if (Syncer.content==null) {
                Syncer.console_message('Поиск файлов ...');
            } else {
                Syncer.console_message('Загрузка '+Syncer.content+' ...');
            }
            Syncer.exec('upload existing products');
        },
        update_existing_products: function() {
            Syncer.console_message('Обновление строк существующих объектов ...');
            Syncer.exec('update existing products');
        },
        delete_not_found_products: function() {
            Syncer.console_message('Удаление не найденных объектов ...');
            Syncer.exec('delete not found products');
        },
        update_seo_urls: function() {
            Syncer.console_message('Обновление SEO адресов ...');
            Syncer.exec('update seo urls');
        },
        update_banners: function() {
            Syncer.console_message('Обновление баннеров ...');
            Syncer.exec('update banners');
        },
        update_attributes: function() {
            Syncer.console_message('Обновление атрибутов ...');
            Syncer.exec('update attributes');
        },
        update_options: function() {
            Syncer.console_message('Обновление опций ...');
            Syncer.exec('update options');
        },
        update_categories: function() {
            Syncer.console_message('Обновление категорий ...');
            Syncer.exec('update categories');
        },
        update_informations: function() {
            Syncer.console_message('Обновление страниц ...');
            Syncer.exec('update informations');
        },
        update_news: function() {
            Syncer.console_message('Обновление новостей ...');
            Syncer.exec('update news');
        },
        clear_cache: function() {
            Syncer.console_message('Очистка кэша ...');
            Syncer.exec('clear cache');
        },
        sync: function(step) {
            if (Syncer.break) return;

            if (step == 'dump local') {
                Syncer.onExecSuccess = function() {
                    Syncer.onExecSuccess = null;
                    Syncer.sync('dump remote');
                }
                Syncer.sync_dump_local();
            } else if (step == 'dump remote') {
                Syncer.onExecSuccess = function() {
                    Syncer.onExecSuccess = null;
                    Syncer.sync('sync new products');
                }
                Syncer.sync_dump_remote();
            } else if (step == 'sync new products') {
                Syncer.onExecSuccess = function() {
                    Syncer.onExecSuccess = null;
                    Syncer.sync('upload new products');
                }
                Syncer.sync_new_products();
            } else if (step == 'upload new products') {
                Syncer.onExecSuccess = function() {
                    Syncer.onExecSuccess = null;
                    if (Syncer.data!=null) {
                        Syncer.sync('upload new products');
                    } else {
                        Syncer.sync('update new products');
                    }
                }
                Syncer.upload_new_products();
            } else if (step == 'update new products') {
                Syncer.onExecSuccess = function() {
                    Syncer.onExecSuccess = null;
                    Syncer.sync('sync existing products');
                }
                Syncer.update_new_products();
            } else if (step == 'sync existing products') {
                Syncer.onExecSuccess = function() {
                    Syncer.onExecSuccess = null;
                    Syncer.sync('upload existing products');
                }
                Syncer.sync_existing_products();
            } else if (step == 'upload existing products') {
                Syncer.onExecSuccess = function() {
                    Syncer.onExecSuccess = null;
                    if (Syncer.data!=null) {
                        Syncer.sync('upload existing products');
                    } else {
                        Syncer.sync('update existing products');
                    }
                }
                Syncer.upload_existing_products();
            } else if (step == 'update existing products') {
                Syncer.onExecSuccess = function() {
                    Syncer.onExecSuccess = null;
                    Syncer.sync('delete not found products');
                }
                Syncer.update_existing_products();
            } else if (step == 'delete not found products') {
                Syncer.onExecSuccess = function() {
                    Syncer.onExecSuccess = null;
                    Syncer.sync('update seo urls');
                }
                Syncer.delete_not_found_products();
            } else if (step == 'update seo urls') {
                Syncer.onExecSuccess = function() {
                    Syncer.onExecSuccess = null;
                    Syncer.sync('update banners');
                }
                Syncer.update_seo_urls();
            } else if (step == 'update banners') {
                Syncer.onExecSuccess = function() {
                    Syncer.onExecSuccess = null;
                    Syncer.sync('update attributes');
                }
                Syncer.update_banners();
            } else if (step == 'update attributes') {
                Syncer.onExecSuccess = function() {
                    Syncer.onExecSuccess = null;
                    Syncer.sync('update options');
                }
                Syncer.update_attributes();
            } else if (step == 'update options') {
                Syncer.onExecSuccess = function() {
                    Syncer.onExecSuccess = null;
                    Syncer.sync('update categories');
                }
                Syncer.update_options();
            } else if (step == 'update categories') {
                Syncer.onExecSuccess = function() {
                    Syncer.onExecSuccess = null;
                    Syncer.sync('update informations');
                }
                Syncer.update_categories();
            } else if (step == 'update informations') {
                Syncer.onExecSuccess = function() {
                    Syncer.onExecSuccess = null;
                    Syncer.sync('update news');
                }
                Syncer.update_informations();
            } else if (step == 'update news') {
                Syncer.onExecSuccess = function() {
                    Syncer.onExecSuccess = null;
                    Syncer.sync('clear cache');
                }
                Syncer.update_news();
            } else if (step == 'clear cache') {
                Syncer.onExecSuccess = function() {
                    Syncer.onExecSuccess = null;
                    Syncer.load_dumps();
                    Syncer.ask('<a href="javascript:void(0)" onclick="Syncer.close_wnd()">Кликните, чтобы закрыть</a> или нажмите [Enter]. Закрыть окно ?', function(){
                        Syncer.close_wnd();
                    }, function(){
                        Syncer.console_success('$ >');
                    });
                }
                Syncer.clear_cache();
            }
        },
        start: function() {
            Syncer.open_console();
            Syncer.console_success('Начало синхронизации');
            Syncer.sync('dump local');
        },
        load_dumps: function() {
            $.get(
                '<?php echo html_entity_decode($this->url->link('sync/index', 'dumps_only=1&token=' . $this->session->data['token'] , 'SSL')) ?>',
                function(response) {
                    $('#dumps-list-wrapper').html(response);
                }
            )
        }
    }

    function rollback(dir) {
        if (!confirm('Вы уверены ?')) {
            return;
        }
        $.post(
            '<?php echo html_entity_decode($this->url->link('sync/index', 'rollback=1&token=' . $this->session->data['token'] , 'SSL')) ?>',
            {
                'dir': dir
            },
            function(response) {
                $('#msg').html(response);
            }
        );
        $('#msg').html('<div class="warning">Подождите...</div>');
    }
</script>
<?php echo $footer; ?>