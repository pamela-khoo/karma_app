<?php

session_start();


 $db = mysqli_connect('localhost','root','','karma_db');

 $user_id = $_POST['user_id'];

 $sql = "SELECT start_date FROM events inner join mission on events.id = mission.event_id where mission.user_id = '$user_id'";
 $result = mysqli_query($db,$sql);
 $count = mysqli_num_rows($result);
 $array = array();
 
 if($count != 0){
	while($row = $result->fetch_assoc()) {
		array_push($array, $row["start_date"]);
	}
	echo json_encode($array);
 } 
 else{
	$msg = "No event found for this user";
 	echo json_encode($msg);
 }
?>