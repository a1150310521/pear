package actions;

import java.util.ArrayList;   
import java.util.List;
import java.util.HashMap;  
import java.util.Map;

import beans.ProjectBean;

import connect.DBconnect;
import com.opensymphony.xwork2.Action;  
import com.opensymphony.xwork2.ActionContext; 
import com.opensymphony.xwork2.ActionSupport;
import java.util.*;
import java.io.*;
import java.sql.*;

public class DeleteAction extends ActionSupport{
  private String repomaster;
  private String reponame;
  private String projectname;
  private String packagename;
  
  public void setRepomaster(String a){
    this.repomaster = a;
  }
  public String getRepomaster(){
    return this.repomaster;
  }
  
  public void setReponame(String a){
    this.reponame = a;
  }
  public String getReponame(){
    return this.reponame;
  }
  
  public void setProjectname(String a){
    this.projectname = a;
  }
  public String getProjectname(){
    return this.projectname;
  }
  
  public void setPackagename(String a){
    this.packagename = a;
  }
  public String getPackagename(){
    return this.packagename;
  }
  
  public String deleteProject() throws Exception{
    try{
      String user = ActionContext.getContext().getSession().get("username").toString();
      Connection conn  = DBconnect.getConnection();
      String sql = "delete from Student where reponame=? and repomaster=? and leadername=?";
      PreparedStatement ps = conn.prepareStatement(sql);
      ps.setString(1,this.reponame);
      ps.setString(2,this.repomaster);
      ps.setString(3,user);
      ps.executeUpdate();
      ps.close();

      sql = "delete from Project where reponame=? and repomaster=?";
      ps = conn.prepareStatement(sql);
      ps.setString(1,this.reponame);
      ps.setString(2,this.repomaster);
      ps.executeUpdate();
      ps.close();
      conn.close();

    }catch(Exception e){
      e.printStackTrace();
    }
    return "success";
  }


  public String deletePackage() throws Exception{
    try{
      String user = ActionContext.getContext().getSession().get("username").toString();
      Connection conn  = DBconnect.getConnection();
      String sql = "select * from Project where packagename=? and username=?";
      PreparedStatement ps = conn.prepareStatement(sql);
      ps.setString(1,packagename);
      ps.setString(2,user);
      
      ResultSet rs = ps.executeQuery();
      while(rs.next()){
        //delete projects in THE package
        projectname = rs.getString("projectname");
        reponame = rs.getString("reponame");
        repomaster = rs.getString("repomaster");

        deleteProject();
      }
      rs.close();
      ps.close();

      sql = "delete from Package where username=? and packagename=?";
      ps = conn.prepareStatement(sql);
      ps.setString(1,user);
      ps.setString(2,packagename);
      ps.executeUpdate();

      ps.close();
      conn.close();
      
    }catch(Exception e){
      e.printStackTrace();
    }
    
    
    return "success";
  }
  
  
}
