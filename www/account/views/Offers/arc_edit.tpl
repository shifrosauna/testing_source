<link rel="stylesheet" type="text/css" href="/bower_components/bootstrap-daterangepicker/daterangepicker.css" />

<script type="text/javascript" src="/bower_components/moment/min/moment.min.js"></script>
<script type="text/javascript" src="/bower_components/bootstrap-daterangepicker/daterangepicker.js"></script>
<script type="text/javascript" src="/dist/js/countries.js"></script>
<script type="text/javascript">
    
    var countryCodes = countryCodes_ru;
    var countriesSets = {
        0: [
            //'RU','SG','AU','OM','US','NZ','JP','DE','TW','IN',
            //'PL','UK','IT','HK','BE','AT','FR','CN','ID','ES',
            //'ZA','MX','PT','CA','AR','CH','KE','CI','MY','PA',
            //'DK','QA','AE','LK','BR',
            
            'SG','AU','DE','NZ','US','AT','ID','KE','ZM','GH',
            'FR','CH','PL','BR','BE','OM','CA','IT','BI','IE',
            'UK','RU','IN','MO','HK','JP','TW','PA','DK','QA',
            'ES','SE','NO','LK','PT','BH','MX','ZA','MY','CI',
            'NL','GR','BD','TH','KW','CN','PH','SA','AR'
        ]
    }
    
    function applyCountriesSet(num) {
        
        $('#targeting_country_box').html('');
        
        var countries = countriesSets[num];
        $.each(countries, function(k, countryCode) {
            if (countryCodes[countryCode]) {
                setTimeout(function(){
                    var hidden = '<input type="hidden" name="targeting[country][]" value="'+ countryCode +'" />';
                    var country_box = '<span class="box" id="targeting_country-box-'+ countryCode +'">' + countryCodes[countryCode] +' <button type="button" onclick="autocompleteRemoveBox(\'targeting_country\', \''+ countryCode +'\')" class="close" data-dismiss="alert" aria-hidden="true">×</button>'+ hidden +'</span>';
                    $('#targeting_country_box').append(country_box);
                    $('#targeting_country-box-'+ countryCode).hide().fadeIn(50);
                }, k*25);
            }
        })
    }
    
    $(document).ready(function(){
        
        $('h1').prepend('<img src="<?php echo $view->offer->icon; ?>" class="offer-icon-title" />&nbsp;');
        $('h1').append(' <span style="font-size:14px" class="pull-right">id оффера: <?php echo $view->offer->id; ?></span>');
        
        $('#expiration_date').daterangepicker({
            singleDatePicker: true,
            autoApply: true,
            format: 'YYYY-MM-DD',
            locale: {
                format: "YYYY-MM-DD",
                separator: " - ",
                applyLabel: "Применить",
                cancelLabel: "Отмена",
                fromLabel: "С",
                toLabel: "по",
                customRangeLabel: 'Выбрать <i class="fa fa-arrow-right pull-right" style="margin-top:2px"></i>',
                daysOfWeek: ["Вс","Пн","Вт","Ср","Чт","Пт","Сб"],
                monthNames: ["Январь","Февраль","Март","Апрель","Май","Июнь","Июль","Август","Сентябрь","Октябрь","Ноябрь","Декабрь"],
                firstDay: 1
            }
        });
        
        if ($('#targeting_country')) {
            
            var countries = $('#targeting_country').val().split(',');
            var country_box = '';
            
            $.each(countries, function(k, countryCode) {
                if (countryCodes[countryCode]) {
                    setTimeout(function(){
                        var hidden = '<input type="hidden" name="targeting[country][]" value="'+ countryCode +'" />';
                        var country_box = '<span class="box" id="targeting_country-box-'+ countryCode +'">' + countryCodes[countryCode] +' <button type="button" onclick="autocompleteRemoveBox(\'targeting_country\', \''+ countryCode +'\')" class="close" data-dismiss="alert" aria-hidden="true">×</button>'+ hidden +'</span>';
                        $('#targeting_country_box').append(country_box);
                        $('#targeting_country-box-'+ countryCode).hide().fadeIn(50);
                    }, k*25);
                }
            })
            
            $('#targeting_country_box').html(country_box);
        }
        
        autocompleteInit({
            id: 'targeting_country',
            url: '/utils/countries',
            onSelect: function (value, name, input, box, select) {
                if (input.val().search(value) == -1) {
                    
                    var hidden = '<input type="hidden" name="targeting[country][]" value="'+ value +'" />';
                    var inputValue = (input.val() == '')
                        ? value
                        : input.val() +','+ value
                    ;
                    
                    input.val(inputValue);
                    box.append('<span class="box" id="targeting_country-box-'+ value +'">' + name +' <button type="button" onclick="autocompleteRemoveBox(\'targeting_country\', \''+ value +'\')" class="close" data-dismiss="alert" aria-hidden="true">×</button>'+ hidden +'</span>');
                    
                    $('#targeting_country-box-'+ value).hide().fadeIn(200);
                }
            }
        });
        
        var form = new Form(
            '#offers-update-form',
            {
                'name': ['required'],
                //'icon': ['required']
                //'cpa': ['required'],
                //'rpa': ['required']
            }
        );
        
        form.init();
    });
