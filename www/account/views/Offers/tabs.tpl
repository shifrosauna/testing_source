<ul class="nav nav-tabs">
<?php if (!empty($view->offer->options->return_type) && $view->offer->options->return_type == 'arc'): ?>

    <li <?php echo ($view->current_tab == 'arc') ? 'class="active"' : ''; ?>><a href="/offers/arc_view/<?php echo $view->arc->id; ?>">Архив</a></li>
    <li <?php echo ($view->current_tab == 'view') ? 'class="active"' : ''; ?>><a href="/offers/view/<?php echo $view->offer->id; ?>" >Просмотр</a></li>
    <li <?php echo ($view->current_tab == 'edit') ? 'class="active"' : ''; ?>><a href="/offers/arc_edit/<?php echo $view->offer->id; ?>">Редактировать</a></li>
    <li <?php echo ($view->current_tab == 'access') ? 'class="active"' : ''; ?>><a href="/offers/access/<?php echo $view->offer->id; ?>">Доступ</a></li></li>

<?php elseif (!empty($view->offer->options->return_type) && $view->offer->options->return_type == 'multiple'): ?>

    <li <?php echo ($view->current_tab == 'multiple') ? 'class="active"' : ''; ?>><a href="/offers/multiple_view/<?php echo $view->offer->id; ?>">Приложения</a></li>
    <li <?php echo ($view->current_tab == 'view') ? 'class="active"' : ''; ?>><a href="/offers/view/<?php echo $view->offer->id; ?>" >Просмотр</a></li>
    <li <?php echo ($view->current_tab == 'access') ? 'class="active"' : ''; ?>><a href="/offers/access/<?php echo $view->offer->id; ?>">Доступ</a></li></li>

<?php else: ?>
    
    <li <?php echo ($view->current_tab == 'view') ? 'class="active"' : ''; ?>><a href="/offers/view/<?php echo $view->offer->id; ?>" >Просмотр</a></li>
    <li <?php echo ($view->current_tab == 'edit') ? 'class="active"' : ''; ?>><a href="/offers/edit/<?php echo $view->offer->id; ?>" >Редактировать</a></li>
    <li <?php echo ($view->current_tab == 'access') ? 'class="active"' : ''; ?>><a href="/offers/access/<?php echo $view->offer->id; ?>">Доступ</a></li></li>

<?php endif; ?>
</ul>
<br/>