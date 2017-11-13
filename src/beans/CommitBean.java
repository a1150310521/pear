package beans;
import java.util.Date;
import java.util.ArrayList;   
import java.util.List;
public class CommitBean {
	private Date date;
	private String commiter;
	private String message;
	private int addLines;
	private int deleLines;
	private int changedFiles;
	
	private String sha;
	private List<String> fatherSha;
	
	public void setSha(String a){
	  this.sha = a;
	}
	public String getSha(){
	  return this.sha;
	}
	
	public void setFatherSha(List<String> a){
	  this.fatherSha = a;
	}
	public List<String> getFatherSha(){
	  return this.fatherSha;
	}


	// setter
	public void setDate(Date date){
		this.date = date;
	}

	public void setCommiter(String commiter){
		this.commiter = commiter;
	}

	public void setMessage(String message){
		this.message = message;
	}
	public void setAddLines(int total){
		this.addLines = total;
	}
	public void setDeleLines(int total){
      this.deleLines = total;
    }
	public void setChangedFiles(int total){
      this.changedFiles = total;
    }


	// getter
	public Date getDate(){
		return this.date;
	}

	public String getCommiter(){
		return this.commiter;
	}
	public String getMessage(){
		return this.message;
	}
	public int getAddLines(){
		return this.addLines;
	}
	public int getDeleLines(){
      return this.deleLines;
    }
	public int getChangedFiles(){
      return this.changedFiles;
    }
}
