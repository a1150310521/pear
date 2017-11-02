package actions;
import connect.DBconnect;
import com.opensymphony.xwork2.Action;  
import com.opensymphony.xwork2.ActionContext; 
import com.opensymphony.xwork2.ActionSupport;
import java.util.*;
import java.io.*;
import java.sql.*;
public class AddPackage extends ActionSupport{
  private String packagename;
  
  public void setPackagename(String a){
    this.packagename = a;
  }
  
  public String getPackagename() {
    return this.packagename;
  }
  
  public String execute() throws Exception{
    try{
    String user = ActionContext.getContext().getSession().get("username").toString();
    Connection conn  = DBconnect.getConnection();
    String sql = "insert into Package(packagename,username) values(?,?)";
    PreparedStatement ps = conn.prepareStatement(sql);
    ps.setString(1,this.getPackagename());
    ps.setString(2,user);

    ps.executeUpdate();
    ps.close();
    conn.close();
    return "success";}catch(Exception  e){
      e.printStackTrace();
      return ERROR;
      
  }
  }
}
