<%@page import="java.util.Arrays"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="net.codejava.proweb.Configuration"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="net.codejava.proweb.EntityCategory"%>
<%@page import="net.codejava.proweb.RDFReader"%>

<%
    String selectedCategory = request.getParameter("obj");
    String URIDetails = request.getParameter("URIDetails");
    RDFReader myReader = new RDFReader();
    Configuration myConf = new Configuration();
    myReader.loadModel();
    myConf.appInfo();
    ArrayList<EntityCategory> categories = myConf.chooseCat();
    int limit = Integer.parseInt(request.getParameter("limit") != null ? request.getParameter("limit") : "10");
    int currentPage = Integer.parseInt(request.getParameter("page") != null ? request.getParameter("page") : "1"); 

    
%>  


<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ProWeb</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <!--<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"/>-->
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.3/Chart.min.js"></script>        

    </head>
    <body>
        <div>
            <% for (EntityCategory category : categories) {%>
            <a class="links" href="?obj=<%= category.getUriName().trim()%>"> 
                <%= category.getName()%> (<%= myReader.countCateg(category.getCount_query())%>)
            </a><br/>
            <%}%>
        </div>
        
        <div class="container">        
            <table class="table">
                <% for (EntityCategory category : categories) {
                    if (selectedCategory != null && selectedCategory.equals(category.getUriName().trim())) {
                        ArrayList<Map<String, String>> results = myReader.categInstances(category.getInfo(), limit, currentPage);
                        if (!results.isEmpty()) {
                            Map<String, String> firstName = results.get(0);%>
                            <thead>
                                <tr>
                                <%for (String column : firstName.keySet()) {%>
                                    <th><%= column%></th>
                                <%}%>
                                </tr>
                            </thead>
                            <%for (Map<String, String> result : results) {%>
                                <tbody>
                                    <tr>
                                    <%for (String column : result.keySet()) {%>
                                        <td><a href="?obj=<%= category.getUriName().trim()%>&URIDetails=<%=result.get("URI")%>">
                                                <%= result.get(column)%>
                                            </a><br/>
                                        </td>
                                    <%}%>
                                    </tr>
                                </tbody>
                            <%}
                        }          
                    } 
                }%>
            </table>
            
            <% for (EntityCategory category : categories) {
                    if (selectedCategory != null && selectedCategory.equals(category.getUriName().trim())) {
                        int counter = myReader.intCount(myReader.countCateg(category.getCount_query()));
                        if(currentPage>1 && currentPage < myReader.totalPages(counter, limit)){%>
                            <a class="links" href="?obj=<%= category.getUriName().trim()%>&limit=<%=limit%>&page=<%=currentPage - 1%>" >Previous</a>
                            <%= currentPage%> of <%= myReader.totalPages(counter, limit)%>
                            <a class="links" href="?obj=<%= category.getUriName().trim()%>&limit=<%=limit%>&page=<%=currentPage + 1%>" >Next</a>
                        <%}
                        else if(currentPage == 1){%>
                            <a class="links" href="?obj=<%= category.getUriName().trim()%>&limit=<%=limit%>&page=<%=currentPage%>" hidden>Previous</a>
                            <%= currentPage%> of <%= myReader.totalPages(counter, limit)%>
                            <a class="links" href="?obj=<%= category.getUriName().trim()%>&limit=<%=limit%>&page=<%=currentPage + 1%>" >Next</a>
                        <%}
                        else if(currentPage == myReader.totalPages(counter, limit)){%>
                            <a class="links" href="?obj=<%= category.getUriName().trim()%>&limit=<%=limit%>&page=<%=currentPage - 1%>" >Previous</a>
                            <%= currentPage%> of <%= myReader.totalPages(counter, limit)%>
                            <a class="links" href="?obj=<%= category.getUriName().trim()%>&limit=<%=limit%>&page=<%=currentPage%>" hidden>Next</a>
                        <%}     
                    } 
                }%>   
        
        </div> 
                
        <div>    
            <% for (EntityCategory category : categories) {
                if (selectedCategory != null && selectedCategory.equals(category.getUriName().trim())) {
                    ArrayList<Map<String, String>> results = myReader.categInstances(category.getInfo());
                    if (!results.isEmpty()) {
                        for (Map<String, String> result : results) {
                            if (URIDetails != null && URIDetails.equals(result.get("URI").trim())) {%>                                
                                <style>
                                    .container{
                                        display: none;
                                    }
                                </style>
                                <%for (String column : result.keySet()) {%>
                                    <p>
                                        <%=column%>: <%=result.get(column)%></br>
                                    </p>
                                <%}%><br>
                            <%}
                        }
                    }
                }
            }%>
        </div>

        <form id="myform">Charts:
            <%for (EntityCategory category : categories) {
                if (selectedCategory != null && selectedCategory.equals(category.getUriName().trim())) {
                    ArrayList<Map<String, String>> results = myReader.categInstances(category.getInfo());
                    if(!results.isEmpty()) {
                        Map<String, String> firstName = results.get(0);
                        for (String column : firstName.keySet()) {%>
                            <input type="checkbox" id="<%=column %>" class="chart-checkbox"/>
                            <label for="<%=column%>"><%=column%></label>
                        <%}
                        for (String column : firstName.keySet()) {%>
                            <canvas id="myChart<%=column %>" style="display: none"></canvas>
                        <%}
                    }
                }
            }%>
        </form>        
        
    </body>

        <%for (EntityCategory category : categories) {
            if (selectedCategory != null && selectedCategory.equals(category.getUriName().trim())) {

                ArrayList<Map<String, String>> results = myReader.categInstances(category.getInfo());
                if(!results.isEmpty()) {
                    Map<String, String> firstName = results.get(0);
                    for (String column : firstName.keySet()) {
                        Map<String, Integer> sum = myReader.counter(results, column);%>
                        <script>
                            let myChart<%=column %> = document.getElementById('myChart<%=column %>').getContext('2d');

                            let <%=column %>Chart = new Chart(myChart<%=column %>, {
                                type: 'bar',
                                data: 
                                {
                                    labels: 
                                              <%= sum.keySet() %>,
                                    datasets: 
                                            [
                                            {
                                              label:'<%=column %>',
                                              data: 
                                                    <%= sum.values() %>,
                                              backgroundColor: 'rgba(75, 192, 192, 0.2)', 
                                              borderColor: 'rgba(75, 192, 192, 1)',
                                              borderWidth: 1 

                                            }
                                            ], 
                                },
                                options: 
                                {
                                    scales: 
                                    {
                                        yAxes: [{
                                            ticks: {
                                                beginAtZero: true
                                            }
                                        }],
                                        xAxes: [{
                                            type: 'category',
                                            afterFit: function(me) {
                                                me.paddingLeft = 0;
                                                me.paddingRight = 0;
                                           } 
                                        }],
                                    }
                                }
                            });
                        </script>
                    <%}
                }
            }
        }%>

    <script>
        const chartCheckboxes = document.querySelectorAll(".chart-checkbox");  // Select all checkboxes

        chartCheckboxes.forEach(checkbox => {
          checkbox.addEventListener("change", function() {
            const chartId = "myChart" + this.id; 
            const chartElement = document.getElementById(chartId);

            if (this.checked) {
              chartElement.style.display = "block";
            } else {
              chartElement.style.display = "none";
            }
          });
        });
    </script>
    
</html>