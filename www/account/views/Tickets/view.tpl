<script type="text/javascript">
    
    $(document).ready(function(){
        
        var form = new Form(
            '#tickets-comment-form',
            {
                'description': ['required']
            }
        );
        
        form.init();
    });
</script>

<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                <?php echo $view->ticket->owner_name; ?>
                <span class="pull-right"><?php echo $this->toDatetime($view->ticket->date_c); ?></span>
            </div>
            <div class="panel-body">
                <div class="row">
                    <div class="col-lg-6">
                        <?php echo $view->ticket->description; ?>
                        
                    </div>
                </div>
            </div>
        </div>
        
        <div class="panel panel-default">
            <div class="panel-heading">
                <?php echo $view->user_name; ?> <img src="/img/loader.gif" id="tickets-comment-form-loader" class="form-loader" />
            </div>
            <div class="panel-body">
                
                <div id="tickets-comment-form-info-bar" class="alert form-info-bar"></div>
                
                <div class="row">
                    <div class="col-lg-6">
                        <form action="/tickets/comment" id="tickets-comment-form" role="form" method="POST">
                            
                            <input type="hidden" name="ticket_id" value="<?php echo $view->ticket->id; ?>" />
                            
                            <div class="form-group">
                                <textarea name="description" id="description" class="form-control" rows="5"></textarea>
                                <p class="form-control-static caption-error" id="caption-description"></p>
                            </div>
                            
                            <button type="submit" class="btn btn-default">Отправить</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>