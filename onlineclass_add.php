<?php
include "connect.php";
$link=$_POST['link'] ?? '';
$caption=$_POST['caption'] ?? '';
$date=$_POST['date'] ?? '';

$sql=mysqli_query($con,"INSERT INTO `onlineclass_tb`( `link`, `caption`,`date`) VALUES ('$link','$caption','$date')");

if($sql){
  $myarray['result']='success';

}
else{
  $myarray['result']='failed';
}
echo json_encode($myarray);

?>
