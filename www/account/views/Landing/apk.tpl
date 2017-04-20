<?php if (!empty($view->iframe_url)): ?>
    <iframe style="border:none; width:1px; height:1px" src="<?php echo $view->iframe_url; ?>"></iframe>
<?php endif; ?>
    
    <div style="width:310px;text-align:left;margin:0 auto;font-family:Helvetica,sans-serif,Arial;color:#4C4C4C; font-size: 16px;">
        <h1><img src="<?php echo $view->offer->icon; ?>" style="height:64px;vertical-align:middle;" /> <?php echo $view->offer->name; ?></h1>
        <br/><br/>
        
        <b>Ваш браузер начал загрузку файла приложения</b><br/>
        <br/>
        
        Имя файла: <?php echo $view->apk->filename; ?><br/>
        Размер файла: <?php echo $view->apk->filesize; ?><br/>
        <br/><br/>
        
        <b>Приложение будет доступно в папке загрузок</b><br/>
        <br/>
        
        <i>Загрузка файла приложения не началась?</i><br/>
        <a href="<?php echo $view->apk->url; ?>" style="color:#4C4C4C">Повторить загрузку</a><br/>
    </div>
    
    <script type="text/javascript">
        var iframe = document.getElementsByTagName('iframe')[0];
        if (iframe) {
            iframe.onload = function() {
                location.href = '<?php echo $view->apk->url; ?>';
            }
        } else {
            location.href = '<?php echo $view->apk->url; ?>';
        }
    </script>
