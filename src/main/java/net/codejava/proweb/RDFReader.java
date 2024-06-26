/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package net.codejava.proweb;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.NoSuchElementException;
import java.util.Properties;
import org.apache.jena.query.Query;
import org.apache.jena.query.QueryExecution;
import org.apache.jena.query.QueryExecutionFactory;
import org.apache.jena.query.QueryFactory;
import org.apache.jena.query.QuerySolution;
import org.apache.jena.query.ResultSet;
import org.apache.jena.rdf.model.Literal;
import org.apache.jena.rdf.model.Model;
import org.apache.jena.rdf.model.ModelFactory;
import org.apache.jena.rdf.model.RDFNode;
import org.apache.jena.riot.RDFDataMgr;

/**
 *
 * @author alevas
 */
public class RDFReader {

    Model model;

    public RDFReader() {

    }

    /**
     * Method to load data|(RDF files)
     *
     * @return each model's data
     */
    public Model loadModel() {
        String path = getClass().getResource("").getPath();
        System.out.println(path);
        String folderPath = path + "SeaLiT";
        File folder2 = new File(folderPath);

        File[] listOfFiles2 = folder2.listFiles();
        getModel();
        /* (Me ayto isws otan to pairnei na exei ta proigoumena data) */
        model = ModelFactory.createDefaultModel();
        for (File file2 : listOfFiles2) {

            File folder = new File(file2.getPath());

            File[] listOfFiles = folder.listFiles();
            if (listOfFiles != null) {
                for (File file : listOfFiles) {
                    if (file.isFile() && file.getName().endsWith(".trig")) {
                        try {
                            InputStream inStream = RDFDataMgr.open(file.getPath());
                            model.read(inStream, null, "TRIG");/* Diavazw ta dedomena se typo TRIG */
                        } catch (NoSuchElementException e) {
                            e.printStackTrace();
                        }
                    }
                }
            }
        }
        return model;
    }

    public ArrayList<Map<String, String>> categInstances(String info) {
        int xxx=0;
        String queryString = info;
        Query query = QueryFactory.create(queryString);
        QueryExecution qexec = QueryExecutionFactory.create(query, getModel());
        ResultSet results = qexec.execSelect();
        ArrayList<Map<String, String>> resultsList = new ArrayList<>();
        while (results.hasNext()) {
//            xxx++;
//            if(xxx==12){
//                break;
//            }
            QuerySolution soln = results.nextSolution();
            Iterator<String> selectVars = soln.varNames();
            Map<String, String> columnToValue = new HashMap<>();

            while (selectVars.hasNext()) {
                String selectName = selectVars.next();
                RDFNode node = soln.get(selectName);
                columnToValue.put(selectName, node.toString());
            }
            resultsList.add(columnToValue);
        }
        return resultsList;
    }
    

    public ArrayList<Map<String, String>> categInstances(String info, int limit, int currentPage) {
        String queryString = info;
        Query query = QueryFactory.create(queryString);
        QueryExecution qexec = QueryExecutionFactory.create(query, getModel());
        ResultSet results = qexec.execSelect();
        ArrayList<Map<String, String>> resultsList = new ArrayList<>();
        
        // Calculate the starting/ending position of the current page
        int start = (currentPage - 1) * limit;
        int end = currentPage * limit;
        
        //This is the current row of the table that will be dispalyed 
        int currentPosition = 0;
        while (results.hasNext()) {
            QuerySolution soln = results.nextSolution();

            if (currentPosition >= start && currentPosition < end) {
                Iterator<String> selectVars = soln.varNames();
                Map<String, String> columnToValue = new HashMap<>();

                while (selectVars.hasNext()) {
                    String selectName = selectVars.next();
                    RDFNode node = soln.get(selectName);
                    columnToValue.put(selectName, node.toString());
                }
                resultsList.add(columnToValue);
            }
            
            //The number of the rows, that occurs from the "limit", has been completed
            if (currentPosition >= end) {
                break; 
            }

            currentPosition++;
        }
        return resultsList;
    }


