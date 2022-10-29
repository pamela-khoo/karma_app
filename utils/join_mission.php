<?php

	include '../include/connection.php';
	
	$data = file_get_contents('php://input');
	$dataDecode = json_decode($data, true);

	$eventID = $dataDecode['event_id'];
	$userID = $dataDecode['user_id'];

	$query = "SELECT * FROM mission WHERE event_id = '".$eventID."' AND user_id = '".$userID."'";
	$check = mysqli_fetch_assoc(mysqli_query($conn, $query));

	if ($check == 0) {
		mysqli_query($conn, "INSERT INTO mission (event_id, user_id, status) VALUES ('".$eventID."', '".$userID."', 0)");
		echo "success";
	}else{
		mysqli_query($conn, "DELETE FROM mission WHERE event_id = '".$eventID."' AND user_id = '".$userID."'");
		echo "deleted";
	}
	mysqli_close($conn);
?>