package actions;
import java.text.DateFormat;
import java.util.Calendar;

import java.util.Date;
import java.util.ArrayList;   
import java.util.List;

import java.sql.*;
import java.io.*;

import org.eclipse.egit.github.core.*;
import org.eclipse.egit.github.core.client.*;
import org.eclipse.egit.github.core.service.*;


import beans.CommitBean;
public class RepoAllCommits {
	private List<CommitBean> commitList;

	public void setCommitList(List<CommitBean> commitList){
		this.commitList = commitList;
	}
	public List<CommitBean> getCommitList(){
		return this.commitList;
	}


	public String execute() throws Exception{
		
	    GitHubClient client = new GitHubClient();
		client.setCredentials("BokunoMasayume", "19970605zys");

		RepositoryService repoSer = new RepositoryService(client);
		CommitService comSer = new CommitService(client);

		Repository repo = repoSer.getRepository("BokunoMasayume","bootstrap-note");
		commitList = new ArrayList<CommitBean>();
		for(RepositoryCommit repoCom : comSer.getCommits(repo)){
			CommitBean cb = new CommitBean();
			repoCom = comSer.getCommit(repo, repoCom.getSha());
			cb.setChangedLines(repoCom.getStats().getTotal());
			
			
			cb.setDate(repoCom.getCommit().getCommitter().getDate());
			//System.out.println(repoCom.getCommit().getCommitter().getDate());
			//System.out.println(cb.getDate());
			cb.setMessage(repoCom.getCommit().getMessage());
			cb.setCommiter(repoCom.getCommit().getCommitter().getName());
			commitList.add(cb);
		}
		return "success";
		
	}

}
