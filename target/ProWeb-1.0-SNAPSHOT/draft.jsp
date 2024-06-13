
        <%  int limit = 50 ;
            int pagee = 1 ;
            String limite = request.getParameter("limit");
        %>

<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ALLO</title>
        <script src="https://cdn.jsdelivr.net/npm/ag-grid-community/dist/ag-grid-community.min.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"/>


    </head>
    <body>        
        <table class="table">
            <% for(int i = (pagee - 1)*limit; i < limit+(pagee*limit); i++){%>
                <tbody>
                    <td><%= i %></td>
                </tbody>
            <% } %>
            
            
            <%
                
                
                if(pagee>1)
            for(int i = (pagee - 1)*limit; i < limit+(pagee*limit); i++){
                
            }
            
            %>
        </table>
    </body>
</html>