package actions;


import connect.DBconnect;
import connect.FileTuility;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import java.util.*;
import java.io.*;
import java.sql.*;


public class GitBlame  extends ActionSupport{
  private String repomaster;
  private String reponame;
  private String githubname1;
  private String githubname2;
  private String githubname3;

  public String getRepomaster(){
    return this.repomaster;
  }

  public void setRepomaster(String a){
    this.repomaster = a;
  }

  public String getReponame(){
    return this.reponame;
  }

  public void setReponame(String a){
    this.reponame = a;
  }

  public String getGithubname1(){
    return this.githubname1;
  }

  public void setGithubname1(String a){
    this.githubname1  = a;
  }
  public String getGithubname2(){
    return this.githubname2;
  }

  public void setGithubname2(String a){
    this.githubname2  = a;
  }
  public String getGithubname3(){
    return this.githubname3;
  }

  public void setGithubname3(String a){
    this.githubname3  = a;
  }
}
