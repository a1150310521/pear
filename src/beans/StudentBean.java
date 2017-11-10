package beans;

public class StudentBean {
  private String id;
  private String name;
  private String githubname;
  
  private String reponame;
  private String repomaster;
  private String leader;
  
  public void setReponame(String a){
    this.reponame = a;
  }
  public String getReponame(){
    return this.reponame;
  }
  
  public void setRepomaster(String a){
    this.repomaster = a;
  }
  
  public String getRepomaster(){
    return this.repomaster;
  }
  public void setLeader(String a){
    this.leader = a;
  }
  public String getLeader(){
    return this.leader;
  }
  
  public void setId(String a){
    this.id = a;
  }
  public String getId(){
    return this.id;
  }
  
  public void setName(String a){
    this.name = a;
  }
  public String getName(){
    return this.name;
  }
  
  public void setGithubname(String a){
    this.githubname = a;
  }
  public String getGithubname(){
    return this.githubname;
  }

}
