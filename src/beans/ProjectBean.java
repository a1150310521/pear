package beans;

import java.util.ArrayList;   
import java.util.List;
import beans.StudentBean;

public class ProjectBean {
  private String projectname;
  private String reponame;
  private String repomaster;
  private String username;
  private List<StudentBean> students;
  
  public void setProjectname(String a){
    this.projectname = a;
  }
  public String getProjectname(){
    return this.projectname;
  }
  
  public void setReponame(String a){
    this.reponame = a;
  }
  public String getReponame(){
    return this.reponame;
  }
  
  public void setRepomaster(String a){
    this.repomaster =  a;
  }
  
  public String getRepomaster(){
    return this.repomaster;
  }
  
  public void setUsername(String a){
    this.username = a;
  }
  public String getUsername(){
    return this.username;
  }
  
  public void setStudents(List<StudentBean> a){
    this.students = a;
  }
  public List<StudentBean> getStudents(){
    return this.students;
  }
}
