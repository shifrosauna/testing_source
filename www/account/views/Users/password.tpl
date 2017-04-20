<style>
    .form-loader {
        margin-bottom: -8px;
        margin-top: -8px;
    }
</style>

<script type="text/javascript">
    $(document).ready(function(){
        var form = new Form('#reset-form', {'email': ['required']});
        form.init();
        form.showValidationFieldsMessage(false);
    });
</script>

<div class="login-panel panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title">Восстановить пароль <img id="reset-form-loader" src="/img/loader.gif" class="form-loader" /></h3>
    </div>
    <div class="panel-body">
        <form action="/reset" id="reset-form" role="form" method="POST">
            <div id="reset-form-info-bar" class="alert form-info-bar"></div>
            
            <fieldset>
                <div class="form-group">
                    <input type="email" name="email" id="email" class="form-control" placeholder="E-mail" autofocus />
                    <p class="form-control-static caption-error" id="caption-email"></p>
                </div>
                <button type="submit" class="btn btn-lg btn-success btn-block">Отправить</button>
            </fieldset>
        </form>
    </div>
</div>

<a href="/auth">Авторизация</a> <a href="/registration" class="pull-right">Зарегистрироваться</a>