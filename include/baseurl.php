<?php
	//local
	if(isset($_SERVER['HTTPS'] ) ) {

		$file_path = 'https://'.$_SERVER['SERVER_NAME'] . '/karma/karma_app/';
		$image_path = 'https://'.$_SERVER['SERVER_NAME'] . '/karma/karma_app/images/';
		$image_badge = 'https://'.$_SERVER['SERVER_NAME'] . '/karma/karma_app/images/badges/';
	}
	else
	{
		$file_path = 'http://'.$_SERVER['SERVER_NAME'] . '/karma/karma_app/';
		$image_path = 'http://'.$_SERVER['SERVER_NAME'] . '/karma/karma_app/images/';
		$image_badge = 'http://'.$_SERVER['SERVER_NAME'] . '/karma/karma_app/images/badges/';
	}
?>