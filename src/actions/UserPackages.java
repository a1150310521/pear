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

public class UserPackages extends ActionSupport{
	private String packages;
	
	public String getPackages(){
	  return this.packages;
	}
	
	public void setPackages(String a){
	  this.packages = a;
	}


	public String execute() throws Exception{
		String user = ActionContext.getContext().getSession().get("username").toString();
		System.out.println(user);
		List<String> list = new ArrayList<String>();
		String packagename = null;
		if(user != null){
			Connection conn = DBconnect.getConnection();
			String sql = "select * from Package where username=\'" +user+ "\'";
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			while(rs.next()){
				packagename = rs.getString("packagename");
				list.add(packagename);
			}
			JSONObject jo = new JSONObject();
		    jo.element("packages",list);
		    this.setPackages(jo.toString());
			
			rs.close();
			stmt.close();
			conn.close();
		}
		return "success";
	}

}
