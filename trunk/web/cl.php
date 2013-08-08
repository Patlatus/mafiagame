<?php
    include('initcfg.php');
    if (!isset($_SESSION['userid'])) {
        $_SESSION['userid'] = -1;
    }
    auditEvent($log, $_SESSION['userid'], $_SESSION['username'], "open", $_SESSION['language']);
    if (isset($_SESSION['username'])) {
        $log->lwrite('Session user is logged.');
        updateUser($log, 1);
        auditEvent($log, $_SESSION['userid'], $_SESSION['username'], "login", $_SESSION['language']);
        echo "{success:true,username:'".$_SESSION['username']."',userid:'".$_SESSION['userid']."',message:'You are logged.'}";
    } else {
        if ((isset($_COOKIE["julfysoft_username"])) && (isset($_COOKIE["julfysoft_password"]))) {
            $log->lwrite('Cookie user is logged.');
            $username = $_COOKIE["julfysoft_username"];
            $req = mysql_query('select password,id from users where username="'.$username.'"');
            $dn = mysql_fetch_array($req);
            if ($dn['password'] == $_COOKIE["julfysoft_password"] and mysql_num_rows($req) > 0) {
                $log->lwrite('Cookie user is logged. Setting session username to '.$username.' and session userid to '.$dn['id']);
                $_SESSION['username'] = $username;
                $_SESSION['userid'] = $dn['id'];
                updateUser($log, 1);
                auditEvent($log, $_SESSION['userid'], $_SESSION['username'], "login", $_SESSION['language']);
                echo "{success:true,username:'".$_SESSION['username']."',userid:'".$_SESSION['userid']."',message:'You are logged.'}";
            } else {
                $log->lwrite('Cookie user is logged. Wrong password cache????');
                auditEvent($log, $_SESSION['userid'], $_SESSION['username'], "failed login", $_SESSION['language']);
                echo '{success:false,message:"You are not logged."}';
            }
        } else {
            auditEvent($log, $_SESSION['userid'], $_SESSION['username'], "no login", $_SESSION['language']);
            echo '{success:false,message:"You are not logged."}';
        }
    }
    $log->lclose();
?>