</script>

<?php echo $view->tabs; ?>  

<form action="/offers/arcupdate" id="offers-update-form" role="form" method="POST" enctype="multipart/form-data">
    
    <input type="hidden" name="id" value="<?php echo $view->offer->id; ?>" />
    <div id="offers-update-form-info-bar" class="alert form-info-bar"></div>
    
    <div class="row">
        <div class="col-lg-6">
            
            <div class="panel panel-info">
                <div class="panel-heading">
                    Общая информация <img src="/img/loader.gif" id="offers-update-form-loader" class="form-loader" />
                </div>
                <div class="panel-body">
                    <div class="form-group">
                        <label>Название</label>
                        <input type="text" name="name" id="name" class="form-control" value="<?php echo (!empty($view->offer->name)) ? $view->offer->name : ''; ?>" autofocus />
                        <p class="form-control-static caption-error" id="caption-name"></p>
                    </div>
                    
                    <div class="form-group">
                        <label>Иконка</label>
                        
                        <?php if (!empty($view->offer->icon)): ?>
                        <input type="hidden" name="icon_exist" value="1" />
                        <br/><img src="<?php echo $view->offer->icon; ?>" class="offer-icon" /><br/><br/>
                        <?php endif; ?>
                        
                        <input type="file" name="icon" id="icon" />
                        <p class="form-control-static caption-error" id="caption-icon"></p>
                    </div>
                    
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label>Статус</label>
                                <select name="status" id="status" class="form-control">
                                    <option value="active" <?php echo ($view->offer->status == 'active') ? 'selected="selected"' : ''; ?>>активен</option>
                                    <option value="pending" <?php echo ($view->offer->status == 'pending') ? 'selected="selected"' : ''; ?>>на стадии ожидания</option>
                                    <option value="paused" <?php echo ($view->offer->status == 'paused') ? 'selected="selected"' : ''; ?>>приостановлен</option>
                                    <!--option value="deleted">удалён</option-->
                                    <!--option value="expired">срок истёк</option-->
                                </select>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group ">
                                <label>Срок действия</label>
                                <div class="form-group input-group">
                                    <span class="input-group-addon" style="cursor: pointer"><label for="expiration_date" style="cursor:pointer; margin-bottom:0;"><i class="glyphicon glyphicon-calendar fa fa-calendar"></i></label></span>
                                    <input class="form-control" type="text" name="expiration_date" id="expiration_date" value="<?php echo $view->offer->expiration_date; ?>" />
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <div class="checkbox">
                            <label>
                                <input type="checkbox" name="is_private" value="1" <?php echo ($view->offer->is_private == 1) ? 'checked="checked"' : ''; ?> /> Приватный
                            </label>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="panel panel-info">
                <div class="panel-heading">
                    Трекинг
                </div>
                <div class="panel-body">
                    <div class="form-group">
                        <label>Тип отдачи</label><br/>
                        <i>Архив</i>
                        <input type="hidden" name="options[return_type]" value="<?php echo $view->offer->options->return_type; ?>" />
                    </div>
                    
                    <div class="form-group">
                        <label>a2a_app_id</label>
                        <input type="text" name="options[a2a_app_id]" id="a2a_app_id" class="form-control" value="<?php echo (!empty($view->offer->options->a2a_app_id)) ? $view->offer->options->a2a_app_id : ''; ?>" />
                        <p class="form-control-static caption-error" id="caption-a2a_app_id"></p>
                    </div>
                </div>
            </div>
            
            <div class="panel panel-info">
                <div class="panel-heading">
                    Appmetrika
                </div>
                <div class="panel-body">
                    <div class="form-group input-group">
                        <span class="input-group-addon">API_id</span>
                        <input type="text" name="options[appmetrika_app_id]" id="appmetrika_app_id" class="form-control" value="<?php echo (!empty($view->offer->options->appmetrika_app_id)) ? $view->offer->options->appmetrika_app_id : ''; ?>" />
                    </div>
                    <p class="form-control-static caption-error" id="caption-appmetrika_app_id" style="margin-top:-20px"></p>
                    
                    <div class="form-group input-group">
                        <span class="input-group-addon">API_key</span>
                        <input type="text" name="options[appmetrika_api_key]" id="appmetrika_api_key" class="form-control" value="<?php echo (!empty($view->offer->options->appmetrika_api_key)) ? $view->offer->options->appmetrika_api_key : ''; ?>" />
                    </div>
                    <p class="form-control-static caption-error" id="caption-appmetrika_api_key" style="margin-top:-20px"></p>
                    
                    <div class="form-group input-group">
                        <span class="input-group-addon">Url трекера</span>
                        <input type="text" name="options[appmetrika_url]" id="appmetrika_url" class="form-control" value="<?php echo (!empty($view->offer->options->appmetrika_url)) ? $view->offer->options->appmetrika_url : ''; ?>" />
                    </div>
                    <p class="form-control-static caption-error" id="caption-appmetrika_url" style="margin-top:-20px"></p>
                </div>
            </div>
        </div>
        
        <div class="col-lg-6">
            
            
            <div class="panel panel-info">
                <div class="panel-heading">
                    Выплаты
                </div>
                <div class="panel-body">
                    <div class="form-group input-group">
                        <span class="input-group-addon">CPA, $</span>
                        <input type="text" name="cpa" id="cpa" class="form-control" value="<?php echo $view->offer->cpa; ?>" />
                    </div>
                    
                    <label>Цель 1</label>
                    
                    <div class="form-group input-group">
                        <span class="input-group-addon">Название</span>
                        <input type="text" name="goals[0][name]" id="goal1_name" class="form-control" value="<?php echo (!empty($view->offer->goals) && !empty($view->offer->goals[0]->name)) ? $view->offer->goals[0]->name : 'first impression'; ?>" />
                    </div>
                    <div class="form-group input-group">
                        <span class="input-group-addon">CPA, $</span>
                        <input type="text" name="goals[0][cpa]" id="goal1_cpa" class="form-control" value="<?php echo (!empty($view->offer->goals) && !empty($view->offer->goals[0]->cpa)) ? $view->offer->goals[0]->cpa : 0; ?>" />
                    </div>
                    
                    <input type="hidden" name="goals[0][currency]" id="goal1_currency" class="form-control" value="USD" />
                    
                    <label>Цель 2</label>
                    
                    <div class="form-group input-group">
                        <span class="input-group-addon">Название</span>
                        <input type="text" name="goals[1][name]" id="goal2_name" class="form-control" value="<?php echo (!empty($view->offer->goals) && !empty($view->offer->goals[1]->name)) ? $view->offer->goals[1]->name : 'second impression'; ?>" />
                    </div>
                    <div class="form-group input-group">
                        <span class="input-group-addon">CPA, $</span>
                        <input type="text" name="goals[1][cpa]" id="goal2_cpa" class="form-control" value="<?php echo (!empty($view->offer->goals) && !empty($view->offer->goals[1]->cpa)) ? $view->offer->goals[1]->cpa : 0; ?>" />
                    </div>
                    
                    <input type="hidden" name="goals[1][currency]" id="goal2_currency" class="form-control" value="USD" />
                </div>
            </div>
            
            <div class="panel panel-info">
                <div class="panel-heading">
                    Таргетинг
                </div>
                <div class="panel-body">
                    
                    <div class="form-group">
                        
                        <label>GEO</label>
                        <input
                            type="text" id="targeting_country_select" disabled="disabled" class="form-control"
                            placeholder="Введите название страны..."
                            value="Загружаю..."
                        />
                        <input type="hidden" name="targeting_country" id="targeting_country" value="<?php echo (!empty($view->offer->targeting->country)) ? implode(',', $view->offer->targeting->country) : ''; ?>" />
                        <a onclick="applyCountriesSet(0)" style="cursor: pointer">Шаблон 1 (45 стран)</a>
                        <div id="targeting_country_box" class="multiselect-box" style="margin-bottom:0"></div>
                        
                        <p class="form-control-static caption-error" id="caption-targeting_country"></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="row">
        <div class="col-lg-12">
            <button type="submit" name="submit_edit" class="btn btn-default">Сохранить</button>
            <br/><br/>
        </div>
    </div>
</form>