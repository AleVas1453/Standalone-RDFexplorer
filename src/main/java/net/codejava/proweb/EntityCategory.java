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
    private String count_query;
    private String info;
    private String details;

    public EntityCategory(String name, String count_query, String info, String details) {
        this.name = name;
        this.count_query = count_query;
        this.info = info;
        this.details = details;
    }


    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    
    public String getCount_query() {
        return count_query;
    }
    public void setCount_query(String count_query) {
        this.count_query = count_query;
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