<?php 

 $DB_SERVER="localhost";
 $DB_NAME="karma_db";
 $USERNAME="root";
 $PASSWORD="";

 $conn = mysqli_connect($DB_SERVER,$USERNAME,$PASSWORD,$DB_NAME);


if (isset($_GET['mission'])) { 
    $array = array(); 
    $query = "SELECT * FROM mission ORDER BY id DESC";
    $sql = mysqli_query($conn, $query); 
    
    while ($data = mysqli_fetch_assoc($sql)) { 

        $row['id'] = $data['id']; 
        $row['event_id'] = $data['event_id']; 

        array_push($array, $row); 
    }
    header('Content-Type: application/json; charset=utf-8');
    echo str_replace('\\/', '/', json_encode($array, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT));
}
?>