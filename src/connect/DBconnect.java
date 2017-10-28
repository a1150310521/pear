package connect;
import java.sql.*; 
public class DBconnect {
  public static Connection getConnection() throws Exception{
    try{
      Class.forName("com.mysql.jdbc.Driver");
      String url = "jdbc:mysql://localhost:3306/peardb?useUnicode=true&characterEncoding=utf-8&useSSL=false";
      Connection conn = DriverManager.getConnection(url,"mushroom","adminmushroom");
      return conn;
      }catch(SQLException e){
        e.printStackTrace();
        return null;
      }
  }
}
