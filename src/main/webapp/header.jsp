<%@page import="net.codejava.proweb.EntityCategory"%>
<%@page import="java.util.ArrayList"%>
<%@page import="net.codejava.proweb.Configuration"%>
<%@page import="net.codejava.proweb.RDFReader"%>
<%
    String selectedCategory = request.getParameter("obj");
    RDFReader myReader = new RDFReader();
    Configuration myConf = new Configuration();
    myReader.loadModel();
    myConf.appInfo();
    ArrayList<EntityCategory> categories = myConf.chooseCat();
%>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ProWeb</title>
        
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.3/Chart.min.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="css/header.css"/>
    </head>
    <body>

        <nav class="topnav">
            <ul>
                <li><a href="index.jsp">Main</a></li>
                <li><a href="about.jsp">About</a></li>
            </ul>
        </nav>

        <div align="center" >
            <h2>
                <%= myConf.getWelcomeTitle() %>
            </h2>
        </div>


    </body>
</html>
