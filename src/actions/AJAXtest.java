package actions;

import java.io.BufferedReader;    
import java.io.IOException;    
import java.io.InputStreamReader;  

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

public class AJAXtest {
  

  public static void gitClone(String dir){
  	try{
  		Process process =  Runtime.getRuntime().exec("git clone https://github.com/a1150310521/pear",null,new File(dir));
  		BufferedReader input = new BufferedReader(new InputStreamReader(process.getInputStream()));
  		String line = "";
  		while((line = input.readLine())!=null){
  			System.out.println(line);
  		}
  		System.out.println("git clone over");
  	}catch(IOException e){
  		e.printStackTrace();
  	}
  }
  //鑾峰彇褰撳墠鐩綍
  public static String getCurrentDir(){
  	try{
  		File dir = new File(".");
  		return dir.getCanonicalPath();
  	}catch(IOException e){
      e.printStackTrace();
      return "//fail";
    }
  }

  //鏂板缓鏂囦欢鐩綍
  public static boolean createDir(String dir){
  	boolean result = false;
  	File file = new File(dir);
  	if(!file.exists()){
  		result = file.mkdirs();
  	}
  	return result;
  }

  //鍒犻櫎鐩綍鍙婁笅闈㈡墍鏈夋枃浠�
  public static boolean deleteDir(String dir){
    
  	File file = new File(dir);
  	if(!file.exists()){
  		return false;
  	}

  	if(file.isFile()){
  		file.delete();
  	}
  	else if(file.isDirectory()){
  		File[]  files = file.listFiles();
  		for(File i:files){
  			deleteDir(i.getAbsolutePath());
  		}
  		file.delete();
  	}
  	return true;
  }

  public static void main(String args[]){
    String dir = getCurrentDir();
    
    dir += "\\testuser";
   
    createDir(dir);
    gitClone(dir);
    System.out.println("start deleete");
     deleteDir(dir);
  }

}

