<style>
    .loader {
        margin-bottom: -8px;
        margin-top: -8px;
    }
</style>

<script type="text/javascript">
    
    $(document).ready(function(){
        
        var fields = {
            'email': ['required'],
            'pswd': ['required']
        }
        
        var form = new Form('#auth-form', fields);
        form.init();
        form.showValidationFieldsMessage(false);
        form.callback(function(){
            location.href = $('#redirect_url').val();
        });
    });
</script>

<div class="login-panel panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title">Авторизация<img id="auth-form-loader" src="/img/loader.gif" class="form-loader" /></h3>
    </div>
    <div class="panel-body">
        <form action="/login" id="auth-form" role="form" method="POST">
            <div id="auth-form-info-bar" class="alert form-info-bar"></div>
            <input type="hidden" id="redirect_url" value="<?php echo $view->url; ?>" />
            
            <fieldset>
                <div class="form-group">
                    <input type="email" name="email" id="email" class="form-control" placeholder="E-mail" autofocus />
                    <p class="form-control-static caption-error" id="caption-email"></p>
                </div>
                <div class="form-group">
                    <input type="password" name="pswd" id="pswd" class="form-control" placeholder="Пароль" />
                    <p class="form-control-static caption-error" id="caption-pswd"></p>
                </div>
                <!--div class="checkbox">
                    <label>
                        <input name="remember" type="checkbox" value="Remember Me">Remember Me
                    </label>
                </div-->
                <!-- Change this to a button or input when using this as a form -->
                <button class="btn btn-lg btn-success btn-block">Войти</button>
            </fieldset>
        </form>
    </div>
</div>

<a href="/password">Восстановить пароль</a> <a href="/registration" class="pull-right">Зарегистрироваться</a>