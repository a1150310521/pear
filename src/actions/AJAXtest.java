package actions;
import java.util.ArrayList;   
import java.util.List;
import java.util.HashMap;  
import java.util.Map;  
  
import net.sf.json.JSONObject;  
import beans.ProjectBean;
import com.opensymphony.xwork2.ActionSupport; 
import beans.ProjectBean;
public class AJAXtest extends ActionSupport{
  private String username;
  private List<ProjectBean> projectList;
  
  private String result;
  
  public void setResult(String a){
    this.result = a;
  }
  
  public String getResult(){
    return this.result;
  }
  
  
  public void setUsername(String a){
    this.username = a;
  }
  public void setProjectList(List<ProjectBean> a){
    this.projectList = a;
  }
  
  public String getUsername(){
    return this.username;
  }
  
  public List<ProjectBean> getProjectList(){
    return this.projectList;
  }
  
  public String execute()  {
    Map<String,Object> map = new HashMap<String,Object>();
    List<ProjectBean> list = new ArrayList<ProjectBean>();
    System.out.println(this.getUsername());
    System.out.println("here");
    for(int i=0;i<5;i++)
    {
      ProjectBean pb = new ProjectBean();
      pb.setProjectname("erwffwf");
      pb.setRepomaster("dsdwdad");
      pb.setReponame("dsf");
      pb.setUsername("dfsd");
      
      list.add(pb);
    }
    map.put("repos", list);
    map.put("username", this.getUsername());
    JSONObject jo = new JSONObject();
    jo.element("repo", map);
    this.setResult(jo.toString());
    System.out.println(this.getResult());
    return "success";
  }
}
