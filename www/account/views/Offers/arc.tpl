<script type="text/javascript">
    $(document).ready(function(){
        
        var form = new Form(
            '#offers-create-arc-form',
            {
                'name': ['required'],
                'icon': ['required'],
                'arc_link': ['required']
            }
        );
        form.init();
        
        autocompleteInit({
            id: 'user_id',
            url: '/partners/autocomplete'
        });
    });
</script>

<form action="/offers/arccreate" id="offers-create-arc-form" role="form" method="POST" enctype="multipart/form-data">
    
    <div id="offers-create-arc-form-info-bar" class="alert form-info-bar"></div>
    <input type="hidden" name="arc_id" id="arc_id" value="" />
    
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-body">
                    <p>Данный инструмент позволяет обернуть Ваши .apk нашим SDK и получать доход с активаций. Просто залейте архив к себе на
                    сервер и пропишите ссылку на него ниже. Мы скачаем его и вернем Вам архив с уже обернутыми .apk с сохранением структуры вложенных папок.<br/><br/>
                    Статистика по всем загруженным Вами .apk будет считаться в рамках одного нового оффера.</p>
                </div>
            </div>
        </div>
        
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
                        <label>Иконка</label>
                        <input type="file" name="icon" id="icon" />
                        <p class="form-control-static caption-error" id="caption-icon"></p>
                    </div>
                </div>
                <div class="panel-footer">
                    <p>Название и иконка используются для отображения архива в списке офферов и в статистике</p>
                </div>
            </div>
        </div>
        
        <div class="col-lg-6">
            <div class="panel panel-info">
                <div class="panel-heading">
                    Архив
                </div>
                <div class="panel-body">
                    
                    <div class="form-group">
                        <label>Ссылка на zip-архив</label><br/>
                        <input type="text" name="arc_link" id="arc_link" class="form-control" />
                        <p class="help-block" style="margin-bottom:0">
                            Ссылка, по которой мы можем скачать архив с Вашими .apk
                        </p>
                        <p class="form-control-static caption-error" id="caption-arc_link"></p>
                    </div>
                    
                    <!--ul class="nav nav-tabs">
                        <li class="active">
                            <a href="#download" data-toggle="tab" aria-expanded="false" onclick="$('#arc_link').val('')">Загрузить архив</a>
                        </li>
                        <li>
                            <a href="#upload" data-toggle="tab" aria-expanded="true" onclick="$('#arc_file').val('')">Скачать по ссылке</a>
                        </li>
                    </ul>
                    <div class="tab-content">
                        <div class="tab-pane fade active in" id="download">
                            <div class="form-group">
                                <br/>
                                <label>Архив (zip или rar)</label>
                                <input type="file" name="arc_file" id="arc_file" />
                                <p class="form-control-static caption-error" id="caption-arc_file"></p>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="upload">
                            <div class="form-group">
                                <br/>
                                <label>Ссылка на архив (zip или rar)</label><br/>
                                <input type="text" name="arc_link" id="arc_link" class="form-control" />
                                <p class="form-control-static caption-error" id="caption-arc_link"></p>
                            </div>
                        </div>
                    </div-->
                    
                    <p class="form-control-static caption-error" id="caption-arc_group"></p>
                </div>
                <div class="panel-footer">
                    <p>Возможно указание ссылок только на прямое скачиание архива, например:<br/>
                    <code style="padding-left:0">http://yourdomain.com/downloads/apk-archive.zip</code><br/><br/>
                    Загрузка файлов с файлообменных сервисов (например GoogleDrive, DropBox, YandexDisk  и др.) на данный момент не предусмотрена</p>
                </div>
            </div>
        </div>
        
        <?php if ($view->_admin): ?>
		<div class="col-lg-6">
            <div class="panel panel-info">
                <div class="panel-heading">
                    Настройки
                </div>
                <div class="panel-body">
                    <div class="form-group input-group">
                        <span class="input-group-addon" style="cursor: pointer"><label for="user_id_select" style="cursor: pointer; margin-bottom:0;"><i class="fa fa-user fa-fw"></i></label></span>
                        <input type="text" id="user_id_select"  class="autocomplete-select form-control"
                               placeholder="Введите логин партнера..."
                               disabled="disabled"
                               value="Загружаю..." />
                        <input type="hidden" name="user_id" id="user_id" value="" />
                        <input type="hidden" name="user_id_title" id="user_id_title" value="" />
                    </div>
                    
                    <br/>
                    
                    <div class="form-group">
                        <div class="checkbox">
                            <label>
                                <input type="checkbox" name="is_protected" id="is_protected" value="1" checked="checked" /> DX-protector
                            </label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
		<?php endif; ?>
    </div>
    
    <div class="row">
        <div class="col-lg-6">
            <button type="submit" name="submit_add" class="btn btn-default">Добавить</button>
            <!--button type="submit" name="submit_and_continue" class="btn btn-default">Добавить и перейти к офферу</button-->
            <br/><br/>
        </div>
    </div>
</form>