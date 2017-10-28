package actions;
import connect.DBconnect;
import com.opensymphony.xwork2.Action;  
import java.io.*;
import java.sql.*;
public class SignUp implements Action{
  private String username;
  private String password;
  private String email;
  
  public void setUsername(String a){
    this.username = a;
  }
  public String getUsername(){
    return this.username;
  }

  
  public void setPassword(String a){
    this.password = a;
  }
  public String getPassword(){
    return this.password;
  }
  
  public void setEmail(String a){
    this.email = a;
  }
  public String getEmail(){
    return this.email;
  }
  
  public String execute() throws Exception{
    try{
      Connection conn = DBconnect.getConnection();
      String sql = "insert into User(username,email,password) values(?,?,?)";
      PreparedStatement ps = conn.prepareStatement(sql);
      ps.setString(1, this.getUsername());
      ps.setString(2, this.getEmail());
      ps.setString(3, this.getPassword());
      
      ps.executeUpdate();
      ps.close();
      conn.close();
      
      return "success";
      
    }catch(Exception  e){
      e.printStackTrace();
      return "error";
      }
  }
  
}
