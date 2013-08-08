<?php
    include('initcfg.php');
    include('zz.php');
    if (isset($_SESSION['username'])) {
        unset($_SESSION['username'], $_SESSION['userid']);
        setcookie('julfysoft_username', '', time() - 100);
        setcookie('julfysoft_password', '', time() - 100);
    } else {
        $ousername = '';
        $user = $_POST['username'];
        $pass = $_POST['password'];
        $_SESSION['language'] = $_POST['language'];
        if (!isset($user)) {
            $user = $_GET['username'];
            $pass = $_GET['password'];
        }
        if (isset($user, $pass)) {
            if (get_magic_quotes_gpc()) {
                $ousername = stripslashes($user);
                $username = mysql_real_escape_string(stripslashes($user));
                $password = stripslashes($pass);
            } else {
                $username = mysql_real_escape_string($user);
                $password = $pass;
            }
            $req = mysql_query('select password,id from users where username="'.$username.'"');
            $dn = mysql_fetch_array($req);
            if ($dn['password'] == sha1($password) and mysql_num_rows($req) > 0) {
                $form = false;
                $_SESSION['username'] = $user;
                $_SESSION['userid'] = $dn['id'];
                //if(isset($_POST['memorize']) and $_POST['memorize']=='yes') {
                $one_year = time() + (60 * 60 * 24 * 365);
                setcookie('julfysoft_username', $user, $one_year);
                setcookie('julfysoft_password', sha1($password), $one_year);
                //}
                auditEvent($log, $_SESSION['userid'], $_SESSION['username'], "login", $_SESSION['language']);
                echo '{success:true,message:"'.getMyLocalizedMessage($languageXMLdoc, 'successfulloginmessage').'",username:"'.$_SESSION['username'].'",userid:"'.$_SESSION['userid'].'"}';#"You have successfully been logged."
                updateUser($log, 1);
            } else {
                $form = true;
                auditEvent($log, $_SESSION['userid'], $_SESSION['username'], "failed login", $_SESSION['language']);
                auditFailedLogin($log, $user, $pass, $_SESSION['language']);
                $message = getMyLocalizedMessage($languageXMLdoc, 'wronguserorpasswordmessage');
            }
        } else {
            $form = true;
            auditEvent($log, $_SESSION['userid'], $user, "signuperror:emptyusernameorpassword", $_SESSION['language']);
            auditFailedLogin($log, $user, $pass, $_SESSION['language']);
            $message = getMyLocalizedMessage($languageXMLdoc, 'emptyusernameorpassword');
        }
        if ($form) {
            if (isset($message)) {
                echo '{success:false,message:"'.$message.'"}';
            }
        }
    }
    $log->lclose();
?>