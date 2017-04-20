<?php

namespace Domain\News;

use Infrastructure\NewsRepository;
use App\Exceptions\EntityNotFoundException;
use App\Exceptions\ValidateException;

use Domain\Users\UsersService;

class NewsService {

    const SCENARIO_CREATE = 'create';
    const SCENARIO_UPDATE = 'update';

    /**
     * Создание новости.
     *
     * @param array $data Новость с трансляциями
     *
     * @return bool
     */
    public static function create($data) {

        self::validate($data, self::SCENARIO_CREATE);
        $item = NewsFactory::createItem();
        $item->setDate($data['date']);
        $item->setLangs($data['langs']);

        self::push($item);

        return true;
    }

    /**
     * Обновление новости.
     *
     * @param array $data Новость
     *
     * @return bool
     * @throws EntityNotFoundException
     * @throws ValidateException
     */
    public static function update($data) {

        self::validate($data, self::SCENARIO_UPDATE);

        $item = self::findById($data['id']);

        $item->setId($data['id']);
        $item->setDate($data['date']);
        $item->setLangs($data['langs']);

        foreach ($item->getLangs() as $lang) {
            self::findByIdAndLang($item->getId(), $lang->getLang());
        }
        self::push($item);

        return true;
    }

    /**
     * TODO: Сделать более гибкую систему валидации. Прикрутить https://github.com/Respect/Validation
     *
     * Validate data
     *
     * @param array  $data
     * @param string $scenario
     *
     * @throws ValidateException
     */
    public static function validate($data, $scenario) {

        if (empty($data)) {
            $errors['json'] = 'empty';
        } else {

            if (empty($data['date'])) {
                $errors['date'] = 'empty';
            } else {

                $date = new \DateTime($data['date']);
                if (strtotime($date->format(\DateTime::ATOM)) != strtotime($data['date'])) {
                    $errors['date'] = 'Wrong format!';
                }
            }

            foreach ($data['langs'] as $key => $value) {
                if (empty($value['title'])) {
                    $errors['title'] = 'empty';
                }
                if (empty($value['description'])) {
                    $errors['description'] = 'empty';
                }
            }

            if ($scenario == self::SCENARIO_UPDATE) {
                if (empty($data['id'])) {
                    $errors['id'] = 'empty';
                }
            }
        }
        if (!empty($errors)) {
            throw new ValidateException('Item', $errors);
        }
    }

    /**
     * Push to database
     *
     * @param Item $item
     */
    public static function push($item) {

        $newsRepository = new NewsRepository;

        if ($item->isExist()) {
            $newsRepository->update($item);
        } else {
            $newsRepository->insert($item);
        }
    }

    /**
     *
     * Получить одну новость по текущему языку или на всех языках
     *
     * @param $id
     * @param $lang
     *
     * @return Item $item
     * @throws EntityNotFoundException
     */
    public static function findOne($id, $lang = null) {

        if (is_null($lang)) {
            $item = self::findById($id);
        } else {
            $item = self::findByIdAndLang($id, $lang);
        }

        return $item;
    }

    /**
     *
     * Получить все новости согласно языку.
     *
     * @param string $lang Язык
     *
     * @return Item[] $news Массив новостей
     */
    public static function findAll($lang) {

        $newsRepository = new NewsRepository();
        $newsData = $newsRepository->findBy(['lang' => $lang]);

        $news = [];
        foreach ($newsData as $value) {
            $news[] = NewsFactory::createByData($value);
        }

        return $news;
    }

    /**     *
     * Удаление новости со всеми языками
     *
     * @param $id
     *
     * @return bool
     * @throws EntityNotFoundException
     */
    public static function deleteById($id) {

        $item = self::findById($id);

        $newsRepository = new NewsRepository();
        $newsRepository->deleteById($item->getId());
        return true;
    }

    /**
     * @param $id
     *
     * @return Item $item
     * @throws EntityNotFoundException
     */
    public static function findById($id) {

        $newRepository = new NewsRepository();
        $itemData = $newRepository->findBy(['id' => $id]);

        if (empty($itemData)) {
            throw new EntityNotFoundException('News', $id);
        }

        $item = NewsFactory::createByData($itemData[0]);

        return $item;
    }

    public static function findByIdAndLang($id, $lang) {

        $newRepository = new NewsRepository();
        $itemData = $newRepository->findBy(['id' => $id, 'lang' => $lang]);

        if (empty($itemData)) {
            throw new EntityNotFoundException('Item/Lang', $id . '/' . $lang);
        }
        $item = NewsFactory::createByData($itemData[0]);

        return $item;
    }

    /**
     * find all News
     *
     * @return array
     */
    public static function getAll() {

        $newsRepository = new NewsRepository;

        $items = $newsRepository->findBy(array('order' => array('date_c' => 'DESC')));
        foreach ($items as $i => $itemData) {

            $item = NewsFactory::createByData($itemData);

            $item->links = array();
            if (UsersService::checkAccess('News', 'delete')) {
                $item->links['удалить'] = '/news/delete/' . $item->getId();
            }
            if (UsersService::checkAccess('News', 'edit')) {
                $item->links['редактировать'] = '/news/edit/' . $item->getId();
            }

            $items[$i] = $item;
        }

        return $items;
    }

    /**
     * Restore Item by unique filters
     *
     * @param array $filters
     *
     * @throws EntityNotFoundException
     * @return Item
     */
    public static function findBy($filters) {

        $newsRepository = new NewsRepository;
        $itemData = $newsRepository->findOneBy($filters);

        if (empty($itemData)) {
            throw new EntityNotFoundException('Item', http_build_query($filters));
        }

        return NewsFactory::createByData($itemData);
    }
}