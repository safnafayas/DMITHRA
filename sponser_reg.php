<?php
 include "connect.php";
 $username=$_POST['username'];
 $password=$_POST['password'];
 $address=$_POST['address'] ?? '';
 $email=$_POST['email'];
 $location=$_POST['location'] ?? '';
 $contact_number=$_POST['contact_number'];
 $type=$_POST['type'] ?? '';


 $sql1=mysqli_query($con,"INSERT into spo_org_login (username,password,type)VALUES ('$username','$password','$type');");

 $userId1=mysqli_insert_id($con);

 $sql2=mysqli_query($con,"INSERT INTO sponsor_reg(contact_number,email,location,login_id) VALUES ('$contact_number','$email','$location','$userId1');");

if($sql1 && $sql2){
  $myarray['result']='success';
}
else{
  $myarray['result']='failed';

}
echo json_encode($myarray);



?>
