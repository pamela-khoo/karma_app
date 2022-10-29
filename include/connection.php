<?php
    error_reporting(0);
    session_start();

    $DB_SERVER="localhost";
    $DB_NAME="karma_db";
    $USERNAME="root";
    $PASSWORD="";
   
    $conn = mysqli_connect($DB_SERVER,$USERNAME,$PASSWORD,$DB_NAME);

?>