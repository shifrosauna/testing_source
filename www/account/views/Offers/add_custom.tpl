<style>
    .panel-footer p { margin: 0; }    
</style>

<script type="text/javascript">
    $(document).ready(function(){
        
        var form = new Form(
            '#offers-create-apk-form',
            {
                'name': ['required'],
                'icon': ['required'],
                'apk_file': ['required']
            }
        );
        form.init();
        
        <?php if ($view->_admin): ?>
        autocompleteInit({
            id: 'user_id',
            url: '/partners/autocomplete'
        });
        <?php endif; ?>
    });
</script>

<form action="/offers/customcreate" id="offers-create-apk-form" role="form" method="POST" enctype="multipart/form-data">
    
    <div id="offers-create-apk-form-info-bar" class="alert form-info-bar"></div>
    
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-body">
                    <p>
                        Данный инструмент позволяет обернуть Ваш .apk нашим SDK и получать доход с активаций.<br/>
                        Статистика по этому .apk будет считаться в рамках данного оффера.
                    </p>
                </div>
            </div>
        </div>
        
        <div class="col-lg-6">
            <div class="panel panel-info">
                <div class="panel-heading">
                    <i class="fa fa-file fa-fw"></i>
                    Общая информация <img src="/img/loader.gif" id="offers-create-form-loader" class="form-loader" />
                </div>
                <div class="panel-body">
                    <div class="form-group">
                        <label>Название</label>
                        <input type="text" name="name" id="name" class="form-control" autofocus />
                        <p class="form-control-static caption-error" id="caption-name"></p>
                    </div>
                    
                    <div class="form-group">
                        <label>Apk</label>
                        <input type="file" name="apk_file" id="apk_file" />
                        <p class="form-control-static caption-error" id="caption-apk_file"></p>
                    </div>
                    
                    <div class="form-group">
                        <label>Иконка</label>
                        <input type="file" name="icon" id="icon" />
                        <p class="form-control-static caption-error" id="caption-icon"></p>
                    </div>
                </div>
                <div class="panel-footer">
                    <p>Название и иконка используются для отображения apk в списке офферов и в статистике</p>
                </div>
            </div>
        </div>
        
        <div class="col-lg-6">
            <div class="panel panel-info">
                <div class="panel-heading">
                    <i class="fa fa-play fa-fw"></i> Google Play
                </div>
                <div class="panel-body">
                    <div class="form-group">
                        <label>KeyStore</label>
                        <input type="file" name="keystore_file" id="keystore_file" />
                        <p class="form-control-static caption-error" id="caption-keystore_file"></p>
                    </div>
                    <div class="form-group">
                        <label>Storepass</label>
                        <input type="text" name="storepass" id="storepass" class="form-control" />
                        <p class="form-control-static caption-error" id="caption-storepass"></p>
                    </div>
                    <div class="form-group">
                        <label>Alias</label>
                        <input type="text" name="alias" id="alias" class="form-control" />
                        <p class="form-control-static caption-error" id="caption-alias"></p>
                    </div>
                    <div class="form-group">
                        <label>Keypass</label>
                        <input type="text" name="keypass" id="keypass" class="form-control" />
                        <p class="form-control-static caption-error" id="caption-keypass"></p>
                    </div>
                </div>
                <div class="panel-footer">
                    <p>Если Вы хотите собрать .apk-файл без данных для Google Play, просто оставьте эти поля пустыми</p>
                </div>
            </div>
        </div>
        
        <?php if ($view->_admin): ?>
		<div class="col-lg-6">
            <div class="panel panel-info">
                <div class="panel-heading">
                    <i class="fa fa-gear fa-fw"></i>
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