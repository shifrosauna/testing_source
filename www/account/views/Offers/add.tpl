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
    
    function toggleDisabled(id, check) {
        if ($(check).is(':checked')) {
            $('#'+ id).attr('disabled', 'disabled');
        } else {
            $('#'+ id).removeAttr('disabled');
        }
    }
    
    $(document).ready(function(){
        
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
                    box.append('<span class="box" id="targeting_country-box-'+ value +'">'+ name +' <button type="button" onclick="autocompleteRemoveBox(\'targeting_country\', \''+ value +'\')" class="close" data-dismiss="alert" aria-hidden="true">×</button>'+ hidden +'</span>');
                    
                    $('#targeting_country-box-'+ value).hide().fadeIn(200);
                }
            }
        });
        
        var form = new Form(
            '#offers-create-form',
            {
                'name': ['required'],
                'description': ['required'],
                // 'preview_url': ['required'],
                // 'tracking_link': ['required'],
                'icon': ['required']
                //'cpa': ['required'],
                //'rpa': ['required']
            }
        );
        
        form.init();
    });
</script>

<!--ol class="breadcrumb">
    <li><a href="/offers">Офферы</a></li>
    <li class="active">Добавить оффер</li>
</ol-->

<form action="/offers/create" id="offers-create-form" role="form" method="POST" enctype="multipart/form-data">
    
    <div id="offers-create-form-info-bar" class="alert form-info-bar"></div>
    
    <div class="row">
        <div class="col-lg-6">
            
            <div class="panel panel-info">
                <div class="panel-heading">
                    Общая информация <img src="/img/loader.gif" id="offers-create-form-loader" class="form-loader" />
                </div>
                <div class="panel-body">
                    <div class="form-group">
                        <label>Название</label>
                        <input type="text" name="name" id="name" class="form-control" autofocus />
                        <p class="form-control-static caption-error" id="caption-name"></p>
                    </div>
                    <div class="form-group">
                        <label>Описание</label>
                        <textarea name="description" id="description" class="form-control" rows="5"></textarea>
                        <p class="form-control-static caption-error" id="caption-description"></p>
                    </div>
                    <div class="form-group">
                        <label>Preview url</label>
                        <input type="text" name="preview_url" id="preview_url" disabled="disabled" class="form-control" />
                        <div class="checkbox pull-right">
                            <label for="preview_url_generate" class="pull-right" style="padding-left:0">Генерировать автоматически</label>
                            <input type="checkbox" name="preview_url_generate" id="preview_url_generate" value="1" checked="checked"  onclick="toggleDisabled('preview_url', this)" class="pull-right" />
                        </div>
                        <p class="form-control-static caption-error" id="caption-preview_url"></p>
                    </div>
                    <div class="form-group">
                        <label>Иконка</label>
                        <input type="file" name="icon" id="icon" />
                        <p class="form-control-static caption-error" id="caption-icon"></p>
                    </div>
                    
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label>Статус</label>
                                <select name="status" id="status" class="form-control">
                                    <option value="active">активен</option>
                                    <option value="pending" selected="selected">на стадии ожидания</option>
                                    <option value="paused">приостановлен</option>
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
                                    <input class="form-control" type="text" name="expiration_date" id="expiration_date" value="<?php echo date("Y-m-d", strtotime("+1year")); ?>" />
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <div class="checkbox">
                            <label>
                                <input type="checkbox" name="is_private" value="1" /> Приватный
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
                        <label>Тип отдачи</label>
                        <select name="options[return_type]" id="return_type" class="form-control">
                            <option value="apk">apk</option>
                            <option value="apk_landing">apk через лендинг</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Трекинговая ссылка</label>
                        <input type="text" name="tracking_link" id="tracking_link" disabled="disabled" class="form-control" />
                        <div class="checkbox pull-right">
                            <label for="tracking_link_generate" class="pull-right" style="padding-left:0">Генерировать автоматически</label>
                            <input type="checkbox" name="tracking_link_generate" id="tracking_link_generate" value="1" checked="checked" onclick="toggleDisabled('tracking_link', this)" class="pull-right" />
                        </div>
                        <p class="form-control-static caption-error" id="caption-tracking_link"></p>
                    </div>
                    
                    <div class="form-group">
                        <label>a2a_app_id</label>
                        <input type="text" name="options[a2a_app_id]" id="a2a_app_id" class="form-control" />
                        <p class="form-control-static caption-error" id="caption-a2a_app_id"></p>
                    </div>
                    <div class="form-group">
                        <label>Apk</label>
                        <input type="file" name="apk_file" id="apk_file" />
                        <p class="form-control-static caption-error" id="caption-apk_file"></p>
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
                        <input type="text" name="options[appmetrika_app_id]" id="appmetrika_app_id" class="form-control" />
                        <p class="form-control-static caption-error" id="caption-appmetrika_app_id"></p>
                    </div>
                    
                    <div class="form-group input-group">
                        <span class="input-group-addon">API_key</span>
                        <input type="text" name="options[appmetrika_api_key]" id="appmetrika_api_key" class="form-control" />
                        <p class="form-control-static caption-error" id="caption-appmetrika_api_key"></p>
                    </div>
                    
                    <div class="form-group input-group">
                        <span class="input-group-addon">Url трекера</span>
                        <input type="text" name="options[appmetrika_url]" id="appmetrika_url" class="form-control" />
                        <p class="form-control-static caption-error" id="caption-appmetrika_url"></p>
                    </div>
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
                        <input type="text" name="cpa" id="cpa" class="form-control" value="0" />
                    </div>
                    <!--div class="form-group input-group">
                        <p class="form-control-static caption-error" id="caption-cpa"></p>
                    </div-->
                    
                    <label>Цель 1</label>
                    
                    <div class="form-group input-group">
                        <span class="input-group-addon">Название</span>
                        <input type="text" name="goals[0][name]" id="goal1_name" class="form-control" value="first impression" />
                    </div>
                    <div class="form-group input-group">
                        <span class="input-group-addon">CPA, $</span>
                        <input type="text" name="goals[0][cpa]" id="goal1_cpa" class="form-control" value="0.01" />
                    </div>
                    
                    <input type="hidden" name="goals[0][currency]" id="goal1_currency" class="form-control" value="USD" />
                    
                    <label>Цель 2</label>
                    
                    <div class="form-group input-group">
                        <span class="input-group-addon">Название</span>
                        <input type="text" name="goals[1][name]" id="goal2_name" class="form-control" value="second impression" />
                    </div>
                    <div class="form-group input-group">
                        <span class="input-group-addon">CPA, $</span>
                        <input type="text" name="goals[1][cpa]" id="goal2_cpa" class="form-control" value="0" />
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
                        <input type="hidden" name="targeting_country" id="targeting_country" />
                        <a onclick="applyCountriesSet(0)" style="cursor: pointer">Шаблон 1 (49 стран)</a>
                        <div id="targeting_country_box" class="multiselect-box" style="margin-bottom:0"></div>
                        <p class="form-control-static caption-error" id="caption-targeting_country"></p>
                    </div>
                    
                    <!--div class="form-group">
                        <label>Устройство</label>
                        <select name="targeting[device][]" id="targeting_device" class="form-control">
                            <option value="all">Все</option>
                            <option value="ios">iOS</option>
                            <option value="iphone">iPhone</option>
                            <option value="ipad">iPad</option>
                            <option value="android" selected>Android</option>
                            <option value="windows">Windows Phone</option>
                            <option value="blacberry">BlackBerry OS</option>
                        </select>
                        <p class="form-control-static caption-error" id="caption-targeting_device"></p>
                    </div-->
                </div>
            </div>
            
            <div class="panel panel-info">
                <div class="panel-heading">
                    Лендинг
                </div>
                <div class="panel-body">
                    <div class="form-group">
                        <label>Название</label>
                        <input type="text" name="options[landing_name]" id="options.landing_name" class="form-control" />
                        <p class="form-control-static caption-error" id="caption-landing_name"></p>
                    </div>
                    <div class="form-group">
                        <label>Краткое описание</label>
                        <textarea name="options[landing_desc1]" id="options.landing_desc1" class="form-control" rows="5"></textarea>
                        <p class="form-control-static caption-error" id="caption-landing_desc1"></p>
                    </div>
                    <div class="form-group">
                        <label>Подробное описание</label>
                        <textarea name="options[landing_desc2]" id="options.landing_desc2" class="form-control" rows="5"></textarea>
                        <p class="form-control-static caption-error" id="caption-landing_desc2"></p>
                    </div>
                    
                    <div class="form-group">
                        <label>Название (EN)</label>
                        <input type="text" name="translate[en][options.landing_name]" id="translate.en.options.landing_name" class="form-control" />
                    </div>
                    <div class="form-group">
                        <label>Краткое описание (EN)</label>
                        <textarea name="translate[en][options.landing_desc1]" id="translate.en.options.landing_desc1" class="form-control" rows="5"></textarea>
                    </div>
                    <div class="form-group">
                        <label>Подробное описание (EN)</label>
                        <textarea name="translate[en][options.landing_desc2]" id="translate.en.options.landing_desc2" class="form-control" rows="5"></textarea>
                    </div>
                    
                    <div class="form-group">
                        <label>Скриншоты</label>
                        <input type="file" name="screens[]" id="screens" multiple />
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="row">
        <div class="col-lg-12">
            
            <button type="submit" name="submit_add" class="btn btn-default">Добавить</button>
            <!--button type="submit" name="submit_and_continue" class="btn btn-default">Добавить и перейти к офферу</button-->
            
            <br/><br/>
            
        </div>
    </div>
</form>