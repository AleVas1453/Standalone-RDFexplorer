<%@page import="java.util.Arrays"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="net.codejava.proweb.Configuration"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="net.codejava.proweb.EntityCategory"%>
<%@page import="net.codejava.proweb.RDFReader"%>

<%
    String selectedCategory = request.getParameter("obj");
    String chartParam = request.getParameter("chartParam");
    String URIDetails = request.getParameter("URIDetails");
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
        <script src="https://cdn.jsdelivr.net/npm/ag-grid-community/dist/ag-grid-community.min.js"></script>
        <!--<script type="module" src="https://cdn.jsdelivr.net/npm/chart.js"></script>-->
        <!--<script type="module" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.min.js"></script>-->
        <!--<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.7.0/chart.min.js"></script>-->
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.3/Chart.min.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"/>

    </head>
    <body>

        <div>
            <% for (EntityCategory category : categories) {%>
            <a class="links" href="?obj=<%= category.getUriName().trim()%>"> 
                <%= category.getName()%> (<%= myReader.countCateg(category.getCount_query())%>)
            </a><br/><%}%>
        </div>
        
        
        <div id="myGrid" class="ag-theme-quartz" style="height: 500px; max-width: 980px; "></div> 
 
        <div>    
            <% for (EntityCategory category : categories) {
                if (selectedCategory != null && selectedCategory.equals(category.getUriName().trim())) {
                    ArrayList<Map<String, String>> results = myReader.categInstances(category.getDetails());
                    if (!results.isEmpty()) {
                        for (Map<String, String> result : results) {
                            if (URIDetails != null && URIDetails.equals(result.get("URI").trim())) {%>                                
                                <style>
                                    .ag-theme-quartz{
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
        
        <!-- Add class="ag-theme-quartz, so I can hide it when I get in URL with the URI (No other reason to use this class inside the form) -->
        <form id="myform" class="ag-theme-quartz">Charts:
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
              chartElement.style.display = "block"; // Here display the chart, because checkbox is checked
            } else {
              chartElement.style.display = "none"; // Here DOESN'T display the chart
            }
          });
        });
    </script>
    
    
    <script>
        const gridOptions = 
        {
            columnDefs: 
            [
                <% for (EntityCategory category : categories) {
                    if (selectedCategory != null && selectedCategory.equals(category.getUriName().trim())) {
                        ArrayList<Map<String, String>> results = myReader.categInstances(category.getInfo());
                        if (!results.isEmpty()) {
                            Map<String, String> firstName = results.get(0);
                            for (String column : firstName.keySet()) {
                                String value = firstName.get(column);
                                if (myReader.isDate(value)) {%>
                                {
                                    field: "<%= column%>",
                                    filter: "agDateColumnFilter",
                                },
                                <% } else if (myReader.isNumeric(value)) {%>
                                {
                                    field: "<%= column%>",
                                    filter: "agNumberColumnFilter",
                                },
                                <% } else {%>
                                {
                                    field: "<%= column%>",
                                    filter: "agTextColumnFilter",
                                },
                                <%}%>
                            <%}%>    
                                {   field: "More",
                                    cellRenderer: function(params) {
                                        const uriValue = params.data.URI; // Access the value of the "URI" field
                                        return '<a href="?obj=<%= category.getUriName().trim() %>&URIDetails='+uriValue+'">More info</a>';
                                      }
                                },
                        <%}
                    }
                }%>
            ],
            rowData: 
            [
                <% for (EntityCategory category : categories) {
                    if (selectedCategory != null && selectedCategory.equals(category.getUriName().trim())) {
                        ArrayList<Map<String, String>> results = myReader.categInstances(category.getInfo());
                        if (!results.isEmpty()) {
                            for (Map<String, String> result : results) {%>
                            {
                                <%for (String column : result.keySet()) {%>
                                    <%= column%>: "<%= result.get(column)%>",
                                    
                                    <%if(column.equals("URI")){%>
                                        More: "<%= result.get(column)%>",//"More" is useless, here
                                    <%}%>
                                <% } %>
                            },
                            <%}
                        }
                    }
                }%>
            ],
            pagination: true,
        };
        
        const myGridElement = document.querySelector('#myGrid');
        agGrid.createGrid(myGridElement, gridOptions);
    </script>


    
</html>