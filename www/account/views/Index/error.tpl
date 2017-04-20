<br/><br/>


<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-danger">
            <div class="panel-heading">
                <?php echo (!empty($view->exception)) ? $view->exception : 'Error'; ?>
            </div>
            <div class="panel-body">
                
                <?php echo $view->message; ?>
                
                <?php if (!empty($view->exception)): ?>
                <br/><br/>
                file <?php echo $view->dir; ?><b><?php echo $view->filename; ?></b>
                on line <b><?php echo $view->line; ?></b><br/><br/>
                <?php endif; ?>
            </div>
        </div>
    </div>
</div>

<a href="/">На главную</a>
