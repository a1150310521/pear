package actions;

import java.util.ArrayList;   
import java.util.List;
import java.util.HashMap;  
import java.util.Map;
import net.sf.json.JSONObject; 
import beans.ProjectBean;
import beans.StudentBean;
import connect.DBconnect;
import com.opensymphony.xwork2.Action;  
import com.opensymphony.xwork2.ActionContext; 
import com.opensymphony.xwork2.ActionSupport;
import java.util.*;
import java.io.*;
import java.sql.*;

public class AddProject extends ActionSupport{
  private ProjectBean project;
  private List<ProjectBean> proList;
  
  //×´Ì¬Âë
  private String state;
  
  public AddProject(){
    System.out.println("ajax strut");
    project = new ProjectBean();
    proList = new ArrayList<ProjectBean>();
    System.out.println("ajax strut");
  }
  
  public void setState(String a){
    this.state = a;
  }
  public String getState(){
    return this.state;
  }
  
  public void setProList(List<ProjectBean> a){
    this.proList = a;
  }
  public List<ProjectBean> getProList(){
    return this.proList;
  }
  public void setProject(ProjectBean a){
    this.project = a;
  }
  public ProjectBean getProject(){
    return this.project;
  }
  
  public String AddOne() throws Exception{
    System.out.println("ajax addproject");
    try{
      String user = ActionContext.getContext().getSession().get("username").toString();
      System.out.println(user+'1');
      if(!user.equals("")){
        this.project.setUsername(user);
      
        Connection conn = DBconnect.getConnection();
        String sql = "insert into Project(projectname,reponame,repomaster,username,packagename) values(?,?,?,?,?)";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, this.project.getProjectname());
        ps.setString(2, this.project.getReponame());
        ps.setString(3, this.project.getRepomaster());
        ps.setString(4, this.project.getUsername());
        ps.setString(5, this.project.getPackagename());
        
        ps.executeUpdate();
        ps.close();
        
        List<StudentBean> stuList = this.project.getStudents();
        sql = "insert into Student(id,name,githubname,reponame,repomaster,leadername) values(?,?,?,?,?,?)";
        for(int i =0 ;i<stuList.size() ;i++){
          ps = conn.prepareStatement(sql);
          ps.setString(1,stuList.get(i).getId());
          ps.setString(2, stuList.get(i).getName());
          ps.setString(3, stuList.get(i).getGithubname());
          ps.setString(4, this.project.getReponame());
          ps.setString(5, this.project.getRepomaster());
          ps.setString(6, project.getUsername());
          
          ps.executeUpdate();
          ps.close();
        }
        conn.close();
        this.state = "success";
        return "success";
      }
      else{
        this.state = "logout";
        return "logout";
      }
    }catch(Exception e){
      e.printStackTrace();
      this.state = "error";
      return "error";
    }
    
  }
  

}

