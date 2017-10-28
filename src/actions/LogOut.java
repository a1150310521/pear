package actions;
import com.opensymphony.xwork2.Action;  
import com.opensymphony.xwork2.ActionContext; 
import com.opensymphony.xwork2.ActionSupport;
import java.util.*;
public class LogOut extends ActionSupport{
  public String execute(){
    ActionContext.getContext().getSession().remove("username");
    return "success";
  }
}
