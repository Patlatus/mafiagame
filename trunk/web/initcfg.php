<?php
include('config.inc.php');
include('mylib.php');
$log = new Logging();

// set path and name of log file (optional)
$log->lfile('mylog.txt');

// write message to the log file
$log->lwrite("Initializing php called");

function updateLastActivity($lg) {
    $sql = 'update users set last_activity = '.time().' where id = '.$_SESSION['userid'];
    $lg->lwrite('sql='.$sql);
    if (mysql_query($sql)) {
        $lg->lwrite('Sql, success:true');
    } else {
        $lg->lwrite('Sql has failed: '.$sql);
    }
};

function updateUser($lg, $status) {
    $sql = 'update users set status = '.$status.' where id = '.$_SESSION['userid'];
    $lg->lwrite('sql='.$sql);
    if (mysql_query($sql)) {
        $lg->lwrite('Sql, success:true');
    } else {
        $lg->lwrite('Sql has failed: '.$sql);
    }
    updateLastActivity($lg);
};

function auditEvent($lg, $userid, $username, $event, $language) {
    $sql = "insert into auditlog(userid, username, event, time, language) values (".$userid.', "'.$username.'", "'.$event.'", '.time().', "'.$language.'")';
    $lg->lwrite('sql='.$sql);
    if (mysql_query($sql)) {
        $lg->lwrite('Sql, success:true');
    } else {
        $lg->lwrite('Sql has failed: '.$sql);
    }
};

function auditFailedLogin($lg, $username, $password, $language) {
    $sql = "insert into failedlogins(name, password, time, language) values ('".$username."', '".$password."',".time().', "'.$language.'")';
    $lg->lwrite('sql='.$sql);
    if (mysql_query($sql)) {
        $lg->lwrite('Sql, success:true');
    } else {
        $lg->lwrite('Sql has failed: '.$sql);
    }
}

function auditFailedSignup($lg, $username, $password, $passver, $email, $language) {
    $sql = "insert into failedsignups(name, password, passver, email, time, language) values ('".$username."', '".$password."', '".$passver."', '".$email."',".time().', "'.$language.'")';
    $lg->lwrite('sql='.$sql);
    if (mysql_query($sql)) {
        $lg->lwrite('Sql, success:true');
    } else {
        $lg->lwrite('Sql has failed: '.$sql);
    }
}

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
?>