package actions;

import java.text.ParseException;

import java.text.SimpleDateFormat;
import java.util.Date;

import java.io.BufferedReader;    
import java.io.IOException;    
import java.io.InputStreamReader; 

import java.util.ArrayList;   
import java.util.List;
import java.util.HashMap;  
import java.util.Map;
import net.sf.json.JSONObject; 


import beans.CommitBean;
import connect.DBconnect;
import connect.FileTuility;

import com.opensymphony.xwork2.Action;  
import com.opensymphony.xwork2.ActionContext; 
import com.opensymphony.xwork2.ActionSupport;
import java.util.*;
import java.io.*;
import java.sql.*;


import beans.CommitBean;
public class AllCommits extends ActionSupport{
    private String repomaster;
    private String reponame;
    private List<CommitBean> commitList;
    

    
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
    public void setCommitList(List<CommitBean> commitList){
        this.commitList = commitList;
    }
    public List<CommitBean> getCommitList(){
        return this.commitList;
    }
    
    
    
    
    //¸¨Öú·½·¨
    public CommitBean parseLineOne(CommitBean cb,String line){
      
      SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
      String[] formatMsg = line.split("&");
      for(int i=0;i<5;i++){
        String[] temp = formatMsg[i].split("=");
        if(i==0){
          cb.setCommiter(temp[1]);
        }
        
        if(i==1){
          try{
            Date date = sdf.parse(temp[1]);
            cb.setDate(date);
          }catch(ParseException e){
            e.printStackTrace();
          }
        }
        
        if(i==2){
          cb.setMessage(temp[1]);
        }
        
        if(i==3){
          cb.setSha(temp[1]);
        }
        if(i==4){
          List<String> fa = new ArrayList<String>();
          if(temp.length>1){
            String[] fathers = temp[1].split(" ");
            for(int j=0;j<fathers.length;j++){
              fa.add(fathers[j]);
            }
          }
          
          
          cb.setFatherSha(fa);
        }
      }
      return cb;
    }
    
    public CommitBean parseLineTwo(CommitBean cb,String line){
      String[] intMsg = line.split(",");
      for(int i=0;i<intMsg.length;i++){
        String[] temp = intMsg[i].split(" ");
        
        if(intMsg[i].contains("changed")){
          cb.setChangedFiles(Integer.parseInt(temp[1]));
        }
        else if(intMsg[i].contains("deletions")){
          cb.setDeleLines(Integer.parseInt(temp[1]));
        }
        else if(intMsg[i].contains("insertions")){
          cb.setAddLines(Integer.parseInt(temp[1]));
        }
      }
      return cb;
    }
    
    


    public String execute() throws Exception{
      String user = ActionContext.getContext().getSession().get("username").toString();
      
      try{
        String dir = connect.FileTuility.getCurrentDir();
        //@dir user path
        dir = dir + "\\gitfiles"+"\\"+user;
        System.out.println(dir);
        //@dir1 repomaster path
        String dir1  = dir+"\\"+this.repomaster;
        //@repoDir repo path
        String repoDir = dir1+ "\\"+this.reponame;
        connect.FileTuility.createDir(dir1);
        Process process =  Runtime.getRuntime().exec("git clone https://github.com/"+repomaster+"/"+reponame,null,new File(dir1));
        process.waitFor();
        //BufferedReader input0 = new BufferedReader(new InputStreamReader(process.getInputStream()));
        System.out.println("cloned");
        process = Runtime.getRuntime().exec("git log --all --shortstat --date=iso --pretty=format:\"commiter=%cn&date=%cd&msg=%s&sha=%h&fatherSha=%p\"",null,new File(repoDir));
        BufferedReader input = new BufferedReader(new InputStreamReader(process.getInputStream()));
        String line = "";
        
        int i = 0;
        commitList = new ArrayList<CommitBean>();
        
        while((line = input.readLine())!=null){
          CommitBean cb = new CommitBean();
          
          cb = parseLineOne(cb,line);
          
          line = input.readLine();
          
          cb = parseLineTwo(cb,line);
          commitList.add(cb);
          line = input.readLine();
          
           
        }
        
        //user dir has too many files ,delete 
        if(connect.FileTuility.countFiles(dir)>10){
          connect.FileTuility.deleteDir(dir);
        }
        
        
        }catch(IOException e){
          e.printStackTrace();
        }catch(InterruptedException e){
          e.printStackTrace();
        }
      
      return "success";
        
    }

}

