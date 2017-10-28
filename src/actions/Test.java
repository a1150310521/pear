package actions;
import org.eclipse.egit.github.core.*;
import org.eclipse.egit.github.core.client.*;
import org.eclipse.egit.github.core.service.*;
public class Test {
    public static void main(String args[])throws Exception{
      GitHubClient client = new GitHubClient();
      client.setCredentials("BokunoMasayume", "19970605zys");
      CommitService coms = new CommitService(client);
      
      RepositoryService service = new RepositoryService(client);
     /* for (Repository repo : service.getRepository("BokunoMasayume","Lab1"))//filterData can be username or orgname
        System.out.println(repo.getName() + " Watchers: " + repo.getWatchers());
   */
      Repository repo = service.getRepository("BokunoMasayume","bootstrap-note");
    //  System.out.println(repo.getName() + " Watchers: " + repo.getWatchers());
    
    
      //List<RepositoryCommit> rc = coms.getCommits(repo);
   for(RepositoryCommit rc : coms.getCommits(repo)){
     
     rc = coms.getCommit(repo, rc.getSha());
      System.out.println("date:"+rc.getCommit().getCommitter().getDate()+"\ttotal: "+rc.getStats().getTotal()+"\tname:"+rc.getCommit().getCommitter().getName()+"\t msg: "+rc.getCommit().getMessage());
    }
   System.out.println("OK");
      
    
    
    }
}
