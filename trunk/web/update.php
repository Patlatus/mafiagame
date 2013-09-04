<?php
    include('initcfg.php');
    updateLastActivity($log);
    
    $t = time() - 15;
    $sql = 'update users set status = 2 WHERE status = 1 and last_activity < '.$t;
    $log->lwrite('sql='.$sql);
    if (mysql_query($sql)) {
        $log->lwrite('Sql, success:true');
    } else {
        $log->lwrite('Sql has failed: '.$sql);
    }
    $t = time() - 30;
    $sql = 'update users set status = 0 WHERE status > 0 and last_activity < '.$t;
    $log->lwrite('sql='.$sql);
    if (mysql_query($sql)) {
        $log->lwrite('Sql, success:true');
    } else {
        $log->lwrite('Sql has failed: '.$sql);
    }
    $sql = 'select username, status from users where status > 0';
    $log->lwrite('sql='.$sql);
    $result = mysql_query($sql);
    $log->lwrite("$result = ".$result);
    echo '{usersonline:"[';
    if ($row = mysql_fetch_array($result)) {
        $log->lwrite("if ");
        echo "{status:'" . $row['status'] . "',name:'" . $row['username'] . "'}";
    }
    while ($row = mysql_fetch_array($result)) {
        $log->lwrite("while ");
        echo ",{status:'" . $row['status'] . "',name:'" . $row['username'] . "'}";
    }
    echo ']",';
    
    $t = time() - 3600;
    $sql = 'select * from '.$bcl.' WHERE time > '.$t;
    $log->lwrite('sql='.$sql);
    $result = mysql_query($sql);
    $log->lwrite("$result = ".$result);
    
    echo 'chatlines:"[';
    if ($row = mysql_fetch_array($result)) {
        $log->lwrite("if ");
        echo "{userid:'" . $row['userid'] . "',text:'" . $row['text']. "',username:'" . $row['username']. "',time:'" . $row['time']  . "'}";
    }
    while ($row = mysql_fetch_array($result)) {
        $log->lwrite("while ");
        echo ",{userid:'" . $row['userid'] . "',text:'" . $row['text']. "',username:'" . $row['username']. "',time:'" . $row['time'] . "'}";
    }
    echo ']"';
    
    $t = time() - 3600;
    $sql = 'select * from '.$pg.' WHERE status = "on record" and time > '.$t;
    $log->lwrite('sql='.$sql);
    $result = mysql_query($sql);
    $log->lwrite("$result = ".$result);
    
    echo ',currentgames:"[';
    if ($row = mysql_fetch_array($result)) {
        $log->lwrite("if ");
        echo "{userid:'" . $row['userid'] . "',gameid:'" . $row['gameid']. "',username:'" . $row['username']. "',time:'" . $row['time']  . "'}";
    }
    while ($row = mysql_fetch_array($result)) {
        $log->lwrite("while ");
        echo ",{userid:'" . $row['userid'] . "',gameid:'" . $row['gameid']. "',username:'" . $row['username']. "',time:'" . $row['time'] . "'}";
    }
    echo ']"}';
?>