<div style="float:left; padding:0; margin:15px 0 0px 70px;" class="balance-header">
    <span>Баланс:</span>    <span class="nav-show-prices-orange"><strong><?php echo (!empty($view->user->finance->total)) ? $view->user->finance->total : 0; ?></strong> $</span> &nbsp;
    <span>К выплате:</span> <span class="nav-show-prices-orange"><strong><?php echo (!empty($view->user->finance->to_payment)) ? $view->user->finance->to_payment : 0; ?></strong> $</span> &nbsp;
</div>