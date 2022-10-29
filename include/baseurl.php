<?php
	//local
	if(isset($_SERVER['HTTPS'] ) ) {

		$file_path = 'https://'.$_SERVER['SERVER_NAME'] . '/karma/karma_app/';
		$image_path = 'https://'.$_SERVER['SERVER_NAME'] . '/karma/karma_app/images/';
		$image_user = 'https://'.$_SERVER['SERVER_NAME'] . '/karma/karma_app/image/user/';
	}
	else
	{
		$file_path = 'http://'.$_SERVER['SERVER_NAME'] . '/karma/karma_app/';
		$image_path = 'http://'.$_SERVER['SERVER_NAME'] . '/karma/karma_app/images/';
		$image_user = 'http://'.$_SERVER['SERVER_NAME'] . '/karma/karma_app/image/user/';
	}
?>