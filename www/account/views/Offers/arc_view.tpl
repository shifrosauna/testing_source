<script type="text/javascript">
    
    var statusWork = false;
    
    function workMessage(msg, caption) {
        $('#arc-work-message').html(msg);
        $('#arc-work-caption').html(caption);
    }
    
    // Danger! Recursion!
    function status(id) {
        
        var loader = $('#arc-loader');
        
        $.ajax({
            type:     'get',
            dataType: 'json',
            url:      '/offers/arc_status/'+ id,
            success:  function (data, textStatus, jqXHR) {
                
                if (data && data.status) {
                    
                    if ($('#arc_status').val() != data.status) {
                        $('#arc_status').val(data.status);
                    }
                    
                    switch (data.status) {
                        
                        case 'UPLOAD':
                            
                            workMessage(
                                'Загрузка архива ('+ data.dest_filesize +' / '+ data.source_filesize +')',
                                'Пожалуйста, подождите.<br/>Мы загружаем архив на сервер.'
                            );
                            
                            break;
                        
                        case 'UNPACK':
                            
                            workMessage(
                                'Распаковка архива ('+ data.dest_filesize +' / '+ data.source_filesize +')',
                                'Пожалуйста, подождите.<br/>Мы распаковываем загруженный архив.'
                            );
                            
                            break;
                        
                        case 'WRAP':
                            
                            workMessage(
                                'Сборка Apk ('+ data.count_wrapped +' / '+ data.count_all +')',
                                'Пожалуйста, подождите.<br/>Мы оборачиваем apk-файлы из архива.'
                            );
                            
                            if (data.intermediate_link && data.intermediate_count) {
                                
                                $('#intermediate_link').find('a')
                                    .attr('href', data.intermediate_link)
                                    .text('Скачать готовые '+ data.intermediate_count +' .apk');
                                    
                                $('#intermediate_label_count').text(data.intermediate_count);
                                
                                $('#arc-intermediate-body').removeClass('hide');
                            }
                            
                            break;
                        
                        case 'SUCCESS':
                            
                            progress(100);
                            statusWork = false;
                            
                            workMessage('Готово', '');
                            
                            setTimeout(function(){
                                $('#arc-work-body').addClass('hide');
                                $('#arc-intermediate-body').addClass('hide');
                                $('#arc-success-body').removeClass('hide');
                            }, 1000);
                            
                            // console.log(data.result_link);
                            // console.log(data);
                            
                            $('#result_link').find('a').attr('href', data.result_link);
                            
                            break;
                    }
                    
                    if (data.percent != parseInt($('#arc_percent').val())) {
                        progressDelay(data.percent, id);
                    } else if (data.status != 'SUCCESS') {
                        setTimeout(function(){
                            status(id);
                        }, 1000);
                    }
                } else {
                    setTimeout(function(){
                        status(id);
                    }, 1000);
                }
                
                if (data && data.apks) {
                    
                    var apks = [];
                    
                    if (data.apks['SUCCESS']) {
                        apks = $.merge(apks, data.apks['SUCCESS']);
                    }
                    
                    if (data.apks['FAILURE']) {
                        apks = $.merge(apks, data.apks['FAILURE']);
                    }
                    
                    if (data.apks['WAIT']) {
                        apks = $.merge(apks, data.apks['WAIT']);
                    }
                    
                    if (apks && apks.length > 0) {
                        if ($('#arc-apks-block').hasClass('hide')) {
                            $('#arc-apks-block').removeClass('hide');
                        }
                        
                        $.each(apks, function (id, apk) {
                            
                            if (!$('#apk-'+ apk.id).attr('id')) {
                                $('#arc-apks-table tbody').append('<tr class="'+ apk.status +'" id="apk-'+ apk.id +'"><td class="apk-localpath">'+ apk.localpath.replace(apk.filename, '<b>'+ apk.filename +'</b>') +'</td><td class="apk-percent text-right">'+ apk.percent +'%</td></tr>');
                            } else {
                                $('#apk-'+ apk.id).find('.apk-percent').html(apk.percent +'%');
                                $('#apk-'+ apk.id).attr('class', apk.status);
                            }
                        });
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
                
                setTimeout(function(){
                    status(id);
                }, 5000);
            }
        });
    }
    
    function progress(percent) {
        
        $('#arc-progress .progress-bar').css('width', percent +'%').attr('aria-valuenow', percent);
        $('.progress-percentage-label').html(percent +'%');
        $('#arc_percent').val(percent);
    }
    
    function progressDelay(percent, id) {
        
        var speed = 150;
        var current_percent = parseInt($('#arc_percent').val());
        
        var percent_diff = Math.abs(current_percent - percent);
        if (current_percent > percent) {
            speed = 10
        } else if (percent_diff > 10) {
            speed = 100;
        } else if (percent_diff > 50) {
            speed = 50;
        }
        
        if (current_percent < percent) {
            setTimeout(function(){
                progress(current_percent + 1);
                progressDelay(percent, id);
            }, speed);
        } else if (current_percent > percent)  {
            setTimeout(function(){
                progress(current_percent - 1);
                progressDelay(percent, id);
            }, speed);
        } else {
            setTimeout(function(){
                status(id);
            }, 1000);
        }
    }
    
    $(document).ready(function(){
        
        $('h1').prepend('<img src="<?php echo $view->offer->icon; ?>" class="offer-icon-title" />&nbsp;');
        $('h1').append(' <span style="font-size:14px" class="pull-right">id оффера: <?php echo $view->offer->id; ?></span>');
        
        if ($('#arc_status').val() != 'SUCCESS') {
            
            var percent = $('#arc_percent').val();
            setTimeout(function(){
                
                progress(percent);
                
                var arc_id = $('#arc_id').val();
                status(arc_id);
            }, 350);
        }
    });
</script>

<?php echo ($view->_admin) ? $view->tabs : ''; ?>

<div class="row">
    
    <input type="hidden" id="arc_id" value="<?php echo $view->arc->id; ?>" />
    <input type="hidden" id="arc_status" value="<?php echo $view->arc->status; ?>" />
    <input type="hidden" id="arc_percent" value="<?php echo $view->arc->percent; ?>" />
    
    <div class="col-lg-6">
        <div class="panel panel-info">
            <div class="panel-heading">
                Архив
            </div>
            
            <div class="panel-body">
                <div id="arc-work-body" class="row<?php echo ($view->arc->status == 'SUCCESS') ? ' hide': ''; ?>">
                    <div class="col-lg-2" style="text-align: center;">
                        <img src="/img/loader-gears.gif" id="offers-arc-wait-loader" />
                    </div>
                    <div class="col-lg-10">
                        <p>
                            <strong id="arc-work-message">...</strong>
                            <span class="pull-right text-muted progress-percentage-label"><?php echo $view->arc->percent; ?>%</span>
                        </p>
                        <div class="progress progress-striped active" id="arc-progress">
                            <div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 0%">
                                <span class="sr-only progress-percentage-label">0%</span>
                            </div>
                        </div>
                        <p id="arc-work-caption">
                            <img src="/img/loader.gif" id="qwd" />
                        </p>
                    </div>
                </div>
                
                <div id="arc-intermediate-body" class="row<?php echo (empty($view->arc->intermediate_link)) ? ' hide': ''; ?>">
                <br/>
                    <div class="col-lg-2" style="text-align: center;">
                        <img src="/img/archive.png" id="offers-arc-wait-loader" style="width:64px" />
                    </div>
                    <div class="col-lg-10">
                        <div class="form-group">
                            <label>Уже обернутые apk-файлы (их сейчас <span id="intermediate_label_count"><?php echo (!empty($view->arc->intermediate_count)) ? $view->arc->intermediate_count : ''; ?></span>) Вы можете скачать по ссылке ниже:</label><br/>
    
                            <span id="intermediate_link"><a href="<?php echo (!empty($view->arc->intermediate_link)) ? $view->arc->intermediate_link : ''; ?>">Скачать готовые <?php echo (!empty($view->arc->intermediate_count)) ? $view->arc->intermediate_count : ''; ?> .apk</a></span>
                        </div>
                    </div>
                </div>
                
                <div id="arc-success-body" class="row<?php echo ($view->arc->status != 'SUCCESS') ? ' hide': ''; ?>">
                    <div class="col-lg-2" style="text-align: center;">
                        <img src="/img/archive.png" id="offers-arc-wait-loader" style="width:64px" />
                    </div>
                    <div class="col-lg-10">
                        <div class="form-group">
                            <label>Ссылка на архив:</label><br/>
                            <span id="result_link"><a href="<?php echo (!empty($view->arc->result_link)) ? $view->arc->result_link : ''; ?>">Скачать</a></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div id="arc-apks-block" class="col-lg-6 <?php echo (empty($view->arc->count_all)) ? 'hide' : ''; ?>">
        <div class="panel panel-info">
            <div class="panel-heading">
                Приложения
            </div>
            <div class="panel-body">
                <div class="table-responsive">
                    <table class="table table-hover" id="arc-apks-table">
                        <thead>
                            <tr>
                                <th>Путь</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody><?php if (!empty($view->arc->apks)): ?>
                            <?php foreach($view->arc->apks as $status => $apks): ?>
                            <?php foreach($apks as $apk): ?>
                            
                            <tr class="<?php echo $apk->status; ?>" id="apk-<?php echo $apk->id; ?>">
                                <td class="apk-localpath"><?php echo str_replace($apk->filename, '<b>'. $apk->filename .'</b>', $apk->localpath); ?></td>
                                <td class="apk-percent text-right"><?php echo $apk->percent; ?>%</td>
                            </tr>
                            
                            <?php endforeach; ?>
                            <?php endforeach; ?>
                            <?php endif; ?></tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>