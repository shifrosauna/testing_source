
<!--li class="sidebar-search">
    <div class="input-group custom-search-form">
        <input type="text" class="form-control" placeholder="Search...">
        <span class="input-group-btn">
        <button class="btn btn-default" type="button">
            <i class="fa fa-search"></i>
        </button>
    </span>
    </div>
</li-->

<!--li>
    <a href="/"><i class="fa fa-dashboard fa-fw"></i> Dashboard</a>
</li-->

<?php foreach ($view->main_menu_items as $item): ?>
<li>
    <a href="<?php echo $item->url; ?>"><?php echo (!empty($item->icon)) ? '<i class="fa '. $item->icon .' fa-fw"></i> ' : ''; ?><?php echo $item->title; ?><?php echo (!empty($item->childs)) ? '<span class="fa arrow"></span>' : ''; ?></a>
    
    <?php if (!empty($item->childs)): ?>
    <ul class="nav nav-second-level">
        <?php foreach ($item->childs as $child): ?>
        <li><a href="<?php echo $child->url; ?>"><?php echo $child->title; ?></a></li>
        <?php endforeach; ?>
    </ul>
    <?php endif; ?>
</li>
<?php endforeach; ?>