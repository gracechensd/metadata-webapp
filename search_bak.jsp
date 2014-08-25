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

    <!-- Custom styles for this template -->
    <link href="jumbotron-narrow.css" rel="stylesheet">

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
  </head>

  <body>

    <div class="container">
      <div class="header">
        <ul class="nav nav-pills pull-right">
          <li><a href="./index.html">Home</a></li>
          <li><a href="./about.html">About</a></li>
          <li class="active"><a href="./search.jsp">Search</a></li>
          <li><a href="#">Contact</a></li>
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
				<label for="inKeyword">Search by Keyword</label>
				<input class="form-control" name="inKeyword" placeholder="Enter search">
			</div>
			<button type="submit" class="btn btn-success">Submit</button>
			<button type="reset" class="btn btn-danger">Reset</button>
			</form>
		<br />
		
	<% if (request.getParameter("inKeyword") != null && request.getParameter("inKeyword") != "") { %>
		Your Search: <%= request.getParameter("inKeyword") %>
	<% ; %>
	<br /><br />
	
	<table class="table">
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
	String query = "SELECT * FROM keywords2 WHERE keyword = ?";
	int count = 0;
	
	PreparedStatement sqlStatement = conn.prepareStatement(query);

	sqlStatement.setString(1, request.getParameter("inKeyword"));

	// Get the query results and display them.
	ResultSet sqlResult = sqlStatement.executeQuery();
	while(sqlResult.next()) {
		fName = sqlResult.getString("file_name");
		out.println("<tr> <td>" + fName + "</td> </tr>");
		count++;
	}
	
	if (count == 0) {
		out.println("No files found");
	}
	else if (count == 1) {
		out.println(count + " file found");
	}
	else {
		out.println(count + " files found");
	}

	// Close the connection.
	sqlResult.close();
	sqlStatement.close();
	conn.close();
	%>
	</table>
	 <% } %> <!-- end results if not null or blank -->
	 	 
	  </div> <! -- close panel -->

	  <br />
      <div class="footer">
        <p>&copy; Company 2014</p>
      </div>
      <br />

    </div> <!-- /container -->


    <!-- Bootstrap core JavaScript
    ================================================== -->
    
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="./js/bootstrap.min.js"></script>
    
    <!-- Placed at the end of the document so the pages load faster -->
  </body>
</html>