package connect;

import java.io.*;

public class FileTuility {
  
  //获得当前文件目录
  public static String getCurrentDir(){
    try{
        File dir = new File(".");
        return dir.getCanonicalPath();
    }catch(IOException e){
      e.printStackTrace();
      return "//fail";
    }
  }

  //创建文件目录
  public static boolean createDir(String dir){
    boolean result = false;
    File file = new File(dir);
    if(!file.exists()){
        result = file.mkdirs();
    }
    return result;
  }

  //删除文件目录
  public static boolean deleteDir(String dir){
    
    File file = new File(dir);
    if(!file.exists()){
        return false;
    }

    if(file.isFile()){
        file.delete();
    }
    else if(file.isDirectory()){
        File[]  files = file.listFiles();
        for(File i:files){
            deleteDir(i.getAbsolutePath());
        }
        file.delete();
    }
    return true;
  }

}
