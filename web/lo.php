<?php
include('initcfg.php');
unset($_SESSION['username'], $_SESSION['userid']);
setcookie('planssiteusername', '', time()-100);
setcookie('planssitepassword', '', time()-100);
?>