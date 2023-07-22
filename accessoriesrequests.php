<?php
include "connect.php";
$sql = mysqli_query($con,"SELECT * FROM request_table INNER JOIN user_register_table ON request_table.login_id = user_register_table.login_id WHERE type='accessories'"); 
if ($sql === false) {
  echo "MySQL Error: " . mysqli_error($con);
}?>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>DMITHRA</title>

  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="assets/plugins/fontawesome-free/css/all.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
  <!-- Tempusdominus Bootstrap 4 -->
  <link rel="stylesheet" href="assets/plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
  <!-- iCheck -->
  <link rel="stylesheet" href="assets/plugins/icheck-bootstrap/icheck-bootstrap.min.css">
  <!-- JQVMap -->
  <link rel="stylesheet" href="assets/plugins/jqvmap/jqvmap.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="assets/dist/css/adminlte.min.css">
  <!-- overlayScrollbars -->
  <link rel="stylesheet" href="assets/plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
  <!-- Daterange picker -->
  <link rel="stylesheet" href="assets/plugins/daterangepicker/daterangepicker.css">
  <!-- summernote -->
  <link rel="stylesheet" href="assets/plugins/summernote/summernote-bs4.min.css">
</head>
<body class="hold-transition sidebar-mini layout-fixed">
<div class="wrapper">  <!-- Navbar -->
  <nav class="main-header navbar navbar-expand navbar-white navbar-light">
    <!-- Left navbar links -->
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
      </li>
      <li class="nav-item d-none d-sm-inline-block">
        <a href="index3.html" class="nav-link">Home</a>
      </li>
      <li class="nav-item d-none d-sm-inline-block">
        <a href="#" class="nav-link">Contact</a>
      </li>
    </ul>

    <!-- Right navbar links -->

  </nav>
  <!-- /.navbar --><aside class="main-sidebar sidebar-dark-primary elevation-4">
    <!-- Brand Logo -->
    <a href="index3.html" class="brand-link">
 
      <span class="brand-text font-weight-light p-5 font-weight-bold h3">DMITHRA</span>
    </a>

    <!-- Sidebar -->
    <div class="sidebar">
      <!-- Sidebar user panel (optional) -->
      <div class="user-panel mt-3 pb-3 mb-3 d-flex">
        <div class="image">
        </div>
        <div class="info">
          <a href="#" class="d-block">Admin</a>
        </div>
      </div>

      <!-- SidebarSearch Form -->
      <div class="form-inline">
        <div class="input-group" data-widget="sidebar-search">
          <input class="form-control form-control-sidebar" type="search" placeholder="Search" aria-label="Search">
          <div class="input-group-append">
            <button class="btn btn-sidebar">
              <i class="fas fa-search fa-fw"></i>
            </button>
          </div>
        </div>
      </div>

      <!-- Sidebar Menu -->
      <nav class="mt-2">
        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
          <!-- Add icons to the links using the .nav-icon class
               with font-awesome or any other icon font library -->
          <li class="nav-item ">
            <a href="dashboard.php" class="nav-link ">
              <i class="nav-icon fas fa-tachometer-alt"></i>
              <p>
                Dashboard
                <!-- <i class="right fas fa-angle-left"></i> -->
              </p>
            </a>
          </li>
         
          <li class="nav-item ">
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-user"></i>
              <p>
                Users
                <i class="fas fa-angle-left right"></i>
                <span class="badge badge-info right">3</span>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="Organisations.php" class="nav-link ">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Organisations</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="Sponsors.php" class="nav-link ">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Sponsors</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="DifrentlyAbled.php" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Diffrently Abled People</p>
                </a>
              </li>
              
            </ul>
          </li>
          <li class="nav-item">
  <a href="#" class="nav-link active">
    <i class="nav-icon fas fa-exclamation-circle"></i>
    <p>
      Requests
      <i class="right fas fa-angle-left"></i>
    </p>
  </a>
  <ul class="nav nav-treeview">
    <li class="nav-item ">
      <a href="#" class="nav-link menu-open">
        <i class="far fa-circle nav-icon"></i>
        <p>Accepted Requests
        <i class="right fas fa-angle-left"></i>
        </p>
      </a>
      <ul class="nav nav-treeview">
        <li class="nav-item">
          <a href="foodaccepted.php" class="nav-link ">
            <i class="far fa-circle nav-icon"></i>
            <p>Food</p>
          </a>
        </li>
        <li class="nav-item">
          <a href="clothesaccepted.php" class="nav-link">
            <i class="far fa-circle nav-icon"></i>
            <p>Clothes</p>
          </a>
        </li>
        <li class="nav-item">
          <a href="accessoriesaccepted.php" class="nav-link">
            <i class="far fa-circle nav-icon"></i>
            <p>Accessories</p>
          </a>
        </li>
        <li class="nav-item">
          <a href="fundaccepted.php" class="nav-link">
            <i class="far fa-circle nav-icon"></i>
            <p>Fund</p>
          </a>
        </li>
        <li class="nav-item">
          <a href="medcicineaccepted.php" class="nav-link">
            <i class="far fa-circle nav-icon"></i>
            <p>Medicine</p>
          </a>
        </li>
        
        <li class="nav-item">
          <a href="othersaccepted.php" class="nav-link">
            <i class="far fa-circle nav-icon"></i>
            <p>Others</p>
          </a>
        </li>
      </ul>
    </li>
    <li class="nav-item">
      <a href="#" class="nav-link">
        <i class="far fa-circle nav-icon"></i>
        <p>All Requests
        <i class="right fas fa-angle-left"></i>
        </p>
      </a>
      <ul class="nav nav-treeview">
        <li class="nav-item">
          <a href="foodrequests.php" class="nav-link">
            <i class="far fa-circle nav-icon"></i>
            <p>Food</p>
          </a>
        </li>
        <li class="nav-item">
          <a href="clothesrequests.php" class="nav-link">
            <i class="far fa-circle nav-icon"></i>
            <p>Clothes</p>
          </a>
        </li>
        <li class="nav-item">
          <a href="accessoriesrequests.php" class="nav-link">
            <i class="far fa-circle nav-icon"></i>
            <p>Accessories</p>
          </a>
        </li>
        <li class="nav-item">
          <a href="Fundrequests.php" class="nav-link">
            <i class="far fa-circle nav-icon"></i>
            <p>Fund</p>
          </a>
        </li>
        <li class="nav-item">
          <a href="medicinerequests.php" class="nav-link">
            <i class="far fa-circle nav-icon"></i>
            <p>Medicine</p>
          </a>
        </li>
        <li class="nav-item">
          <a href="othersrequests.php" class="nav-link">
            <i class="far fa-circle nav-icon"></i>
            <p>Others</p>
          </a>
        </li>
      </ul>
    </li>
  </ul>
