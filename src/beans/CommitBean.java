package beans;
import java.util.Date;

public class CommitBean {
	private Date date;
	private String commiter;
	private String message;
	private int addLines;
	private int deleLines;
	private int changedFiles;


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
