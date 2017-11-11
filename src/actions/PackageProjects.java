package actions;

import java.util.ArrayList;   
import java.util.List;
import java.util.HashMap;  
import java.util.Map;  
  
import net.sf.json.JSONObject;  
import connect.DBconnect;
import com.opensymphony.xwork2.Action;  
import com.opensymphony.xwork2.ActionContext; 
import com.opensymphony.xwork2.ActionSupport;
import java.util.*;
import java.io.*;
import java.sql.*;

import beans.ProjectBean;
import beans.StudentBean;

public class PackageProjects extends ActionSupport{
  private String projects;
  private String packagename;
  
  public String getPackagename(){
    return this.packagename;
  }
  
  public void setPackagename(String a){
    this.packagename = a;
  }
  public String getProjects(){
    return this.projects;
  }
  
  public void setProjects(String a){
    this.projects = a;
  }
  
  public String execute() throws Exception{
    String user = ActionContext.getContext().getSession().get("username").toString();
    System.out.println(user);
    List<ProjectBean> proList = new ArrayList<ProjectBean>();
    
    if(user != null){
        Connection conn = DBconnect.getConnection();
        String sql = "select * from Project where username=\'" +user+ "\' and packagename=\'" +this.packagename+ "\'";
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(sql);
        while(rs.next()){
          ProjectBean pb = new ProjectBean();
          
          pb.setProjectname(rs.getString("projectname"));
          pb.setRepomaster(rs.getString("repomaster"));
          pb.setReponame(rs.getString("reponame"));
          
          sql = "select * from Student where reponame=\'" +pb.getReponame()
            + "\' and repomaster=\'" + pb.getRepomaster() +"\' and leadername=\'" +user + "\'";
          Statement stmt1 = conn.createStatement();
          ResultSet rs1 = stmt1.executeQuery(sql);
          List<StudentBean> stuList  = new ArrayList<StudentBean>();
          while(rs1.next()){
            StudentBean sb = new StudentBean();
            sb.setGithubname(rs1.getString("githubname"));
            sb.setId(rs1.getString("id"));
            sb.setName(rs1.getString("name"));
            
            stuList.add(sb);
          }
          
          pb.setStudents(stuList);
          
          proList.add(pb);
          
          rs1.close();
          stmt1.close();
        }
        JSONObject jo = new JSONObject();
        jo.element("projects",proList);
        this.projects = jo.toString();
        
        rs.close();
        stmt.close();
        conn.close();
    }
    return "success";
  }
}
