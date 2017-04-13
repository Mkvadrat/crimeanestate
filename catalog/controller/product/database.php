<?php
/**
 * Created by PhpStorm.
 * User: makaka
 * Date: 4/9/15
 * Time: 4:42 PM
 */

class ControllerProductDatabase extends Controller {
    public function index() {
        exit;

        $this->db->query("ALTER TABLE product ADD currency_id INT( 11 ) NOT NULL DEFAULT '2' AFTER price");

        $result = $this->db->query('describe product');

        foreach($result->rows as $row) {
            if (isset($row['Field'])) echo $row['Field'].' |';
        }
    }
}