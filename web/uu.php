<?php
    include('initcfg.php');
    if (!isset($_SESSION['username'])) {
        $log->lwrite('Die. User is not logged.');
        die('User is not logged.');
    }
    if ((!isset($_POST['userid'])) || (!isset($_POST['status']))) {
        $log->lwrite('Die. No arguments detected.');
        die('No arguments detected.');
    }
    
    if ($_SESSION['userid'] != $_POST['userid']) {
        $log->lwrite('Die. Securite alert.'.' session user: '.$_SESSION['userid'].' ; argument user: '.$_SESSION['userid']);
        die('Securite alert.'.' session user: '.$_SESSION['userid'].' ; argument user: '.$_SESSION['userid']);
    }
    $userid = $_POST['userid'];
    $status = $_POST['status'];
    updateUser($log, $status);
?>