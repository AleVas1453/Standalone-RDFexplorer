/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package net.codejava.proweb;
//javax.enterprise.inject.

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.NoSuchElementException;
import org.apache.jena.rdf.model.Model;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.jena.rdf.model.ModelFactory;
import org.apache.jena.rdf.model.Property;
import org.apache.jena.rdf.model.RDFNode;
import org.apache.jena.rdf.model.Resource;
import org.apache.jena.rdf.model.Statement;
import org.apache.jena.rdf.model.StmtIterator;
import org.apache.jena.riot.RDFDataMgr;

/**
 *
 * @author alevas
 */
@WebServlet(name = "ReadRDF", urlPatterns = {"/ReadRDF"})
public class ReadRDF extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("XZZZZZZZZZ");
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        /* oti mpainei meta to "out." einai kwdikas html */
        try {
            /* TODO output your page here. You may use following sample code. */

            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ReadRDF</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ReadRDF at ReadRDF" + request.getContextPath() + "</h1>");

            System.out.println("X1");
            try {
                System.out.println("###############");
                String path = getClass().getResource("").getPath();
                System.out.println(path);
                String folderPath = path + "SeaLiT"; // Replace with your folder path
                File folder2 = new File(folderPath);

                File[] listOfFiles2 = folder2.listFiles();
                for (File file2 : listOfFiles2) {

                    File folder = new File(file2.getPath());

                    File[] listOfFiles = folder.listFiles();
                    if (listOfFiles != null) {
                        for (File file : listOfFiles) {
                            Model model = ModelFactory.createDefaultModel();
                            if (file.isFile() && file.getName().endsWith(".trig")) {
                                System.out.println("Reading file: " + file.getName());
                                out.println(String.format("<h2><b>%s:</b><br></h2>", file.getName()));
                                try {
                                    InputStream inStream = RDFDataMgr.open(file.getPath());
                                    model.read(inStream, null, "TRIG");/* Diavazw ta dedomena se typo TRIG */

                                    StmtIterator stmtIter = model.listStatements();
                                    while (stmtIter.hasNext()) {
                                        Statement stmt = stmtIter.nextStatement();
                                        Resource subject = stmt.getSubject();
                                        Property predicate = stmt.getPredicate();
                                        RDFNode object = stmt.getObject();
                                        out.println(String.format("<p><b>Resource:</b> %s<br><b> Property: </b> %s <br> <b> Value: </b> %s<br></p>", subject, predicate, object));
//                                        model.write(System.out, "TRIG");      /* Grafw ta dedomena se morfi TRIG */
//                                        model.write(System.out, "RDF/XML");   /* Grafw ta dedomena se morfi RDF/XML */
//                                        model.write(System.out, "TURTLE");    /* Grafw ta dedomena se morfi TURTLE */
//                                        model.write(System.out, "N-QUADS");   /* Grafw ta dedomena se morfi N-QUADS */
//                                        model.write(System.out, "N-TRIPLES"); /* Grafw ta dedomena se morfi N-TRIPLES */
                                    }
                                } catch (NoSuchElementException e) {
                                    e.printStackTrace();
                                }
                            }
                        }
                    }
                }
            } catch (Exception ex) {
                ex.printStackTrace();
                out.println("<h2>Gamitherror reading RDF data</h2>");
            }
            System.out.println("x4");

            out.println("</body>");
            out.println("</html>");
        } finally {
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