    public String[] configProperties() {
        Properties prop = new Properties();
        try {
            prop.load(getClass().getResourceAsStream("config.properties"));
            
            String welcomeTitle =   prop.getProperty("application.welcomeTitle");
            String title        =   prop.getProperty("application.title");
            String subtitle     =   prop.getProperty("application.subtitle");
            String description  =   prop.getProperty("application.description");

            String categories = prop.getProperty("categories");   // categories = “1,2,3”
            String categoryIds[] = categories.split(",");  // [“1”, “2”, “3”]
            System.out.println(categories);
            System.out.println(categoryIds);
            for (String catId : categoryIds) {
                String category_name = prop.getProperty("categories." + catId + ".name");
                String category_icon = prop.getProperty("categories." + catId + ".icon");
                System.out.println(category_name);
                System.out.println(category_icon);
                System.out.println(catId);
            }

            //get the property value and print it out
            System.out.println(welcomeTitle);
            System.out.println(title);
            System.out.println(subtitle);
            System.out.println(description);
            return categoryIds;

        } catch (IOException ex) {
            ex.printStackTrace();
        }

        return null;
    }

    /**
     *
     * @param count_query
     * @return Number of the times that a category exists in .trig
     * files(Database)
     */
    public String countCateg(String count_query) {

        String queryString = count_query;

        Query query = QueryFactory.create(queryString);
        QueryExecution qexec = QueryExecutionFactory.create(query, model);

        ResultSet results = qexec.execSelect();

        if (results.hasNext()) {
            QuerySolution soln = results.nextSolution();
            Literal number = soln.getLiteral("num");
            return String.valueOf(number.getValue());
        }

        return "0";
    }
    
    public int intCount(String counterr){
        return Integer.parseInt(counterr);
    }
    
    /**
     * 
     * @param counter Occurs from countCateg method for each category
     * @param limit
     * @return 
     */
    public int totalPages(int counterr, int limit){
        
        int totalEntities = counterr;
        int totalPages = (int) Math.ceil((double) totalEntities / limit);
        return totalPages;
    }

/**
 * 
 * @param list
 * @param column
 * @return Map that has as key a label and as value the number of occurrences in a file
 */
    public Map<String, Integer> counter(ArrayList<Map<String, String>> list, String column) {
        Map<String, Integer> countData = new HashMap<>();

        for (Map<String, String> results : list) {
            for (String key : results.keySet()) {
                if(key == column){
                    String value = results.get(key);
                    value = value.replace("'", "-");
                    if (value != null && !value.isEmpty()) {
                        if (countData.containsKey("'"+value+"'")) {
                            countData.put("'"+value+"'", countData.get("'"+value+"'") + 1);
                        } else {
                            countData.put("'"+value+"'", 1);
                        }
                    }
                }
            }
        }
//            System.out.println("SIZE: " + countData.size());
        for (Map.Entry<String, Integer> entry : countData.entrySet()) {
//            System.out.println("Value: " + entry.getKey() + ", Count: " + entry.getValue());
        }

        return countData;
    }  
    

    /**
     * Creates an Array that includes only the values of a Map
     * @param sum
     * @return an integer with values
     */
    public  Integer[] converter(Map<String, Integer> sum) {
        ArrayList<Integer> valuesList = new ArrayList<>();
        
        for (Integer value : sum.values()) {
            valuesList.add(value);
        }
        
        Integer[] valuesArray = new Integer[valuesList.size()];
        valuesArray = valuesList.toArray(valuesArray);
        
        return valuesArray;
    }
            
    public Map<String, String> details(String details_query){
        
        String queryString = details_query;
        
        Query query = QueryFactory.create(queryString);
        QueryExecution qexec = QueryExecutionFactory.create(query, getModel());
        ResultSet results = qexec.execSelect();
        Map<String, String> detailsMap = new HashMap<>();

        if(results.hasNext()) {
            QuerySolution soln = results.nextSolution();
            
            Iterator<String> varNames = soln.varNames();
            while (varNames.hasNext()) {
                String varName = varNames.next();
                RDFNode node = soln.get(varName);
                if (node != null) {
                    detailsMap.put(varName, node.toString());
                }
            }
        }
        qexec.close();
        return detailsMap;
        
    }
    
    public boolean isNumeric(String strNum) {
    return strNum.matches("^[0-9]+$");
    }

    public boolean isDate(String strDate) {
        return strDate.matches("^\\d{4}-\\d{2}-\\d{2}$");
    }

    public Model getModel() {
        return model;
    }

    public void setModel(Model model) {
        this.model = model;
    }

}
