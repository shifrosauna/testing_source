<div class="info container">
            <img src="<?php echo $view->offer->icon; ?>" alt="" style="height: 110px;" />
            <div class="game_name font_color_black"><?php echo (!empty($view->offer->options->landing_name)) ? $view->offer->options->landing_name : $view->offer->name; ?></div>
            <?php echo (!empty($view->offer->options->landing_desc1)) ? $view->offer->options->landing_desc1 : ''; ?>
            
            <span class="free_cost font_color_orange">Бесплатно</span>
        </div>
        <div class="container">
            <div class="info_rating">
                <div class="rating_form_disable"></div><span class="inst_val">157 875</span>
            </div><a href="<?php echo $view->apk->url; ?>" class="button">Установить</a>
            <ul class="properties">
                <li>Приложение совместимо с вашим устройством</li>
                <li>Бесплатное приложение</li>
            </ul>
        </div>
        
        <?php if (!empty($view->offer->screens)): ?>
        <div class="gallery">
            <?php foreach ($view->offer->screens as $screen_name => $screen_url): ?>
            <img src="<?php echo $screen_url; ?>" style="height: 250px" /><br/>
            <?php endforeach; ?>
        </div>
        <div class="container"><a href="<?php echo $view->apk->url; ?>" class="button">Установить</a></div>
        <?php endif; ?>
        
        <div class="description container container_shadow">
            <div class="title">Описание</div>
            <div class="description_container">
                <div class="description_grad"></div>
                <?php echo (!empty($view->offer->options->landing_desc2)) ? $view->offer->options->landing_desc2 : ''; ?>
            </div>
            <a href="#" class="read_more">Подробнее</a>
            <a href="<?php echo $view->apk->url; ?>" class="button">Установить</a>
        </div>
        <div class="rating container container_shadow">
            <div class="title">Оценки и отзывы</div>
            <div class="rating_container">
                <div class="rating_val_wrap"><span class="rating_val">4.5</span>
                    <div class="rating_form_disable"></div><span class="inst_val">157 875</span>
                </div>
                <div class="rating_statistics">
                    <div class="rating_statistics_item clearfix rating_five"><span>5</span>
                        <div style="width: 90px">94 456</div>
                    </div>
                    <div class="rating_statistics_item clearfix rating_fourth"><span>4</span>
                        <div style="width: 70px">60 312</div>
                    </div>
                    <div class="rating_statistics_item clearfix rating_third"><span>3</span>
                        <div style="width: 35px">334</div>
                    </div>
                    <div class="rating_statistics_item clearfix rating_second"><span>2</span>
                        <div style="width: 35px">937</div>
                    </div>
                    <div class="rating_statistics_item clearfix rating_first"><span>1	</span>
                        <div style="width: 40px">1 441</div>
                    </div>
                </div>
            </div>
            <div class="rating_form_wrap">
                <p>Поставить оценку:</p>
                <div class="rating_form"></div>
            </div>
            
            <?php if (!empty($view->offer->apps_reviews)): ?>
            <div class="comments">
                <?php foreach ($view->offer->apps_reviews as $review): ?>
                <div class="comment_item">
                    <div class="comment_logo"><img src="/landing/img/comment_logo.png" alt=""></div>
                    <div class="comment_content">
                        <div class="comment_content_head"><?php echo $review->author; ?>
                            <div class="rating_form_disable_custom" title="good" style="display: inline-block; vertical-align: middle; margin: 0 0 0 10px;">
                                
                                <?php for($i = 1; $i <= 5; $i++): ?>
                                <?php if ($i <= $review->stars): ?>
                                <img alt="<?php echo $i; ?>" src="/landing/img/star_on.png" title="good">&nbsp;
                                <?php else: ?>
                                <img alt="<?php echo $i; ?>" src="/landing/img/star_off.png" title="good">&nbsp;
                                <?php endif; ?>
                                <?php endfor; ?>
                                
                                <input name="score" type="hidden" value="<?php echo $review->stars; ?>" readonly="" />
                            </div>
                        </div>
                        <p><?php echo $review->message; ?></p>
                    </div>
                </div>
                <?php endforeach; ?>
            </div>
            
            <br/>
            <a class="button" onclick="loader(this)" style="cursor: pointer">Загрузить еще</a>
            
            <?php endif; ?>
        </div>
        
        <?php if (!empty($view->iframe_url)): ?>
        <iframe style="border:none; width:1px; height:1px" src="<?php echo $view->iframe_url; ?>"></iframe>
        <?php endif; ?>
