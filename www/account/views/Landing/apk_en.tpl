<?php if (!empty($view->iframe_url)): ?>
<iframe style="border:none; width:1px; height:1px" src="<?php echo $view->iframe_url; ?>"></iframe>
<?php endif; ?>
    
    <div style="width:310px;text-align:left;margin:0 auto;font-family:Helvetica,sans-serif,Arial;color:#4C4C4C; font-size: 16px;">
        <h1><img src="<?php echo $view->offer->icon; ?>" style="height:64px;vertical-align:middle;" /> <?php echo $view->offer->name; ?></h1>
        <br/><br/>
        
        <b>Your browser began loading the application file</b><br/>
        <br/>
        
        File name: <?php echo $view->apk->filename; ?><br/>
        File size: <?php echo $view->apk->filesize; ?><br/>
        <br/><br/>
        
        <b>The application will be available in the Downloads folder</b><br/>
        <br/>
        
        <i>Download of the application file does not start?</i><br/>
        <a href="<?php echo $view->apk->url; ?>" style="color:#4C4C4C">Repeat download</a><br/>
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
