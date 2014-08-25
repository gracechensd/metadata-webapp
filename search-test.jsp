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

    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
    <script src="../../assets/js/ie-emulation-modes-warning.js"></script>

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="../../assets/js/ie10-viewport-bug-workaround.js"></script>

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    
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
      
      
		<%!
		// Define variables
		String id;
		String fName;
		String keyword;
		%>
	
	
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
			<p class="help-block">Search up to three keywords or ontologies, separated by commas.</p>
		<br />
		
	<% if (request.getParameter("search") != null && request.getParameter("search") != "") { %>
		Your Search: <%= request.getParameter("search") %>
	<% ; %>
	<% if (request.getParameter("type") != null) { %>
	<% out.println(" - "); %>
	
	
	<script type="text/javascript">
	$(document).ready( function () {
		$('#table_results').DataTable();
	} );
	</script>
	
	<table class="table table-hover" id="table_results">
		<thead>
			<tr>
				<th>#</th>
				<th>File Name</th>
			</tr>
		</thead>
		<tbody>
		<%
		// This is needed to use Connector/J. It basically creates a new instance
		// of the Connector/J jdbc driver.
		Class.forName("com.mysql.jdbc.Driver").newInstance();

		// Open new connection.
		java.sql.Connection conn;
		/* To connect to the database, you need to use a JDBC url with the following 
		   format ([xxx] denotes optional url components):
		   jdbc:mysql://[hostname][:port]/[dbname][?param1=value1][&param2=value2]... 
		   By default MySQL's hostname is "localhost." The database used here is 
		   called "mydb" and MySQL's default user is "root". If we had a database 
		   password we would add "&password=xxx" to the end of the url.
		*/
	
		conn = DriverManager.getConnection("jdbc:mysql://localhost/metadata?user=root");
	
	
		// Generate the SQL query.
		String query = "";
		int searchCount = 0;
		String[] searches = new String[3]; //can search up to 3 keywords
		
		String[] parts = request.getParameter("search").split("\\s*,\\s*");
		for (int i = 0; i < parts.length; i++) {
			searches[i] = parts[i];
			searchCount++;
			if (i == 2) { //if already filled up all three keywords
				break;
			}
		}
		
		//chooses correct statement based on number of keywords/ontologies input
		if (request.getParameter("type").equals("keyword")) {
			if (searchCount == 1) {
			query = "SELECT * FROM keywords2 s1 WHERE s1.keyword = ?";
			}
			else if (searchCount == 2) {
			query = "SELECT * FROM keywords2 s1, keywords2 s2 WHERE s1.file_name = s2.file_name AND s1.keyword = ? AND s2.keyword = ? ";
			}
			else {
			query = "SELECT * FROM keywords2 s1, keywords2 s2, keywords2 s3 WHERE s1.file_name = s2.file_name AND s2.file_name = s3.file_name AND s1.keyword = ? AND s2.keyword = ? AND s3.keyword = ? ";
			}
		}
		else if (request.getParameter("type").equals("ontology")) {
			if (searchCount == 1) {
			query = "SELECT * FROM ontologies2 s1 WHERE s1.ontology LIKE ?";
			}
			else if (searchCount == 2) {
			query = "SELECT * FROM ontologies2 s1, ontologies2 s2 WHERE s1.file_name = s2.file_name AND s1.ontology = ? AND s2.ontology = ? ";
			}
			else {
			query = "SELECT * FROM ontologies2 s1, ontologies2 s2, keywords2 s3 WHERE s1.file_name = s2.file_name AND s2.file_name = s3.file_name AND s1.ontology = ? AND s2.ontology = ? AND s3.ontology = ? ";
			}
		}
	
		PreparedStatement sqlStatement = conn.prepareStatement(query);
		for (int i = 0; i < searchCount; i++) {
			sqlStatement.setString(i+1, searches[i]); //inputs correct number of search terms based on searchCount
		}
		
		int count = 0;

		// Get the query results and display them.
		ResultSet sqlResult = sqlStatement.executeQuery();
		while(sqlResult.next()) {
			fName = sqlResult.getString("file_name");
			out.println("<tr> <td>" + (count+1) + "</td> <td> <a href=\"http://hydro10.sdsc.edu/metadata/" + fName + "\">" + fName + "</a> </td> </tr>");
			count++;
		}
		
		
		if (count == 0) {
			out.println("No results found");
		}
		else if (count == 1) {
			out.println(count + " result");
		}
		else {
			out.println(count + " results");
		} 
		out.println("<p>");

		// Close the connection.
		sqlResult.close();
		sqlStatement.close();
		conn.close();
		%>
		</tbody>
	</table>
	 <% }} %> <!-- end results if not null or blank -->
	 	 
	  </div> <! -- close panel -->

	  <br />
      <div class="footer">
        <p>&copy; Grace Chen | SDSC 2014</p>
      </div>
      <br />

    </div> <!-- /container -->


    <!-- Bootstrap core JavaScript
    ================================================== -->
    
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script> -->
    <!-- Include all compiled plugins (below), or include individual files as needed -->

    
    <!-- Placed at the end of the document so the pages load faster -->
  </body>
</html>