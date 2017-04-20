<div class="lang" style="position: absolute; top: 39px; right: 0;">
    <?php if ($view->lang == 'en'): ?>
    <a style="padding:3px"><img src="/img/en.png" alt="en"></a>
    <?php else: ?>
    <a href="/lang/en" style="padding:3px; opacity:0.5;"><img src="/img/en.png" alt="en"></a>
    <?php endif; ?>
    
    <?php if ($view->lang == 'ru'): ?>
    <a style="padding:3px"><img src="/img/ru.png" alt="ru"></a>
    <?php else: ?>
    <a href="/lang/ru" style="padding:3px; opacity:0.5;"><img src="/img/ru.png" alt="ru"></a>
    <?php endif; ?>
</div>