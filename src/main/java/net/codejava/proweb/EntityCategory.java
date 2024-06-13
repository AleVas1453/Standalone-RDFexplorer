/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package net.codejava.proweb;

/**
 *
 * @author alevas
 */
public class EntityCategory {
    
    private String name; 
    private String iconFile;
    private String count_query;
    private String uriName;
    private String info;
    private String details;

    public EntityCategory(String name, String iconFile, String count_query, String uriName, String info, String details) {
        this.name = name;
        this.iconFile = iconFile;
        this.count_query = count_query;
        this.uriName = uriName;
        this.info = info;
        this.details = details;
    }


    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }

    public String getIconFile() {
        return iconFile;
    }
    public void setIconFile(String iconFile) {
        this.iconFile = iconFile;
    }

    public String getCount_query() {
        return count_query;
    }
    public void setCount_query(String count_query) {
        this.count_query = count_query;
    }

    public String getUriName() {
        return uriName;
    }
    public void setUriName(String uriName) {
        this.uriName = uriName;
    }
    
    public String getInfo(){
        return info;
    }
    public void setInfo(String info){
        this.info = info;
    }

    public String getDetails() {
        return details;
    }
    public void setDetails(String details) {
        this.details = details;
    }
    
}