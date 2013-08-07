<?php
include('initcfg.php');
if (isset($_SESSION['username'])) {
    $log->lwrite('Session user is logged.');
    updateUser($log, 1);
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
            echo "{success:true,username:'".$_SESSION['username']."',userid:'".$_SESSION['userid']."',message:'You are logged.'}";
        } else {
            $log->lwrite('Cookie user is logged. Wrong password cache????');
            echo '{success:false,message:"You are not logged."}';
        }
    } else {
        echo '{success:false,message:"You are not logged."}';
    }
}
?>