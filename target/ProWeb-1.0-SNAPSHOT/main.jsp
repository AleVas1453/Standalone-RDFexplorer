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

    </head>
    <body>

        <div>
            <% for (EntityCategory category : categories) {%>
            <a class="links" href="grid.jsp?obj=<%= category.getUriName().trim()%>"> 
                <%= category.getName()%> (<%= myReader.countCateg(category.getCount_query())%>)
            </a><br/><%}%>
        </div>
    
    </body>
</html>