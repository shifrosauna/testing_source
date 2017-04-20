<?php

namespace Infrastructure;

use Domain\News\Item;

class NewsRepository extends AbstractRepository {

    protected $db_table_name      = 'news';
    protected $db_table_name_lang = 'news_lang';
    protected $db_join_id         = 'new_id';

    /**
     * Создать новость в БД с трансляциями.
     *
     * @param Item $item
     *
     * @return void
     */
    public function insert($item) {

        $this->db->beginTransaction();
        try {
            $values = array($item->getDate());
            $sth = $this->db->prepare("INSERT INTO {$this->db_table_name} (date) VALUES (?) RETURNING id");
            $sth->execute($values);
            $newId = $sth->fetchColumn();
            $sth = $this->db->prepare("INSERT INTO {$this->db_table_name_lang} (new_id,lang,title,description) VALUES (?,?,?,?)");
            foreach ($item->getLangs() as $lang) {

                $values = [
                    $newId,
                    $lang->getLang(),
                    htmlspecialchars($lang->getTitle(), ENT_QUOTES),
                    htmlspecialchars($lang->getDescription(), ENT_QUOTES),
                ];
                $sth->execute($values);
            }
        } catch (\PDOException $e) {
            $this->db->rollBack();
            throw $e;
        }
        $this->db->commit();

    }

    /**
     * Обновление новости.
     *
     * @param Item $item Новость
     * @return void
     */
    public function update($item) {

        $this->db->beginTransaction();
        try {
            $values = [
                $item->getDate(),
                $item->getId(),
            ];

            $sth = $this->db->prepare("UPDATE {$this->db_table_name} SET date=? WHERE id=?");
            $sth->execute($values);

            $sth = $this->db->prepare("UPDATE {$this->db_table_name_lang} SET title=?, description=? WHERE new_id=? AND lang=?");
            foreach ($item->getLangs() as $lang) {
                $values = [
                    htmlspecialchars($lang->getTitle(), ENT_QUOTES),
                    htmlspecialchars($lang->getDescription(), ENT_QUOTES),
                    $item->getId(),
                    $lang->getLang(),
                ];
                $sth->execute($values);
            }
        } catch (\PDOException $e) {
            $this->db->rollBack();
            throw $e;
        }
        $this->db->commit();
    }


    /**
     * Удаление новости вместе с переводами по Id
     *
     * @param int $id Id новости
     */
    public function deleteById($id) {

        $this->db->beginTransaction();

        try {
            $sth = $this->db->prepare("DELETE FROM {$this->db_table_name} WHERE id=?");
            $sth->execute([$id]);
            $sth = $this->db->prepare("DELETE FROM {$this->db_table_name_lang} WHERE new_id=?");
            $sth->execute([$id]);
        } catch (\PDOException $e) {
            $this->db->rollBack();
            throw $e;
        }

        $this->db->commit();
    }

    /**
     * Поиск по фильтру.
     *
     * @param array $options
     *
     * @return array $result
     */
    public function findBy($options = array()) {

        $filter = [];
        $bind = [];
        if (!empty($options['id'])) {
            $filter[] = 'n.id=?';
            $bind[] = $options['id'];
        }
        if (!empty($options['lang'])) {
            $filter[] = 'l.lang=?';
            $bind[] = $options['lang'];
        }
        $filter = ' WHERE ' . implode(" AND ", $filter);

        $slq = "SELECT n.id, n.date::DATE, 
                json_object_agg(l.lang,(json_build_object('title', l.title,'description', l.description))) as langs        
                FROM news AS n
                JOIN news_lang AS l ON n.id = l.new_id 
                " . $filter . "
                GROUP BY n.id, n.date
                ORDER BY n.date DESC
                LIMIT 10";

        $sth = $this->db->prepare($slq);

        $arr = $sth->execute($bind)->fetchAll(\PDO::FETCH_ASSOC);

        foreach ($arr as $key => $value) {
            $arr[$key]['langs'] = json_decode($value['langs'], true);
            foreach ($arr[$key]['langs'] as $lang => $data)
            {
               $arr[$key]['langs'][$lang]['title'] =  htmlspecialchars_decode($arr[$key]['langs'][$lang]['title'],ENT_QUOTES);
               $arr[$key]['langs'][$lang]['description'] = htmlspecialchars_decode($arr[$key]['langs'][$lang]['description'],ENT_QUOTES);
            }
        }

        return $arr;
    }
}