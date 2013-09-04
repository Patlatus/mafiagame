<?php
header("Content-type: text/html; charset=utf-8");
header("Cache-Control: no-store, no-cache, must-revalidate");
header("Cache-Control: post-check=0, pre-check=0", false);
header("Expires: -1"); 

// include mylib.php (contains Logging class)
try {
    include('mylib.php');
    include('config.inc.php');

    // Logging class initialization
    $log = new Logging();

    // set path and name of log file (optional)
    $log->lfile('mylog.txt');

    // write message to the log file
    $log->lwrite("Add new predefined game");
}
catch (Exception $e) {
    echo $e->getMessage();
    $log->lwrite(print_r('Message: ' .$e->getMessage(), true));
}
try {
    $userid = $_POST["user"];
    $gameid = $_POST["gameid"];
    $username = $_POST["username"];
    
    $con = mysql_connect($dbhost, $dblogin, $dbpass);
    if (!$con) {
        die('Could not connect: ' . mysql_error());
        // close log file
        $log->lwrite('Could not connect: ' . mysql_error());
        $log->lclose();
    }

    mysql_select_db($dbname, $con);
    $username = mysql_real_escape_string($username);
    $addsql="insert into ".$pg." (userid, username, gameid, time, status) values ('".$userid."', '".$username."', '".$gameid."', ".time().", 'on record')";
    $log->lwrite("userid=".$userid."username=".$username."gameid=".$gameid."\nsql=".$addsql);
    $result = mysql_query($addsql);


    if (!$result) {
        $log->lwrite("result: ".$result." ; Error: ".mysql_error());
        echo "result: ".$result." ; Error: ".mysql_error();
        #die('Invalid query: ' . mysql_error());
    } else {
        $result = mysql_query("SELECT LAST_INSERT_ID()");
        $mysres = mysql_result($result, 0, 0);
        echo $mysres;
        $log->lwrite($mysres);
        $log->lwrite("First sql executed successfully. Yahoo!");
        $addsql="insert into ".$pl." (userid, username, gameid, time) values ('".$userid."', '".$username."', '".$mysres."', ".time().")";
        $log->lwrite("userid=".$userid."username=".$username."gameid=".$mysres."\nsql=".$addsql);
        $result = mysql_query($addsql);
        if (!$result) {
            $log->lwrite("result: ".$result." ; Error: ".mysql_error());
            echo "result: ".$result." ; Error: ".mysql_error();
            #die('Invalid query: ' . mysql_error());
        } else {
            $log->lwrite("Second sql executed successfully. Yahoo!");
        }

    }
}
catch (Exception $e) {
    $log->lwrite(print_r('Message: ' .$e->getMessage(), true));
}
$log->lclose();

?>