<?php
include "connect.php";
$username=$_POST['username'];
$password=$_POST['password'];
$address=$_POST['address'];
$contact_number=$_POST['contact_number'];
$email=$_POST['email'];
$location=$_POST['location'];
$type=$_POST['type'];
$org_category=$_POST['org_category'];


$sql1=mysqli_query($con,"INSERT INTO spo_org_login(username,password,type)values('$username','$password','$type');");
$userId1=mysqli_insert_id($con);

$sql2=mysqli_query($con,"INSERT INTO org_register(address,contact_number,email,location,org_category,login_id) VALUES ('$address','$contact_number','$email','$location','$org_category','$userId1');");

if($sql1 && $sql2){
  $myarray['result']='success';
}
else{
  $myarray['result']='failed';

}
echo json_encode($myarray);








?>