  <!-- Navbar -->
  <nav class="main-header navbar navbar-expand navbar-white navbar-light">
    <!-- Left navbar links -->
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
      </li>
      <li class="nav-item d-none d-sm-inline-block">
        <a href="dashboard.html" class="nav-link">Home</a>
      </li>
      <li class="nav-item d-none d-sm-inline-block">
        <a href="#" class="nav-link">Contact</a>
      </li>
    </ul>

    <!-- Right navbar links -->
    <ul class="navbar-nav ml-auto">
      <!-- Navbar Search -->
      <li class="nav-item">
  <a class="nav-link" href="index.php" role="button" id="logoutBtn">
    <i class="fas fa-sign-out-alt"></i> Logout
  </a>
</li>

      <!-- Messages Dropdown Menu -->
   
      <!-- Notifications Dropdown Menu -->
     
    
     
    </ul>
  </nav>
  <!-- /.navbar -->
  <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3NRuX9CO8Vf13LR4vu1Zx1Ecqtlm9LP6wOoJ6o=" crossorigin="anonymous"></script>

<script>
$(document).ready(function() {
  // Add a click event listener to the logout button
  $('#logoutBtn').on('click', function() {
    // Perform the logout action here
    // For example, you can redirect the user to the logout page or perform any necessary logout actions.
    // Replace the 'logout.php' with the appropriate logout URL or script
    window.location.href = 'index.php';
  });
});
</script>
