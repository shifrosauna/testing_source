<script type="text/javascript">
    
    var statusWork = false;
    
    function apk(id) {
        
        var infoBar = $('#offers-apk-info-bar');
        var loader = $('#offers-apk-upload-loader');
        var reloader = $('#offers-apk-reupload-loader');
        var restarter = $('#offers-apk-restart-loader');
        
        loader.show();
        reloader.show();
        restarter.show();
        
        // clear'em all
        progress(0);
        $('#offers-apk-wait-message').html('Apk собирается');
        infoBar.html('').hide();
        $('.caption-error').html('');
        
        $.ajax({
            type:     'get',
            dataType: 'json',
            url:      '/offers/apk_load/'+ id,
            success:  function (data, textStatus, jqXHR) {
                
                loader.hide();
                reloader.hide();
                restarter.hide();
                
                if (data && data.status && data.status == 'success') {
                    
                    if (!$('#apk-success-body').hasClass('hide')) {
                        $('#apk-success-body').addClass('hide');
                    }
                    if (!$('#apk-upload-body').hasClass('hide')) {
                        $('#apk-upload-body').addClass('hide');
                    }
                    
                    $('#apk-wait-body').removeClass('hide');
                    
                    if (!statusWork) {
                        statusWork = true;
                        status(id);
                    }
                } else {
                    
                    infoBar.css('color', 'red').show().html('Ошибка');
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                
                loader.hide();
                reloader.hide();
                restarter.hide();
                
                var response = JSON.parse(jqXHR.responseText);
                
                switch (jqXHR.status) {
                    case 400:
                        
                        break;
                    
                    default:
                        infoBar.css('color', 'red').show().html('Ошибка: '+ textStatus);
                }
            }
        });
    }
    
    // Danger! Recursion!
    function status(id) {
        
        var loader = $('#offers-apk-upload-loader');
        var reloader = $('#offers-apk-reupload-loader');
        var restarter = $('#offers-apk-restart-loader');
        
        $.ajax({
            type:     'get',
            dataType: 'json',
            url:      '/offers/apk_status/'+ id,
            success:  function (data, textStatus, jqXHR) {
                
                if (data && data.status) {
                    
                    if (data.status == 'WAIT') {
                        
                        loader.hide();
                        reloader.hide();
                        restarter.hide();
                        
                        if ($('#apk_status').val() != 'WAIT') {
                            $('#apk_status').val('WAIT');
                            $('#apk-upload-body').addClass('hide');
                            $('#apk-wait-body').removeClass('hide');
                        }
                        
                        if (data.percent != parseInt($('#apk_percent').val())) {
                            progressDelay(data.percent, id);
                        } else {
                            
                            setTimeout(function(){
                                status(id);
                            }, 2000);
                        }
                    } else if (data.status == 'NOT_FOUND') {
                        setTimeout(function(){
                            status(id);
                        }, 2000);
                    } else if (data.status == 'SUCCESS') {
                        progress(100);
                        $('#offers-apk-wait-message').html('Готово.');
                        
                        statusWork = false;
                        
                        setTimeout(function(){
                            $('#apk_status').val('SUCCESS');
                            $('#apk-wait-body').addClass('hide');
                            $('#apk-success-body').removeClass('hide');
                        }, 1000);
                    } else if (data.status == 'FAILURE') {
                        
                        statusWork = false;
                        
                        setTimeout(function(){
                            apk(id);
                        }, 1000);
                    }
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                
                switch (jqXHR.status) {
                    case 400:
                        
                        break;
                    
                    default:
                        // infoBar.css('color', 'red').show().html('Ошибка: '+ textStatus);
                }
            }
        });
    }
    
    function progress(percent) {
        
        $('#apk-progress .progress-bar').css('width', percent +'%').attr('aria-valuenow', percent);
        $('.progress-percentage-label').html(percent +'%');
        $('#apk_percent').val(percent);
    }
    
    function progressDelay(percent, id) {
        
        if ($('#apk_percent').val() < percent) {
            setTimeout(function(){
                progress(parseInt($('#apk_percent').val()) + 1);
                progressDelay(percent, id);
            }, 200);
        } else if ($('#apk_percent').val() > percent)  {
            setTimeout(function(){
                progress(parseInt($('#apk_percent').val()) - 1);
                progressDelay(percent, id);
            }, 200);
        } else {
            setTimeout(function(){
                status(id);
            }, 1000);
        }
    }
    
    $(document).ready(function(){
        
        $('h1').prepend('<img src="<?php echo $view->offer->icon; ?>" class="offer-icon-title" />&nbsp;');
        $('h1').append(' <span style="font-size:14px" class="pull-right">id оффера: <?php echo $view->offer->id; ?></span>');
        
        if ($('#apk_status').val() == 'WAIT') {
            var percent = $('#apk_percent').val();
            setTimeout(function(){
                
                progress(percent);
                
                var offer_id = $('#offer_id').val();
                status(offer_id);
            }, 350);
        }
    });
</script>

<?php echo ($view->_admin) ? $view->tabs : ''; ?>

<div class="row">
    
    <input type="hidden" id="offer_id" value="<?php echo $view->offer->id; ?>" />
    <input type="hidden" id="apk_status" value="<?php echo $view->offer->apk->status; ?>" />
    <input type="hidden" id="apk_percent" value="<?php echo $view->offer->apk->percent; ?>" />
    
    <div class="col-lg-6">
        
        <?php if (!empty($view->offer->options->return_type) && !in_array($view->offer->options->return_type, array('arc', 'multiple', 'apk_custom'))): ?>
        <div class="panel panel-info">
            <div class="panel-heading">
                Общая информация 
            </div>
            <div class="panel-body">
                <?php echo $view->offer->description; ?>
                
                <br/><br/>
                
                <div class="form-group">
                    <label>Ссылка на превью:</label>
                    <a href="<?php echo $view->offer->preview_url; ?>"><?php echo $view->offer->preview_url; ?></a>
                </div>
            </div>
        </div>
        <?php endif; ?>
        
        <?php if (!empty($view->offer->options->return_type) && $view->offer->options->return_type == 'apk_custom'): ?>
        <div class="panel panel-info">
            <div class="panel-heading">
                Apk
            </div>
            
            <div id="apk-success-body" class="panel-body<?php echo ($view->offer->apk->status != 'SUCCESS') ? ' hide': ''; ?>">
                <div class="form-group">
                    <label>Файл apk готов, Вы можете скачать его по этой ссылке:</label><br/>
                    <span id="apk_file_wrapped"><a href="<?php echo (!empty($view->offer->apk_file_wrapped)) ? $view->offer->apk_file_wrapped : ''; ?>">Скачать apk</a></span>
                    
                    <?php if ($view->_admin): ?>
                    <br/><br/>
                    <button class="btn btn-default" onclick="apk(<?php echo $view->offer->id; ?>)">Переобернуть</button>
                    <img src="/img/loader.gif" id="offers-apk-reupload-loader" class="form-loader" />
                    <?php endif; ?>
                </div>
            </div>
            
            <div id="apk-wait-body" class="panel-body<?php echo ($view->offer->apk->status != 'WAIT') ? ' hide': ''; ?>">
                <div class="col-lg-2">
                    <img src="/img/loader-gears.gif" id="offers-apk-wait-loader" />
                </div>
                <div class="col-lg-10">
                    <p>
                        <strong id="offers-apk-wait-message">Apk собирается</strong>
                        <span class="pull-right text-muted progress-percentage-label"><?php echo $view->offer->apk->percent; ?>%</span>
                    </p>
                    <div class="progress progress-striped active" id="apk-progress">
                        <div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 0%">
                            <span class="sr-only progress-percentage-label">0%</span>
                        </div>
                    </div>
                    
                    Пожалуйста, подождите несколько минут - мы формируем .apk-файл приложения.
                    
                    <?php if ($view->_admin): ?>
                    <br/><br/>
                    <button class="btn btn-default" onclick="apk(<?php echo $view->offer->id; ?>)">Рестарт</button>
                    <img src="/img/loader.gif" id="offers-apk-restart-loader" class="form-loader" />
                    <?php endif; ?>
                </div>
            </div>
            
            <div id="apk-upload-body" class="panel-body<?php echo ($view->offer->apk->status == 'SUCCESS' || $view->offer->apk->status == 'WAIT') ? ' hide': ''; ?>">
                <div id="offers-apk-info-bar" class="alert form-info-bar"></div>
                <button class="btn btn-default" onclick="apk(<?php echo $view->offer->id; ?>)">Обернуть apk-файл</button>
                <img src="/img/loader.gif" id="offers-apk-upload-loader" class="form-loader" />
            </div>
        </div>
        <?php endif; ?>
        
        <div class="panel panel-info">
            <div class="panel-heading">
                Таргетигнг и тип отдачи 
            </div>
            <div class="panel-body">
                <div class="form-group">
                    <label>Платформа:</label>
                    Android
                </div>
                
                <?php if (empty($view->offer->options->return_type) || $view->offer->options->return_type != 'apk_custom'): ?>
                <div class="form-group input-group">
                    <label>Тип отдачи:</label>
                    <?php echo $view->offer->view->return_type; ?>
                </div>
                <?php endif; ?>
                
                <div class="form-group">
                    <label>Принимаемые страны:</label>
                    <?php echo $view->offer->view->countries; ?>
                </div>
            </div>
        </div>
        
        <?php if (!empty($view->offer->options->return_type) && !in_array($view->offer->options->return_type, array('arc', 'multiple', 'apk_custom'))): ?>
        <div class="panel panel-info">
            <div class="panel-heading">
                Трекинг
            </div>
            
            <div id="apk-success-body" class="panel-body<?php echo ($view->offer->apk->status != 'SUCCESS') ? ' hide': ''; ?>">
                <div class="form-group">
                    <label>Трекинговая ссылка:</label><br/>
                    <span id="tracking_link"><?php echo $view->offer->partner_tracking_link; ?></span>
                    
                    <?php if ($view->_admin): ?>
                    <br/><br/>
                    <button class="btn btn-default" onclick="apk(<?php echo $view->offer->id; ?>)">Переобернуть</button>
                    <img src="/img/loader.gif" id="offers-apk-reupload-loader" class="form-loader" />
                    <?php endif; ?>
                </div>
            </div>
            
            <div id="apk-wait-body" class="panel-body<?php echo ($view->offer->apk->status != 'WAIT') ? ' hide': ''; ?>">
                <div class="col-lg-2">
                    <img src="/img/loader-gears.gif" id="offers-apk-wait-loader" />
                </div>
                <div class="col-lg-10">
                    <p>
                        <strong id="offers-apk-wait-message">Apk собирается</strong>
                        <span class="pull-right text-muted progress-percentage-label"><?php echo $view->offer->apk->percent; ?>%</span>
                    </p>
                    <div class="progress progress-striped active" id="apk-progress">
                        <div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 0%">
                            <span class="sr-only progress-percentage-label">0%</span>
                        </div>
                    </div>
                    
                    Пожалуйста, подождите несколько минут.<br/><br/>Мы формируем .apk-файл приложения.
                    Трекинг-ссылка будет предоставлена после завершения формирования .apk-файла.
                    
                    <?php if ($view->_admin): ?>
                    <br/><br/>
                    <button class="btn btn-default" onclick="apk(<?php echo $view->offer->id; ?>)">Рестарт</button>
                    <img src="/img/loader.gif" id="offers-apk-restart-loader" class="form-loader" />
                    <?php endif; ?>
                </div>
            </div>
            
            <div id="apk-upload-body" class="panel-body<?php echo ($view->offer->apk->status == 'SUCCESS' || $view->offer->apk->status == 'WAIT') ? ' hide': ''; ?>">
                <div id="offers-apk-info-bar" class="alert form-info-bar"></div>
                <button class="btn btn-default" onclick="apk(<?php echo $view->offer->id; ?>)">Получить трекинг-ссылку на оффер</button>
                <img src="/img/loader.gif" id="offers-apk-upload-loader" class="form-loader" />
            </div>
        </div>
        <?php endif; ?>
    </div>
    
    <div class="col-lg-6">
        <div class="panel panel-info">
            <div class="panel-heading">
                Ставки
            </div>
            <div class="panel-body">
                <div class="form-group">
                    <label>Целевое действие:</label>
                    <b>активация приложения</b>
                </div>
                
                Активация приложения происходит примерно через сутки<br/>
                после установки пользователем.
                
                <br/><br/>
                
                <?php if (!empty($view->offer->countries_payouts)): ?>
                <div class="table-responsive">
                    <table class="table table-striped table-bordered table-hover">
                        <thead>
                            <tr>
                                <th>Страна</th>
                                <th>Ставка</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($view->offer->countries_payouts as $country): ?>
                            <tr>
                                <td><?php echo $country->name; ?></td>
                                <td><b><?php echo $country->cpa; ?></b> $</td>
                            </tr>
                            <?php endforeach; ?>
                            
                            <?php /* if (count($view->offer->countries_payouts) < count($view->offer->targeting->country)): ?>
                            <tr>
                                <td>Остальные</td>
                                <td><b><?php echo $view->offer->goals[0]->cpa; ?></b> $</td>
                            </tr>
                            <?php endif; */ ?>
                        </tbody>
                    </table>
                </div>
                <?php endif; ?>
            </div>
        </div>
    </div>
</div>