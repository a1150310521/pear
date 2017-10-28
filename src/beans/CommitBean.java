package beans;
import java.util.Date;

public class CommitBean {
	private Date date;
	private String commiter;
	private String message;
	private int changedLines;


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
	public void setChangedLines(int total){
		this.changedLines = total;
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
	public int getChangedLines(){
		return this.changedLines;
	}
}
