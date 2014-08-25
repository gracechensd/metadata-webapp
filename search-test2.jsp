<!DOCTYPE html>
<!-- These import statements are needed to run the SQL queries, they are
     part of the JDK. -->
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>

<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../../favicon.ico">

    <title>Metadata Ontologies</title>

    <!-- Bootstrap core CSS -->
    <link href="./css/bootstrap.min.css" rel="stylesheet">
	
	<!-- DataTables CSS -->
	<link rel="stylesheet" type="text/css" href="//cdn.datatables.net/plug-ins/725b2a2115b/integration/bootstrap/3/dataTables.bootstrap.css">
  
  	<script type="text/javascript" charset="utf8" src="//code.jquery.com/jquery-1.10.2.min.js"></script>
  	
	<!-- DataTables -->
	<script type="text/javascript" charset="utf8" src="//cdn.datatables.net/1.10.2/js/jquery.dataTables.js"></script>
	
	<script type="text/javascript" charset="utf8" src="//cdn.datatables.net/plug-ins/725b2a2115b/integration/bootstrap/3/dataTables.bootstrap.js"></script>

  </head>

  <body>
  
    <div class="container">
      <div class="header">
        <ul class="nav nav-pills pull-right">
          <li><a href="./index.html">Home</a></li>
          <li><a href="./about.html">About</a></li>
          <li class="active"><a href="./search.jsp">Search</a></li>
          <li><a href="./contact.html">Contact</a></li>
        </ul>
        <a href="./index.html"><h3 class="text-muted">Metadata Ontologies</h3></a>
      </div>
      
      <br />
	
	
  		<div class="panel col-lg-6">
		  <h2>Search</h2>
		  <br />
	 	 
			<form class="form-inline" role="form" method="GET">
			<div class="form-group">
			<label for="inKeyword">Search by:</label>
				<div class="radio">
				  <label>
					<input type="radio" name="type" value="keyword" checked>
					Keyword
				  </label>
				</div>
				<div class="radio">
				  <label>
					<input type="radio" name="type" value="ontology">
					Ontology URI
				  </label>
				</div>
				<input class="form-control" name="search" placeholder="Enter search">
			</div>
			<button type="submit" class="btn btn-success">Submit</button>
			<button type="reset" class="btn btn-danger">Reset</button>
			</form>
		<br />
	
	<script type="text/javascript">
	$(document).ready( function () {
		$('#example').DataTable();
	} );
	</script>
	
	<table class="table table-condensed table-hover" id="example">
		<thead>
			<tr>
				<th>#</th>
				<th>File Name</th>
			</tr>
		</thead>
		<tbody>
			<tr> <td> 1 </td> <td> 12345.xml </td> </tr>
			<tr> <td> 2 </td> <td> sdlkfs.xml </td> </tr>
			<tr> <td> 3 </td> <td> 12625.xml </td> </tr>
			<tr> <td> 4 </td> <td> fslkdjs.xml </td> </tr>
			<tr> <td> 5 </td> <td> areyu.xml </td> </tr>
		</tbody>
	</table>
	 	 
	  </div> <! -- close panel -->

	  <br />
      <div class="footer">
        <p>&copy; Grace Chen | SDSC 2014</p>
      </div>
      <br />

    </div> <!-- /container -->

	
    <!-- Bootstrap core JavaScript
    ================================================== -->
    
    <!-- Placed at the end of the document so the pages load faster -->
  </body>
</html>