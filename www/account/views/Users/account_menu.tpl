<!--ul class="nav navbar-top-links navbar-right">
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                        <i class="fa fa-user fa-fw"></i>  <i class="fa fa-caret-down"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-user">
                        <?php /*foreach ($view->account_menu as $item): ?>
                        <li>
                            <a href="<?php echo $item->url; ?>"><?php echo (!empty($item->icon)) ? '<i class="fa '. $item->icon .' fa-fw"></i> ' : ''; ?><?php echo $item->title; ?></a>
                        </li>
                        <?php endforeach;*/ ?>
                    </ul>
                </li>
            </ul-->


<div style="float:right; padding:0; margin:15px 35px 0px 70px;">
    <a href="/profile"><?php echo $view->user->getLogin(); ?></a>
    <a> | </a>
    <a href="/logout">Выход</a>
</div>