</li>

         
          <li class="nav-item">
            <a href="Products.php" class="nav-link">
              <i class="nav-icon fas fa-box-open"></i>
              <p>
                Products
                <!-- <i class="fas fa-angle-left right"></i> -->
              </p>
            </a>
          </li>
           
          <li class="nav-item">
            <a href="onlineclass.php" class="nav-link">
              <i class="nav-icon fas fa-table"></i>
              <p>
                Online Classes
                <!-- <i class="fas fa-angle-left right"></i> -->
              </p>
            </a>
            </li>
            <li class="nav-item">
            <a href="entr.php" class="nav-link">
              <i class="nav-icon fas fa-table"></i>
              <p>
                Entertainment videos
                <!-- <i class="fas fa-angle-left right"></i> -->
              </p>
            </a>
            </li>
          <!-- <li class="nav-header">EXAMPLES</li> -->
          <li class="nav-item">
            <a href="calendar.html" class="nav-link">
              <i class="nav-icon fas fa-calendar-alt"></i>
              <p>
                Calendar
                <span class="badge badge-info right">2</span>
              </p>
            </a>
          </li>
          <li class="nav-item">
            <a href="posts.php" class="nav-link">
              <i class="nav-icon far fa-image"></i>
              <p>
                Posts
              </p>
            </a>
          </li>
        
            </ul>
          
        </ul>
      </nav>
      <!-- /.sidebar-menu -->
    </div>
    <!-- /.sidebar -->
  </aside>


  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <!-- ... content header ... -->

    <!-- Main content -->
    <section class="content">
      <!-- ... main content ... -->
      <div class="row">
        <div class="col-12">
          <div class="card">
            <div class="card-header">
              <h3 class="card-title">Accessories Requests Accepted</h3>

              <div class="card-tools">
                <div class="input-group input-group-sm" style="width: 150px;">
                  <input type="text" name="table_search" class="form-control float-right" placeholder="Search">

                  <div class="input-group-append">
                    <button type="submit" class="btn btn-default">
                      <i class="fas fa-search"></i>
                    </button>
                  </div>
                </div>
              </div>
            </div>
            <!-- /.card-header -->
            <div class="card-body table-responsive p-0">
              <table class="table table-hover text-nowrap">
                <thead>
                  <tr>
                    <th>Req_id</th>
                    <th>Requester Name</th>
                    <th>Request_status</th>
                    <th>Description</th>
                    <th>Contact Name</th>
                    <th>Contact Number</th>
                    <th>Contact Address</th>
                  </tr>
                </thead>
                <tbody>
                  <?php
                if($sql->num_rows>0){

while($row=mysqli_fetch_array($sql)){
    ?>
                <tr>
                  <td><?php echo $row['req_id']; ?></td>
                  <td><?php echo $row['name']; ?></td>
                  <td><?php echo $row['req_status']; ?></td>
                  <td><?php echo $row['description']; ?></td>
                  <td><?php echo $row['contact_name']; ?></td>
                  <td><?php echo $row['contact_number']; ?></td>
                  <td><?php echo $row['contact_address']; ?></td>

                </tr>
                <?php
               }  } 
         ?>
                </tbody>
              </table>
            </div>
            <!-- /.card-body -->
          </div>
          <!-- /.card -->
        </div>
      </div>
      <!-- /.row -->
    </section>
    <!-- /.content -->
  </div>




        <footer class="main-footer">
    <strong>Copyright &copy; 2022-2023 <a href="#">DMYTHRA</a>.</strong>
    All rights reserved.
    <div class="float-right d-none d-sm-inline-block">
  
    </div>
  </footer>
