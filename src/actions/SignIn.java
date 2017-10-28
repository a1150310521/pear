package actions;
import connect.DBconnect;
import com.opensymphony.xwork2.Action;  
import com.opensymphony.xwork2.ActionContext; 
import com.opensymphony.xwork2.ActionSupport;
import java.util.*;
import java.io.*;
import java.sql.*;
public class SignIn extends ActionSupport {
  private String username;
  private String password;
  
  public String getUsername(){
    return this.username;
  }
  
  public void setUsername(String a){
    this.username = a;
  }
  
  public String getPassword(){
    return this.password;
  }
  
  public void setPassword(String a){
    this.password = a;
  }
  
  public String execute() throws Exception {
    try{
      Connection conn = DBconnect.getConnection();
      String sql = "select * from User where username=\'"+this.getUsername()+"\'";
      Statement stmt = conn.createStatement();
      ResultSet rs = stmt.executeQuery(sql);
      if(rs.next()){
        System.out.println("here1");
        System.out.println(this.getUsername());
        System.out.println(this.getPassword());
        System.out.println(rs.getString("password"));
        if(rs.getString("password").equals(this.getPassword())){
          System.out.println("here");
          System.out.println(this.getUsername());
          Map<String,Object> session = ActionContext.getContext().getSession();
          session.put("username", this.getUsername());
          return "signedin";
        }
      }
      return "fail";
    }catch(ClassNotFoundException e){
      e.printStackTrace();
      return "error";
    }catch(SQLException e){
      e.printStackTrace();
      return "error";
    }
  }
}
