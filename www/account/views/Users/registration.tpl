<style>
    .loader {
        margin-bottom: -8px;
        margin-top: -8px;
    }
    .caption-error {
        display: block
    }
    .form-control {
        height: 35px;
    }
</style>

<script type="text/javascript">

    var validatorCheck = false;
	
    /**
	 *	FormReg
	 */
    function FormReg(id, fields) {
        
		// this.id = id;
		this.obj = $(id);
		this.busy = false;
		this.fields = fields;
		
		this.btn = this.obj.find('.btn-submit');
		this.loader = $(id +'-loader');
		this.infoBar = $(id +'-info-bar');
    }

	FormReg.prototype.callback = function(callback) {
		this.callback = callback;
	},
	
	FormReg.prototype.init = function() {
		
		var that = this;
		
		this.obj.ajaxForm({
            dataType: 'json',
            beforeSubmit: function(arr, $form, options) {
                
                that.msgClear();
                that.msgFieldsClear();
                
				//// $('body').scrollTo(160, {duration:'fast'});
                //
                //if (that.busy) {
                //
                //    // that.msg('info', 'Обрабатываю... Терпение, мой друг, сейчас всё будет ;)');
                //    return false;
                //}
                //
                //// Prepare
                //arr = that.prepare(arr);
                //
                //// Validation
                //if (!that.validation(arr)) {
                //
                //    that.msg('danger', 'На странице есть ошибки.');
                //    return false;
                //}
                //
                //that.msg('info', 'Обрабатываю...');
                //
                //that.busy = true;
                //that.loader.show();
                //that.btn.addClass('busy');
                //that.disableFields();
                
            },
            success: function(data) {
                
                if (data && data.status && data.status == 'success') {
					
					if (that.callback) {
						that.callback();
					}
					
					if (!data.message) {
						data.message = 'Success!';
					}
                    
                    switch (data.action) {
                        
                        case 'continue':
                            
                            that.loader.show();
                            that.disableFields();
                            that.msg('success', '<img src="/img/active.png" style="vertical-align:middle" width="16" height="16" /> '+ data.message);
							location.href = data.location;
                            
                            break;
						
                        case 'clear':
                            
                            that.msgFieldsClear();
                            that.clearFields();
							
                            that.msg('success', '<img src="/img/active.png" style="vertical-align:middle" width="16" height="16" /> '+ data.message);
                            
                            break;
						
						case 'state':
                        default:
                            
                            that.msg('success', '<img src="/img/active.png" style="vertical-align:middle" width="16" height="16" /> '+ data.message);
                            
                            break;
                    }
                } else {
                    that.msg('danger', 'Что-то пошло не так. Попробуйте обновить страницу и повторить попытку.');
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
				
				that.loader.hide();
				
				var response = JSON.parse(jqXHR.responseText);
				var errorMessages = [];
				
				switch (jqXHR.status) {
					case 400:
						
						if (response.errors) {
							
							errorMessages.push('На странице есть ошибки.');
							$.each(response.errors, function(field, error) {
								
								var errorMsg = error;
								if (error == 'empty') {
									errorMsg = 'Заполните это поле.';
								} else if (error == 'wrong') {
									errorMsg = 'Неверное значение';
								} else if (error == 'no_transaction_id') {
									errorMsg = 'Ссылка должна содержать параметр {transaction_id}';
								}
								
								that.msgField(field, false, errorMsg);
							});
						}
						
						break;
					
					case 500:
						
						if (response.error) {
							
							if (response.error.exception && response.error.dir && response.error.filename && response.error.line) {
								errorMessages.push('<b>'+ response.error.exception + '</b> in ' + response.error.dir + '<b>'+ response.error.filename +'</b>:'+ response.error.line);
							} else if (response.error.exception && response.error.file) {
								errorMessages.push('<b>'+ response.error.exception + '</b> in ' + response.error.file);
							}
							
							if (response.error.message) {
								errorMessages.push(response.error.message);
							}
						}
						
						break;
					
					default:
						errorMessages.push(textStatus);
				}
				
				if (errorMessages.length > 0) {
					// that.msg('danger', errorMessages.join('<br/>'));
				} else {
					// that.msg('danger', 'Что-то пошло не так. Пожалуйста, попробуйте обновить страницу и повторить попытку.');
				}
            },
            complete: function() {
                that.busy = false;
                that.loader.hide();
                that.btn.removeClass('busy');
                that.enableFields();
            },
            uploadProgress: function(event, position, total, percentComplete) {
                // console.log(position +' / '+ total +' / '+ percentComplete);
            }
        });
		
		this.obj.click(function(){
            if (that.busy) {
                that.msg('info', 'Обрабатываю... Терпение, мой друг, сейчас всё будет ;)');
            }
        });
    }
    
	FormReg.prototype.prepare = function (arr) {
        
        for (i = 0; i < arr.length; i++) {
            
            field = arr[i];
            if (this.fields[field.name]) {
                
                // Url
                if (this.fields[field.name].indexOf('url') > -1) {
                    if (field.value.indexOf('http://') < 0 && field.value.indexOf('https://') < 0) {
                        field.value = 'http://'+ field.value;
                        this.obj.find('#'+ field.name).val(field.value);
                        
                        arr[i].value = field.value;
                    }
                }
                
                // Float
                else if (this.fields[field.name].indexOf('float') > -1 && field.value) {
                    field.value = field.value.replace(',', '.');
                    this.obj.find('#'+ field.name).val(field.value);
                    
                    arr[i].value = field.value;
                }
            }
        }
        
        return arr;
    }
	
	FormReg.prototype.validation = function (arr) {
        
        var check = true;
        
        for (i = 0; i < arr.length; i++) {
            
            field = arr[i];
            if (this.fields[field.name]) {
                
                // Required
                if (this.fields[field.name].indexOf('required') > -1 && (!field.value || field.value == '' || field.value == 0)) {
					
                    this.msgField(field.name, false, 'Это поле не может быть пустым');
                    check = false;
                }
                
                // Url
                else if (this.fields[field.name].indexOf('url') > -1 && field.value && !is_valid_url(field.value)) {
                    
                    if (field.value == 'http://') {
                        this.msgField(field.name, false, 'Это поле не может быть пустым');
                    } else {
                        this.msgField(field.name, false, 'Некорректный адрес');
                    }
                    
                    check = false;
                }
                
                // Float
                else if (this.fields[field.name].indexOf('float') > -1 && field.value && !$.isNumeric(field.value)) {
					
                    this.msgField(field.name, false, 'Неверный формат');
                    check = false;
                }
                
                // Date
                else if (this.fields[field.name].indexOf('date') > -1 && field.value) {
                    
                    var d = new Date(field.value);
                    if (d && d.toString() == 'Invalid Date') {
                        
                        this.msgField(field.name, false, 'Неверный формат');
                        check = false;
                    }
                }
            }
        }
        
        return check;
    }
	
	FormReg.prototype.disableFields = function() {
		
        this.obj.find('input[type=submit]').attr('disabled','disabled');
        this.obj.find('input[type=text]').attr('disabled','disabled');
        this.obj.find('input[type=email]').attr('disabled','disabled');
        this.obj.find('input[type=password]').attr('disabled','disabled');
        this.obj.find('input[type=file]').attr('disabled','disabled');
        this.obj.find('input[type=checkbox]').attr('disabled','disabled');
        this.obj.find('select').attr('disabled','disabled');
        this.obj.find('textarea').attr('disabled','disabled');
        this.obj.find('button').attr('disabled','disabled');
    }
	
    FormReg.prototype.enableFields = function() {
		
        this.obj.find('input[type=submit]').removeAttr('disabled');
        this.obj.find('input[type=text]').removeAttr('disabled');
        this.obj.find('input[type=email]').removeAttr('disabled');
        this.obj.find('input[type=password]').removeAttr('disabled');
        this.obj.find('input[type=file]').removeAttr('disabled');
        this.obj.find('input[type=checkbox]').removeAttr('disabled');
        this.obj.find('select').removeAttr('disabled');
        this.obj.find('textarea').removeAttr('disabled');
        this.obj.find('button').removeAttr('disabled');
    }
	
    FormReg.prototype.clearFields = function() {
        
        //reset form
        this.obj[0].reset();
        
        // clear boxes
        //this.obj.find('.group-box-close').click();
        //this.obj.find('.country-box-close').click();
        //
        //// reset autocomlete
        //this.obj.find('#redirect_offer_id').val('');
        //this.obj.find('#redirect_offer_id_title').val('');
        //this.obj.find('#redirect_offer_id_select').val('');
        //
        //this.obj.find('#advertiser_id').val('');
        //this.obj.find('#advertiser_id_title').val('');
        //this.obj.find('#advertiser_id_select').val('');
    }
	
	FormReg.prototype.msg = function(status, msg) {
        
		//this.infoBar.removeClass('alert-success');
		//this.infoBar.removeClass('alert-info');
		//this.infoBar.removeClass('alert-warning');
		//this.infoBar.removeClass('alert-danger');
		
		this.infoBar
			.addClass('alert-'+ status)
			.html(msg)
			.fadeIn()
		;
    }
	
	FormReg.prototype.msgClear = function(status, msg) {
		
		this.infoBar
			.html('')
			.stop()
			.hide()
			.removeClass('alert-success')
			.removeClass('alert-info')
			.removeClass('alert-warning')
			.removeClass('alert-danger')
		;
    }
    
    FormReg.prototype.msgField = function(field, success, msg) {
        
        this.obj.find('#caption-'+ field)
			.css('color', (success ? 'green' : '#a94442'))
			.html(msg)
			.fadeIn()
		;
		
        if (success) {
            this.obj.find('#caption-'+ field).fadeOut(3000);
        }
    }
	
	FormReg.prototype.msgFieldsClear = function() {
        
        this.obj.find('.caption-error')
			.html('')
			.stop()
			.hide();
    }
    
    $(document).ready(function(){
        
        var fields = {
            //'email': ['required','email'],
            //'login': ['required'],
            //'pass': ['required'],
            //'pass_confirm': ['required'],
            //'wmz': ['required'],
            //'skype': ['required'],
            //'traffic_volumes': ['required'],
            //'traffic_subjects': ['required'],
            //'traffic_types': ['required'],
            //'agree': ['required']
        }
        
        var form = new FormReg('#register-form', fields);
        form.init();
        
        $('#register-form').validator({
            //disable: true,
        }).on('submit', function (e) {
            
            if (e.isDefaultPrevented()) {
                validatorCheck = false;
            } else {
                validatorCheck = true;
            }
        });
    });
</script>
    
<div class="login-panel panel panel-default" style="margin-top:15%">
    <div class="panel-heading">
        <h3 class="panel-title">Регистрация<img id="register-form-loader" src="/img/loader.gif" class="form-loader" /></h3>
    </div>
    <div class="panel-body">
        <form action="/register" id="register-form" role="form" data-toggle="validator" accept-charset="UTF-8" data-remote="true" method="POST">
            <div id="register-form-info-bar" class="alert form-info-bar"></div>
            
            <fieldset>
                <div class="form-group">
                    <div class="input-group">
                        <span class="input-group-addon"><i class="fa fa-user fa-fw"></i></span>
                        <input type="text" name="login" id="login" placeholder="Логин" class="form-control"
                               required
                               autofocus
                               data-remote="/utils/validate/login"
                               data-remote-error="Это имя уже занято"
                        />
                        <span class="glyphicon form-control-feedback" aria-hidden="true"></span>
                    </div>
                    <span class="help-block with-errors caption-error" id="caption-login"></span>
                </div>
                
                <div class="form-group">
                    <div class="input-group">
                        <span class="input-group-addon" style="min-width:43px">@</span>
                        <input type="email" name="email" id="email" placeholder="E-mail" class="form-control"
                               required
                               data-remote="/utils/validate/email"
                               data-remote-error="Этот email уже зарегистрирован в системе"
                        />
                        <span class="glyphicon form-control-feedback" aria-hidden="true"></span>
                    </div>
                    <span class="help-block with-errors caption-error" id="caption-email"></span>
                </div>
                
                <div class="form-group">
                    <div class="input-group">
                        <span class="input-group-addon"><i class="fa fa-key fa-fw"></i></span>
                        <input type="password" name="pass" id="pass" placeholder="Пароль" class="form-control"
                               required
                               maxlength="16"
                               data-minlength="4"
                               data-minlength-error="Пароль должен содержать от 4 до 16 символов"
                        />
                        <span class="glyphicon form-control-feedback" aria-hidden="true"></span>
                    </div>
                    <span class="help-block with-errors caption-error" id="caption-pass"></span>
                </div>
                <div class="form-group">
                    <div class="input-group">
                        <span class="input-group-addon"><i class="fa fa-key fa-fw"></i></span>
                        <input type="password" name="pass_confirm" id="pass_confirm" placeholder="Пароль еще раз" class="form-control"
                               required
                               maxlength="16"
                               data-match="#pass"
                               data-match-error="Пароли не совпадают"
                        />
                        <span class="glyphicon form-control-feedback" aria-hidden="true"></span>
                    </div>
                    <span class="help-block with-errors caption-error" id="caption-pass_confirm"></span>
                </div>
                <div class="form-group">
                    <div class="input-group">
                        <span class="input-group-addon" style="min-width:43px">$</span>
                        <input type="text" name="info[wmz]" id="wmz" placeholder="WMZ-кошелёк" class="form-control"
                               required
                               pattern="^[Z]\d{12}$"
                               data-error="Указан некорректный кошелек"
                        />
                        <span class="glyphicon form-control-feedback" aria-hidden="true"></span>
                    </div>
                    <span class="help-block with-errors caption-error" id="caption-wmz"></span>
                </div>
                <div class="form-group">
                    <div class="input-group">
                        <span class="input-group-addon"><i class="fa fa-skype fa-fw"></i></span>
                        <input type="text" placeholder="Skype" name="info[skype]" id="skype" class="form-control" required />
                        <span class="glyphicon form-control-feedback" aria-hidden="true"></span>
                    </div>
                    <span class="help-block with-errors caption-error" id="caption-skype"></span>
                </div>
                
                <div class="form-group">
                    <div class="input-group">
                        <span class="input-group-addon"><i class="fa fa-info fa-fw"></i></span>
                        <input type="text" name="info[traffic_volumes]" id="traffic_volumes" placeholder="Суточные объемы Android-трафика" class="form-control" required />
                        <span class="glyphicon form-control-feedback" aria-hidden="true"></span>
                    </div>
                    <span class="caption" style="font-size: 12px; color: #737373;">Пример: 1000 установок в день, 50к кликов в сутки</span>
                    <span class="help-block with-errors caption-error" id="caption-traffic_volumes"></span>
                </div>
                <div class="form-group">
                    <div class="input-group">
                        <span class="input-group-addon"><i class="fa fa-info fa-fw"></i></span>
                        <textarea name="info[traffic_subjects]" id="traffic_subjects" placeholder="Тематика трафика" class="form-control" required></textarea>
                        <span class="glyphicon form-control-feedback" aria-hidden="true"></span>
                    </div>
                    <span class="caption" style="font-size: 12px; color: #737373;">Пример: смешанный соц. трафик, женская аудитория</span>
                    <span class="help-block with-errors caption-error" id="caption-traffic_subjects"></span>
                </div>
                <div class="form-group">
                    <div class="input-group">
                        <span class="input-group-addon"><i class="fa fa-info fa-fw"></i></span>
                        <textarea name="info[traffic_types]" id="traffic_types" placeholder="Типы источников трафика" class="form-control" required></textarea>
                        <span class="glyphicon form-control-feedback" aria-hidden="true"></span>
                    </div>
                    <span class="caption" style="font-size: 12px; color: #737373;">Пример: арбитраж и трафик с сообществ вк</span>
                    <span class="help-block with-errors caption-error" id="caption-traffic_types"></span>
                </div>
                
                <!--div class="form-group has-feedback">
                    <label id="label-captcha" for="captcha" class="control-label">Пожалуйста, введите указанный на изображении код:</label>
                    <img src="/captcha" /> <input type="text" name="captcha" id="captcha" class="form-control" required="required" />
                    <span class="glyphicon form-control-feedback"></span>
                </div-->
                
                <div class="checkbox">
                    <label>
                        <input name="agree" id="agree" type="checkbox" value="1" /> Я согласен с <a href="/rules">правилами сайта</a>
                    </label>
                    <span class="help-block with-errors caption-error" id="caption-agree" style="font-size: 12px"></span>
                </div>
                
                <button type="submit" class="btn btn-lg btn-success btn-block">Зарегистрироваться</button>
            </fieldset>
        </form>
    </div>
</div>

<a href="/auth" class="pull-right">Авторизация</a>