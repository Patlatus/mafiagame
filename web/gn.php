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
$log->lwrite("getNotes php called");
}
catch(Exception $e)
  {
  echo $e->getMessage();
  #$log->lwrite(print_r('Message: ' .$e->getMessage(), true));
  }
  
$hashtag = $_POST["hashtag"];
if ($hashtag=="" || $hashtag==null) {
    $hashtag = $_GET["hashtag"];
	$log->lwrite('Empty POST, trying to get GET, $hashtag= '.$hashtag);
}
if ($hashtag=="" || $hashtag==null) {
        echo 'Empty hashtag, cannot execute query';
        $log->lwrite('Empty hashtag, cannot execute query');
        return;
    }
$con = mysql_connect($dbhost, $dblogin, $dbpass);
if (!$con)
  {
  die('Could not connect: ' . mysql_error());
  }

mysql_select_db($dbname, $con);

$sql="SELECT * FROM ".$plans." WHERE hashtag = '".$hashtag."'";
$log->lwrite("hashtag=".$hashtag."\nsql=".$sql);
$result = mysql_query($sql);
$log->lwrite($result);
$log->lwrite("result=".print_r($result,true));
echo "[";
if($row = mysql_fetch_array($result))
  {
  echo "{text:'" . $row['text'] . "',id:'" . $row['id'] . "',hashtag:'" . $row['hashtag'] . "',title:'" . $row['title'] . "',x:'" . $row['x']  . "',y:'" . $row['y']  . "'}";
  }
while($row = mysql_fetch_array($result))
  {
  echo ",{text:'" . $row['text'] . "',id:'" . $row['id'] . "',hashtag:'" . $row['hashtag'] . "',title:'" . $row['title'] . "',x:'" . $row['x']  . "',y:'" . $row['y'] . "'}";
  }
echo "]";

mysql_close($con);
?>