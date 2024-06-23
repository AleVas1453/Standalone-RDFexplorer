<%@page import="net.codejava.proweb.EntityCategory"%>
<%@page import="java.util.ArrayList"%>
<%@page import="net.codejava.proweb.Configuration"%>
<%@page import="net.codejava.proweb.RDFReader"%>
<%
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
                <li><a href="main_1.jsp">Main</a></li>
                <!--<li><a href="grid_2.jsp">Categories</a></li>-->
            </ul>
        </nav>

        <div align="center" >
            <h2>
                <%= myConf.getWelcomeTitle() %>
            </h2>
        </div>

        <div class="apokatw" align="left">
            <% for (EntityCategory category : categories) {%>
            <a class="links" href="grid_2.jsp?obj=<%= category.getName().trim()%>"> 
                <%= category.getName()%> (<%= myReader.countCateg(category.getCount_query())%>)
            </a><br/><%}%>
        </div>

        <div class="info"  > 
            <h2 style ="color:#4b607d">
                <%= myConf.getTitle()%>
            </h2>
            <h3 style ="color:#6495ED">
                <%= myConf.getSubtitle()%>
            </h3>
            <p><%= myConf.getDescription()%></p>
        </div>
    
    </body>
</html>