<?php
include "connect.php";
$login_id = $_POST['login_id'];
$sql = mysqli_query($con, "SELECT image FROM user_login WHERE login_id='$login_id'");
$myarray = array(); // Initialize the array

if (mysqli_num_rows($sql) > 0) {
  while ($row = mysqli_fetch_assoc($sql)) {
    $myarray['login_id'] = $login_id;
    $myarray['image'] = $row['image'];
    $myarray['result'] = 'Success';
  }
} else {
  $myarray['result'] = 'Failed';
}

echo json_encode($myarray);
?>
