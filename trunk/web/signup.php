<?php
    include('initcfg.php');
    include('zz.php');

    if (isset($_POST['rusername'], $_POST['rpassword'], $_POST['passverif'], $_POST['email']) and $_POST['rusername'] != '') {
        if (get_magic_quotes_gpc()) {
            $_POST['rusername'] = stripslashes($_POST['rusername']);
            $_POST['rpassword'] = stripslashes($_POST['rpassword']);
            $_POST['passverif'] = stripslashes($_POST['passverif']);
            $_POST['email'] = stripslashes($_POST['email']);
        }
        if ($_POST['rpassword']==$_POST['passverif']) {
            if (preg_match('#^(([a-z0-9!\#$%&\\\'*+/=?^_`{|}~-]+\.?)*[a-z0-9!\#$%&\\\'*+/=?^_`{|}~-]+)@(([a-z0-9-_]+\.?)*[a-z0-9-_]+)\.[a-z]{2,}$#i', $_POST['email'])) {
                $username = mysql_real_escape_string($_POST['rusername']);
                $password = mysql_real_escape_string(sha1($_POST['rpassword']));
                $email = mysql_real_escape_string($_POST['email']);


                $dn = mysql_num_rows(mysql_query('select id from users where username="'.$username.'"'));
                if ($dn==0) {
                    $dn = mysql_num_rows(mysql_query('select id from users where email="'.$email.'"'));
                    if ($dn==0) {
                        $dn2 = mysql_num_rows(mysql_query('select id from users'));
                        $log->lwrite('select id from users '.strval($dn2));
                        $log->lwrite('dn2= ['.strval($dn2).']');
                        $id = $dn2+1;
                        $log->lwrite('id= ['.strval($id).']');
                        $sql = "insert into users(id, username, password, email, signup_date) values (".$id.', "'.$username.'", "'.$password.'", "'.$email.'", "'.time().'")';
                        $log->lwrite('sql='.$sql);
                        
                        $result = mysql_query('select id from users');
                        $log->lwrite('$result=['.$result.']');
                        $mysres = mysql_result($result, 0, 0);
                        $log->lwrite('$mysres=['.$mysres.']');
                        $log->lwrite("result: ".$result." ; Error: ".mysql_error());
                        $sql = 'insert into users(username, password, email, signup_date) values ("'.$username.'", "'.$password.'", "'.$email.'", "'.time().'")';
                        $log->lwrite('sql='.$sql);
                        if (mysql_query($sql)) {
                            $form = false;
                            auditEvent($log, $_SESSION['userid'], $username, "signup", $_SESSION['language']);
                            echo '{success:true,message:"'.getMyLocalizedMessage($languageXMLdoc, 'successfulsignupmessage').'"}';
                        } else {
                            $form = true;
                            $log->lwrite("result: ".$result." ; Error: ".mysql_error());
                            auditEvent($log, $_SESSION['userid'], $username, "dbsignuperror", $_SESSION['language']);
                            $message = getMyLocalizedMessage($languageXMLdoc, 'dbsignuperror');#'An error occurred while signing you up.';
                        }
                    } else {
                        $form = true;
                        auditEvent($log, $_SESSION['userid'], $username, "signuperror:emailalreadyused", $_SESSION['language']);
                        $message = getMyLocalizedMessage($languageXMLdoc, 'emailalreadyused');#'Another user already use this email.';
                    }
                } else {
                    $form = true;
                    auditEvent($log, $_SESSION['userid'], $username, "signuperror:usernamealreadyused", $_SESSION['language']);
                    $message = getMyLocalizedMessage($languageXMLdoc, 'usernamealreadyused');#'Another user already use this username.';
                }
            } else {
                $form = true;
                auditEvent($log, $_SESSION['userid'], $username, "signuperror:invalidemail", $_SESSION['language']);
                $message = getMyLocalizedMessage($languageXMLdoc, 'invalidemail');#'The email you typed is not valid.';
            }
        } else {
            $form = true;
            auditEvent($log, $_SESSION['userid'], $username, "signuperror:passwordsarenotidentical", $_SESSION['language']);
            $message = getMyLocalizedMessage($languageXMLdoc, 'passwordsarenotidentical');#'The passwords you entered are not identical.';
        }
    } else {
        $form = true;
        auditEvent($log, $_SESSION['userid'], $username, "signuperror:emptyusernameorpassword", $_SESSION['language']);
        $message = getMyLocalizedMessage($languageXMLdoc, 'emptyusernameorpassword');
    }
    if ($form) {
        if (isset($message)) {
            echo '{success:false,message:"'.$message.'"}';
            auditFailedSignup($log, $_POST['rusername'], $_POST['rpassword'], $_POST['passverif'], $_POST['email'], $_SESSION['language']);
        }
        $log->lclose();
    }
?>