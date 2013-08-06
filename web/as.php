<?php
header("Content-type: text/html; charset=utf-8");
header("Cache-Control: no-store, no-cache, must-revalidate");
header("Cache-Control: post-check=0, pre-check=0", false);
header("Expires: -1"); 

// include mylib.php (contains Logging class)
try
{
include('mylib.php');
include('config.inc.php');

// Logging class initialization
$log = new Logging();

// set path and name of log file (optional)
$log->lfile('mylog.txt');

// write message to the log file
$log->lwrite("AddStick php called");
}
catch(Exception $e)
  {
  echo $e->getMessage();
  #$log->lwrite(print_r('Message: ' .$e->getMessage(), true));
  }
try
{
    $hashtag = $_POST["hashtag"];
    $text = $_POST["text"];
    $title = $_POST["title"];
    $x = $_POST["x"];
    $y = $_POST["y"];
    if ($hashtag=="" || $hashtag==null || $text=="" || $text==null) {
        echo 'Empty hashtag or text';
        $log->lwrite('Empty hashtag or text');
        return;
    }
    $con = mysql_connect($dbhost, $dblogin, $dbpass);
    if (!$con)
      {
      die('Could not connect: ' . mysql_error());
    // close log file
    $log->lwrite('Could not connect: ' . mysql_error());
    $log->lclose();
      }

    mysql_select_db($dbname, $con);
    $hashtag = mysql_real_escape_string($hashtag);
    $text = mysql_real_escape_string($text);
    $title = mysql_real_escape_string($title);
    $addsql="insert into ".$plans." (hashtag, text, title, x, y) values ('".$hashtag."', '".$text."', '".$title."', ".$x.", ".$y.")";
    $log->lwrite("hashtag=".$hashtag."text=".$text."\nsql=".$addsql);
    $result = mysql_query($addsql);


#$result = mysql_query($sql);
if (!$result) {
    $log->lwrite("result: ".$result." ; Error: ".mysql_error());
    echo "result: ".$result." ; Error: ".mysql_error();
    #die('Invalid query: ' . mysql_error());
} else {
    $result = mysql_query("SELECT LAST_INSERT_ID()");
    $mysres = mysql_result($result, 0, 0);
    echo $mysres;
    $log->lwrite($mysres);
    
    $log->lwrite("Executed successfully. Yahoo!");
}
    
}
catch(Exception $e)
  {
  $log->lwrite(print_r('Message: ' .$e->getMessage(), true));
  }
$log->lclose();

?>