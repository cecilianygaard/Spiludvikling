
class Highscore{
  PrintWriter highscoreWriter;
  int currentHighscore;
  String fileName = "highscore.txt";
  Highscore(String fileName_){
    fileName = fileName_;
    String[] strs = loadStrings(fileName);
    currentHighscore = int(strs[0]);
  }
  
  void updateHighscore(int newScore){
    if (newScore > currentHighscore){
      highscoreWriter = createWriter(fileName);
      highscoreWriter.println(newScore);
      currentHighscore = newScore;
      highscoreWriter.flush();
      highscoreWriter.close();
    }    
    
  }
  
}
