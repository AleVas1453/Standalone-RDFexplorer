<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="net.codejava.proweb.EntityCategory"%>
<%@page import="net.codejava.proweb.Configuration"%>
<%@page import="java.util.Properties"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.apache.jena.rdf.model.Literal"%>
<%@page import="org.apache.jena.rdf.model.Resource"%>
<%@page import="net.codejava.proweb.RDFReader"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<%
    String obj = request.getParameter("obj");

    RDFReader myReader = new RDFReader();
    Configuration myConf = new Configuration();
    myReader.loadModel();
    myConf.appInfo();
    ArrayList<EntityCategory> categories = myConf.chooseCat();
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ProWeb</title>

        <style>

            body{
                background-color: #ECF0F1;
                background-image: linear-gradient(rgba(0, 0, 0, 0.5),
                    rgba(0, 0, 0, 0.5)),url('images/home-img.jpg');
                background-repeat: no-repeat;
                /*background-attachment: fixed;*/
                background-position: top;
                background-size: 980px 400px ;
                max-width: 980px;
                margin:auto
            }

            .topnav ul{
                /*                position: fixed;
                                width: 980px;
                                top: 0;*/
                list-style-type: none;
                background-color: #7695bfd4;
                padding: 0px;
                margin: 0px;
                overflow: hidden;
                border-radius: 0px 0px 15px 15px;
            }

            .topnav a {
                color: white;
                text-decoration: none;
                padding: 15px;
                display: block;
                text-align: center;
            }

            .topnav a:hover {
                background-color: #4b607d;
                color: black;
            }

            .topnav li{
                float: left;
            }
            .square-border {
                border: 2px solid black; /* You can change the border color and thickness as needed */
                padding: 10px; /* Adjust the padding to control the distance between text and the border */
                display: inline-block; /* This makes the border wrap around the text */
                border-radius: 50%;
            }
            .apokatw {
                margin-top: 330px;
                display: block;
                border-right: 2px solid #4b607d;
                position: absolute;
            }
            .info{
                margin-top: 350px;
                margin-left: 240px;
            }

            .links{
                border: 2px solid #4b607d; /* You can change the border color and thickness as needed */
                padding: 5px; /* Adjust the padding to control the distance between text and the border */
                display: inline-block; /* This makes the border wrap around the text */
                border-radius: 10px;
                margin: 2px;
            }
            .links:visited {
                color: #4b607d;
            }
            .links:hover {
                color:black;
            }
            .links:active {
                /*color:teal;*/
            }

            /*            .scroll {
                            height: 100%;
                            width: 250px;
                            overflow: auto;
                        }
            
                        .content {
                            height: 50px;
                            width: 600px;
                        }*/

            /* Set width length for the left, right and middle columns */
            .left {
                width: 40%;
            }

            .middle {
                width: 30%;
            }

            .right {
                width: 30%;
            }

            .table {
                border-collapse: collapse;
                width: 100%;
                /*width: max-content;*/
            }
            td, th {
                border: 1px solid #dddddd;
                text-align: left;
                padding: 8px;
            }
            tr:nth-child(even) {
                background-color: #dddddd;
            }

            .pagination {
                margin-top: 20px;
            }
            .pagination a {
                text-decoration: none;
                padding: 5px 10px;
                border: 1px solid #ccc;
                margin-right: 5px;
            }

        </style>
    </head>

    <body>
    
       <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <nav class="topnav">
        <ul>
            <li><a href="index.jsp">Home</a></li>
            <li><a href="info.jsp">Info</a></li>
            <li><a href="explore.jsp">Explore</a></li>
        </ul>
    </nav>
    <div align="center" >
        <h2 class="welcome-title" >Welcome to the FastCat Catalogues</h2>
    </div>
    <div class="apokatw" align="left">
        <% for (EntityCategory category : categories) {%>
        <a class="links" href="?obj=<%= category.getUriName().trim()%>"> <!-- I Must TEST which is the correct: 1:href="view.jsp?obj or 2:"href="?obj=" ??-->
            <%= category.getName()%> (<%= myReader.countCateg(category.getCount_query())%>)
        </a><br/><%}%>
    </div>
    <!--style="background-color: #4b607d; color: white"-->
    <%
        String selectedCategory = request.getParameter("obj");
    %>
    <% for (EntityCategory category : categories) {%>
    <%  if (selectedCategory != null && selectedCategory.equals(category.getUriName().trim())) {
                ArrayList<Map<String, String>> results = myReader.categInstances(category.getInfo());
                if (!results.isEmpty()) { %>

    <table class="info" border="1">
        <thead>
            <tr style="background-color: #4b607d; color: white;">
                <% Map<String, String> firstResult = results.get(0);
                    for (String column : firstResult.keySet()) {%>
                <th><%= column%></th>
                    <% } %>
            </tr>
        </thead>
        <tbody>
            <% for (Map<String, String> result : results) { %>
            <tr>
                <% for (String value : result.values()) {%>
                <td><%= value%></td>
                <% } %>
            </tr>
            <% } %>
        </tbody>
    </table>
    <% }
            }
        } %>

</body>
</html>
<%
    System.out.println("parameter obj> " + obj);
%>