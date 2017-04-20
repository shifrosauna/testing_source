<div class="options-one" style="width:100%; float:left; margin-bottom:20px; <?php echo (false && !empty($view->currentPage) && $view->currentPage == 'payments') ? 'margin-top:-10px;' : ''; ?>">
    <div style="width:100%; float:left; color:grey; font-size:12px; text-align: left; line-height:16px">
    <?php if ($view->user->block): ?>
        <p style="color:black">Аккаунт заблокирован за нарушения правил</p>
    <?php elseif (!empty($view->user->wmr) || $view->user->wmr_check): ?>
        <p style="color:black">Ваш кошелек: <span style="color:#EE678C"><?php echo $view->user->wmr; ?></span></p>
        Изменение номера кошелька осуществляется по запросу на support@mobioffers.ru
    <?php elseif(!empty($view->user->date_u)): ?>
        Вами был указан некорректный номер WMR-кошелька. Заработанные средства заморожены на Вашем балансе до решения проблемы.
        Для изменения номера кошелька отправьте заявку на support@mobioffers.ru
    <?php else: ?>
        <p style="color:black">Ваш кошелек: <span style="color:#EE678C">В обработке</span></p>
    <?php endif; ?>
    </div>
</div>