<?php
include 'connect.php';
$UDID = $_POST['UDID'];
$password = $_POST['password'];
$type = $_POST['type'];

$sql = mysqli_query($con, "SELECT * FROM `user_login` WHERE UDID='$UDID' AND password='$password' AND type='$type'");

$myarray = array(); // Initialize the array

if ($sql->num_rows > 0) {
    while ($row = mysqli_fetch_assoc($sql)) {
        $myarray['login_id']  = $row['login_id']; 
        $myarray['image']  = $row['image']; // Retrieve the login ID from the fetched row

        // Retrieve the login ID from the fetched row
        $myarray['result'] = 'Success';

    }
} else {
    $myarray['result'] = 'Failed';
}

echo json_encode($myarray);
?>
