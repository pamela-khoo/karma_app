<?php
session_start();

$db = mysqli_connect('localhost','root','','karma_db');

$user_id = $_POST['user_id'];
$event_id = $_POST['event_id'];


$sql = "SELECT id FROM joined_events WHERE user_id = '".$user_id."' AND event_id = '".$event_id."'" ;
$result = mysqli_query($db,$sql);
$count = mysqli_num_rows($result);
if($count == 1){
	echo json_encode("Error");
}else{
	$insert = "INSERT INTO joined_events(user_id, event_id) VALUES ('".$user_id."','".$event_id."')";
		$query = mysqli_query($db,$insert);
		if($query){
			echo json_encode("Success");
		}
}
?>