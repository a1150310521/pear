package actions;
import connect.DBconnect;
import java.sql.*;
import com.opensymphony.xwork2.*;
public class Search {
  public static void main(String args[])throws Exception{
    try{
      Connection conn = DBconnect.getConnection();
      Statement stmt = conn.createStatement();
      String sql = "select * from User where username=\'testuser\'";
      ResultSet rs = stmt.executeQuery(sql);
      while(rs.next()){
        System.out.println(rs.getString("password"));;
      }
    }catch(ClassNotFoundException e){
      e.printStackTrace();
    
  }catch(SQLException e){
      e.printStackTrace();
      
  }
    
    
  }
}
