class Player {
  static const x = "X";
  static const o = "O";
  static const empty = "";
}

class Game {
  static final boardlenth = 9; //baord will be in 3*3 block
  static final blockSize = 100.0;

  //creating the empty board
  List<String>? board;

  static List<String>? initGameBoard() =>
      List.generate(boardlenth, (index) => Player.empty);

  // now need to build winner check Algorithm

  bool winnerCheck(String player, int index, List<int> scoreboard, int gridSize) {
    // let's declare the rows and columns
    int row = index~/3;
    int col = index~/3;
    int score = player == "X" ? 1:-1;

    scoreboard[row]+=score;
    scoreboard[col]+=score;
    scoreboard[gridSize+col] += score;
    if(row == col) scoreboard[2*gridSize] += score;
    if( gridSize - 1 - col == row ) scoreboard[2 * gridSize + 1] += score;

    if( gridSize - 1 - row == col ) scoreboard[2 * gridSize + 1] += score;
    // Cheching if we have 3 or -3 in score
    if(scoreboard.contains(3) || scoreboard.contains(-3)) {
      return true;
    }

    // by defaiult it will return false
    return false;
  }
}
