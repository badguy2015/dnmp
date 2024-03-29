<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
    <title>Document</title>
</head>
<body>

<p>you are in phpContainer:"/demo/vhost/index.php";<br/>if you can't see phpinfo(),that the php is not work!</p>
<br/>click [<a href="/php56.php">php56.php</a>],[<a href="/php74.php">php74.php</a>] to test the different php version;
<hr />
<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

echo '<h1 style="text-align: center;">欢迎使用DNMP！</h1>';
echo '<h2>版本信息</h2>';

echo '<ul>';
echo '<li>Server IP：', $_SERVER['SERVER_ADDR'], '</li>';
echo '<li>PHP版本：', PHP_VERSION, '</li>';
echo '<li>Nginx版本：', $_SERVER['SERVER_SOFTWARE'], '</li>';
//echo '<li>MariaDB服务器版本：', getMysqlVersion(), '</li>';
//echo '<li>MariaDB服务器数据库列表：', getMysqlDatabases(), '</li>';
//echo '<li>Redis服务器版本：', getRedisVersion(), '</li>';
//echo '<li>MongoDB服务器版本：', getMongoVersion(), '</li>';
echo '</ul>';

echo '<h2>已安装扩展</h2>';
printExtensions();
echo "<hr/>";
phpinfo();

/**
 * 获取MySQL版本
 */
function getMysqlVersion()
{
    if (extension_loaded('mysqli')) {
        try {
            $mysqli = new mysqli('mariadb', 'root', '123456', 'mysql', '3306');
            $sth = $mysqli->query('SELECT VERSION() as version');
            $row = $sth->fetch_row();
            $info = current((array)$row);
        } catch (PDOException $e) {
            return $e->getMessage();
        }
        return $info;
    }else{
        return 'mysqli 扩展未安装 ×';
    }



}

/**
 * 获取MySQL版本
 */
function getMysqlDatabases()
{
    if (extension_loaded('mysqli')) {
        $arr = [];
        try {
            $mysqli = new mysqli('mariadb', 'root', '123456', 'mysql', '3306');
            $sth = $mysqli->query('SHOW DATABASES');
            while($row = $sth->fetch_row()){
                $arr[] = $row;
            }
        } catch (PDOException $e) {
            return $e->getMessage();
        }
        $str = '';
        foreach ($arr as $v){
            $str .= ','.current(($v));
        }
        $str = ltrim($str,',');
        return $str;
    }else{
        return 'mysqli 扩展未安装 ×';
    }

}

/**
 * 获取Redis版本
 */
function getRedisVersion()
{
    if (extension_loaded('redis')) {
        try {
            $redis = new Redis();
            $redis->connect('redis', 6379);
            $info = $redis->info();
            return $info['redis_version'];
        } catch (Exception $e) {
            return $e->getMessage();
        }
    } else {
        return 'Redis 扩展未安装 ×';
    }
}

/**
 * 获取MongoDB版本
 */
function getMongoVersion()
{
    if (extension_loaded('mongodb')) {
        try {
            $manager = new MongoDB\Driver\Manager('mongodb://root:123456@mongodb:27017');
            $command = new MongoDB\Driver\Command(array('serverStatus'=>true));

            $cursor = $manager->executeCommand('admin', $command);

            return $cursor->toArray()[0]->version;
        } catch (Exception $e) {
            return $e->getMessage();
        }
    } else {
        return 'MongoDB 扩展未安装 ×';
    }
}

/**
 * 获取已安装扩展列表
 */
function printExtensions()
{
    echo '<ol>';
    foreach (get_loaded_extensions() as $i => $name) {
        echo "<li>", $name, '=', phpversion($name), '</li>';
    }
    echo '</ol>';
}
?>
</body>
</html>