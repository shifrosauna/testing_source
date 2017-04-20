<?php

namespace Http\Account;

use App\BaseController;
use App\Exceptions\EntityNotFoundException;
use Domain\News\NewsService;
use Domain\Users\UsersService;

class NewsController extends BaseController {

    /**
     * Получить все новости согласно языковой настройке
     *
     * Route: GET /news/index
     *
     * @return array $result Массив новостей
     * @throws EntityNotFoundException
     */

    public function listAction() {

        $lang = UsersService::current()->getLang();
        $news = NewsService::findAll($lang);

        $result =[];
        foreach ($news as $item) {
            $result[] = $item->output();
        }
        
        return $result;
    }

    /**
     * Получить новость со всеми языками. Для редактирования.
     *
     * Route: /news/edit/1
     *
     * @param int $id Id новости
     *
     * @return array $item Новость на всех языках
     * @throws EntityNotFoundException
     */
    public function editAction($id) {

        $item = NewsService::findOne($id);        

        return $item->output();
    }

    /**
     * Показать новость по Id для текущего языка.
     *
     * Route: GET /news/view/1
     *
     * @param int $id Id новости
     *
     * @return array $item Новость на текущем языке
     */
    public function viewAction($id) {

        $lang = UsersService::current()->getLang();
        $item = NewsService::findOne($id,$lang);

        return $item->output();
    }

    /**
     *  Api Для создания новости.
     *
     *  Поддерживает Мультиязычность в одном запросе.
     *
     *  Route: POST /news/create
     *
     * @return bool
     */

    public function createAction() {

        $data = $this->request->input();
        NewsService::create($data);

        return true;
    }

    /**
     * Api для обновление новостей
     *
     * Route: POST /news/update
     *
     * @return bool
     */
    public function updateAction() {

        $data = $this->request->input();
        NewsService::update($data);

        return true;
    }

    /**
     * Удаление новости со всеми переводами.
     *
     * Route: /news/delete/1
     *
     * @param int $id Id новости
     *
     * @return bool
     */
    public function deleteAction($id) {

        NewsService::deleteById($id);

        return true;
    }

    /**
     *  Other (unsorted)
     */

    public function receivedAction() {

        if (!$this->user->access('news/received')) {
            $this->redirect('/news');
        }

        $this->view->news = $this->news->getReceived();
        $this->view->currentTab = 'received';
        $this->view->tabs = $this->getView('news/tabs');
        $this->view->content = $this->getView('news/received');
        $this->output = $this->getView('index');

        $this->outputPage();
    }

    public function queueAction($id = null) {

        $error = array();

        if (!$this->user->access('news/send')) {
            $this->redirect('/news');
        }

        if (empty($id)) {
            $this->redirect('/news?error=wrongParams');
        }

        $new = $this->news->findById(intval($id));

        if (empty($new)) {
            $this->redirect('/news?error=notFound');
        }

        if ($new->sent) {
            $this->redirect('/news?error=already_sent');
        }

        $queue = $this->news->inQueue($id);
        if (!empty($queue) && !empty($queue)) {
            $this->view->error = 'Внимание! Новость уже находится в очереди на рассылку. Вы можете изменить дату отправки.';
        }

        $new->date_s = (!empty($queue) && !empty($queue->date_s)) ? substr($queue->date_s, 0, 16) : date("Y-m-d H:i");

        $this->view->title = 'Разослать новость';
        $this->view->current = $new;
        $this->view->currentPage = 'news';
        $this->view->content = $this->getView('news/send');
        $this->output = $this->getView('index');

        $this->outputPage();
    }

    public function queuesaveAction() {

        if (!$this->user->access('news/send')) {
            $this->redirect('/news?error=access_denied');
        }

        if (empty($_POST['id']) || empty($_POST['send_time'])) {
            $this->redirect('/news?error=wrongParams');
        }

        $id = intval($_POST['id']);
        $send_time = $_POST['send_time'];

        $new = $this->news->findById($id);

        if ($new->sent) {
            $this->redirect('/news?error=already_sent');
        }

        $in_queue = $this->news->inQueue($id);
        if ($in_queue) {
            $this->news->updateQueue($id, $send_time);
        } else {
            $this->news->addToQueue($id, $send_time);
        }

        $this->log('news', 'queue #' . $id . ' by #' . $this->user->id . ' - date_s:' . $send_time);

        $this->redirect('/news?result=sent_queue');
    }

    public function rssAction($lang = 'ru') {

        if (empty($lang)) {
            $lang = 'ru';
        }

        $language = ($lang == 'ru') ? 'ru' : 'en-us';

        $output = '<?xml version="1.0"?>';
        $output .= '<rss version="2.0">';
        $output .= '<channel>';
        $output .= '<title>Новости MobiOffers.ru</title>';
        $output .= '<link>http://account.mobioffers.ru/news</link>';
        $output .= '<description>Новости сайта MobiOffers.ru</description>';
        $output .= '<language>' . $language . '</language>';

        $news = $this->news->rss($lang);
        foreach ($news as $new) {

            $output .= '<item>';
            $output .= '<title>' . $new->title . '</title>';
            $output .= '<link>http://account.mobioffers.ru/news/view/' . $new->id . '</link>';
            $output .= '<description><![CDATA[' . $new->description . ']]></description>';
            $output .= '<pubDate>' . $new->date . '</pubDate>';
            $output .= '</item>';
        }

        $output .= '</channel></rss>';

        header('Content-Type: text/xml; charset=utf-8');
        echo $output;
        exit;
    }
}