<?php
include "connect.php";
$UDID=$_POST['UDID'] ?? '';
$password=$_POST['password'] ?? '';
$name=$_POST['name'] ?? '';
$contact_number=$_POST['contact_number'] ?? '';


// $image = $_FILES['profile_image']['name'] ?? '';
// $imagePath = 'profileImageUpload/' . $image;
// $tmp_name = $_FILES['profile_image']['tmp_name'] ?? '';
// move_uploaded_file($tmp_name, $imagePath);

$type=$_POST['type'];

$sql1=mysqli_query($con,"INSERT INTO  `user_login` (UDID,password,type) VALUES ('$UDID','$password','$type');");
$userId=mysqli_insert_id($con);

$sql2=mysqli_query($con,"INSERT into `user_register_table`(name,contact_number,login_id)VALUES('$name','$contact_number','$userId'); ");

if($sql1 && $sql2){
  $myarray['result']='success';
}
else{
  $myarray['result']='failed';

}
echo json_encode($myarray);

?>