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
    $id = $_POST["id"];
    if ($id=="" || $id==null) {
        echo 'Empty id';
        $log->lwrite('Empty id');
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
    $removesql="delete from ".$plans." where id = '".$id."'";
    $log->lwrite("id=".$id."\nsql=".$removesql);
    $result = mysql_query($removesql);


#$result = mysql_query($sql);
if (!$result) {
    $log->lwrite("result: ".$result." ; Error: ".mysql_error());
    echo "result: ".$result." ; Error: ".mysql_error();
    #die('Invalid query: ' . mysql_error());
} else {
    $log->lwrite("Executed successfully. Yahoo!");
}
    
}
catch(Exception $e)
  {
  $log->lwrite(print_r('Message: ' .$e->getMessage(), true));
  }
$log->lclose();

?>