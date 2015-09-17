<?php

define('DATABASE_SGBD', 'mysql');

define('DB_LOCALHOST', 'localhost');
define('DB_LOCALUSER', 'root');
define('DB_LOCALDATABASE', 'db');
define('DB_LOCALPWD', 's3cret');
define('DB_LOCALPORT', '3306');


class DatabaseController {

    private static $db;

    public static function getDb() {
        try {
                self::$db = new PDO('mysql:host=' . DB_LOCALHOST . ';port=' . DB_LOCALPORT . ';dbname=' . DB_LOCALDATABASE, DB_LOCALUSER, DB_LOCALPWD, array(PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION, PDO::ATTR_EMULATE_PREPARES => false));
            self::$db->exec("set names utf8");
            return self::$db;
        } catch (PDOException $e) {
            header('HTTP/1.1 500 Internal Server Error');
            die(json_encode(array('code' => '500', 'error' => $e->getMessage())));
        }
    }

    public static function closeConn() {
        try {
            self::$db = null;
        } catch (Exception $e) {
            header('HTTP/1.1 500 Internal Server Error');
            die(json_encode(array('code' => '500', 'error' => $e->getMessage())));
        }
    }
}
$connexion = DatabaseController::getDb();
echo "<h1>Connection to Database successful</h1>";

phpinfo();
