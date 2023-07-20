<?php
include 'connect.php';
$username=$_POST['username'];
$password=$_POST['password'];
$type=$_POST['type'];

$sql=mysqli_query($con,"SELECT * FROM spo_org_login WHERE username='$username' && password='$password' && type='$type';");

if($sql -> num_rows> 0 ) {

  while($row = mysqli_fetch_assoc($sql)) {
      $myarray['result'] = 'Success';
      $myarray['login_id'] =$row['sp_og_id'];


  }


}
else {
  $myarray['result'] = 'Failed';
}

echo json_encode($myarray);




?>