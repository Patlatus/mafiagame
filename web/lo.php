<?php
    include('initcfg.php');
    updateUser($log, 0);
    unset($_SESSION['username'], $_SESSION['userid']);
    setcookie('julfysoft_username', '', time() - 100);
    setcookie('julfysoft_password', '', time() - 100);
?>