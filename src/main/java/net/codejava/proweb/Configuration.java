/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package net.codejava.proweb;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Properties;

/**
 *
 * @author alevas
 */
public class Configuration {

    private String welcomeTitle;
    private String title;
    private String subtitle;
    private String description;

    public Configuration() {

    }

    public String getWelcomeTitle() {
        return welcomeTitle;
    }

    public void setWelcomeTitle(String welcomeTitle) {
        this.welcomeTitle = welcomeTitle;
    }
    
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }

    public String getSubtitle() {
        return subtitle;
    }
    public void setSubtitle(String subtitle) {
        this.subtitle = subtitle;
    }

    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
    }

    Properties prop = new Properties();

    public ArrayList<EntityCategory> chooseCat() {

        ArrayList<EntityCategory> allCateg = new ArrayList<>();

        Properties prop = new Properties();

        try {
            prop.load(getClass().getResourceAsStream("config.properties"));

            String categories = prop.getProperty("categories");   // categories = “1,2,3”
            String categoryIds[] = categories.split(",");  // [“1”, “2”, “3”]
            for (String catId : categoryIds) {
                String categName    = prop.getProperty("categories." + catId + ".name");
                String categIcon    = prop.getProperty("categories." + catId + ".icon");
                String categCountQr = prop.getProperty("categories." + catId + ".count_query");
                String categUriName = prop.getProperty("categories." + catId + ".uriName");
                String categInfo    = prop.getProperty("categories." + catId + ".info");
                String categDetails = prop.getProperty("categories." + catId + ".details");
                EntityCategory category = new EntityCategory(categName, categIcon, categCountQr, categUriName, categInfo, categDetails);
                allCateg.add(category);
                System.out.println("INFO"+categInfo);
            }
        } catch (IOException ex) {
            ex.printStackTrace();
        }

        return allCateg;
    }

    public void appInfo() {

        try {
            prop.load(getClass().getResourceAsStream("config.properties"));
            
            setWelcomeTitle(prop.getProperty("application.welcomeTitle"));
            setTitle(prop.getProperty("application.title"));
            setSubtitle(prop.getProperty("application.subtitle"));
            setDescription(prop.getProperty("application.description"));

        } catch (IOException ex) {
            ex.printStackTrace();
        }

    }
}
