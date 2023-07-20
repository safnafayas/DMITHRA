<?php
session_start();
include "connect.php";
$text = $_POST['text'] ?? '';
$date = $_POST['date'] ?? '';
$time = $_POST['time'] ?? '';
$image = $_FILES['image']['name'] ?? '';
$imagePath = 'postsupload/' . $image;
$tmp_name = $_FILES['image']['tmp_name'] ?? '';
move_uploaded_file($tmp_name, $imagePath);

$login_id = $_POST['login_id'] ?? '';



    // Insert data into the add_post_user table
    $sql1 = "INSERT INTO add_post_user (`text`, `image`, `login_id`, `date`, `time`) VALUES ('$text', '$image', '$login_id', '$date', '$time')";

    $myarray = array(); // Initialize the array

    if ($con->query($sql1)) {
        $myarray['result'] = 'success';
    } else {
        $myarray['result'] = 'failed';
    }


echo json_encode($myarray);
?>
