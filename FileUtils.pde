static class FileUtils {
  
  private FileUtils() {}
  
  // This function returns all the files in a directory as an array of Strings  
  static String[] listFileNames(String dir) {
    File file = new File(dir);
    if (file.isDirectory()) {
      String names[] = file.list();
      return names;
    } else {
      // If it's not a directory
      return null;
    }
  }

  // This function returns all the files in a directory as an array of File objects
  // This is useful if you want more info about the file
  static File[] listFiles(String dir) {
    File file = new File(dir);
    if (file.isDirectory()) {
      File[] files = file.listFiles();
      return files;
    } else {
      // If it's not a directory
      return null;
    }
  }

  // Function to get a list of all files in a directory and all subdirectories
  static ArrayList<File> listFilesRecursive(String dir) {
    ArrayList<File> fileList = new ArrayList<File>(); 
    recurseDir(fileList, dir);
    return fileList;
  }

  // Recursive function to traverse subdirectories
  static void recurseDir(ArrayList<File> a, String dir) {
    File file = new File(dir);
    if (file.isDirectory()) {
      // If you want to include directories in the list
      a.add(file);  
      File[] subfiles = file.listFiles();
      for (int i = 0; i < subfiles.length; i++) {
        // Call this function on all files in this directory
        recurseDir(a, subfiles[i].getAbsolutePath());
      }
    } else {
      a.add(file);
    }
  }
}
