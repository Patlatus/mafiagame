<?php
include('config.inc.php');
include('mylib.php');
$log = new Logging();

// set path and name of log file (optional)
$log->lfile('mylog.txt');

// write message to the log file
$log->lwrite("AddStick php called");

$con = mysql_connect($dbhost, $dblogin, $dbpass);
    if (!$con)
      {
      die('Could not connect: ' . mysql_error());
    // close log file
    $log->lwrite('Could not connect: ' . mysql_error());
    $log->lclose();
      }
	  $log->lwrite('Try to select db: ' . $dbname);
mysql_select_db($dbname, $con);

session_start();
header('Content-type: text/html;charset=UTF-8');
if(!isset($_SESSION['username']) and isset($_COOKIE['planssiteusername'], $_COOKIE['planssitepassword']))
{
	$cnn = mysql_query('select password,id from users where username="'.mysql_real_escape_string($_COOKIE['planssiteusername']).'"');
	$dn_cnn = mysql_fetch_array($cnn);
	if(sha1($dn_cnn['password'])==$_COOKIE['planssitepassword'] and mysql_num_rows($cnn)>0)
	{
		$_SESSION['username'] = $_COOKIE['planssiteusername'];
		$_SESSION['userid'] = $dn_cnn['id'];
	}
}
?>