</div>



<!-- jQuery -->
<script src="assets/plugins/jquery/jquery.min.js"></script>
<!-- jQuery UI 1.11.4 -->
<script src="assets/plugins/jquery-ui/jquery-ui.min.js"></script>
<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
<script>
  $.widget.bridge('uibutton', $.ui.button)
</script>
<!-- Bootstrap 4 -->
<script src="assets/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- ChartJS -->
<script src="assets/plugins/chart.js/Chart.min.js"></script>
<!-- Sparkline -->
<script src="assets/plugins/sparklines/sparkline.js"></script>
<!-- JQVMap -->
<script src="assets/plugins/jqvmap/jquery.vmap.min.js"></script>
<script src="assets/plugins/jqvmap/maps/jquery.vmap.usa.js"></script>
<!-- jQuery Knob Chart -->
<script src="assets/plugins/jquery-knob/jquery.knob.min.js"></script>
<!-- daterangepicker -->
<script src="assets/plugins/moment/moment.min.js"></script>
<script src="assets/plugins/daterangepicker/daterangepicker.js"></script>
<!-- Tempusdominus Bootstrap 4 -->
<script src="assets/plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
<!-- Summernote -->
<script src="assets/plugins/summernote/summernote-bs4.min.js"></script>
<!-- overlayScrollbars -->
<script src="assets/plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
<!-- AdminLTE App -->
<script src="assets/dist/js/adminlte.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="assets/dist/js/demo.js"></script>
<!-- AdminLTE dashboard demo (This is only for demo purposes) -->
<script src="assets/dist/js/pages/dashboard.js"></script>
</body>
</html>


