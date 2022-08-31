
import 'package:flutter/material.dart';
import 'package:tiktactoe/ui/theme/color.dart';
import 'package:tiktactoe/utils/game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  //adding the necessary variable
  String lastValue = "X";
  bool gameOver = false;

  int turn = 0;
  String result = "";

  List<int> scoreboard = [0, 0, 0, 0, 0, 0, 0, 0]; //
  // let's decalred the new Game component

  Game game = Game();

  //init the GameBoard
  @override
  void initState() {
    // TODO: implement initState
    game.board = Game.initGameBoard();
  }

  @override
  Widget build(BuildContext context) {
    double boardWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      // the first step is organize our project folder structure
      backgroundColor: MainColor.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "it'S ${lastValue} turn".toUpperCase(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 58,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          //now we will make the game board
          Container(
            width: boardWidth,
            height: boardWidth,
            child: GridView.count(
              crossAxisCount: Game.boardlenth ~/ 3,
              padding: EdgeInsets.all(16.0),
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              children: List.generate(Game.boardlenth, (index) {
                return InkWell(
                  onTap: gameOver
                      ? null
                      : () {
                          // When we click we need to add value and refresh the screen
                          // We need to toggle the value
                          // need to apply if the field is empty
                          if (game.board![index] == "") {
                            setState(() {
                              game.board![index] = lastValue;
                              turn++;
                              gameOver = game.winnerCheck(
                                  lastValue, index, scoreboard, 3);
                              if (gameOver) {
                                result = "$lastValue is the Winner";
                              } else if (!gameOver && turn == 9){
                                result = "It's a Draw";
                                gameOver =true;
                              }
                              if (lastValue == "X")
                                lastValue = "O";
                              else
                                lastValue = "X";
                            });
                          }
                        },
                  child: Container(
                    width: Game.blockSize,
                    height: Game.blockSize,
                    decoration: BoxDecoration(
                      color: MainColor.secondaryColor,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Center(
                      child: Text(
                        game.board![index],
                        style: TextStyle(
                          color: game.board![index] == "X"
                              ? Colors.white
                              : Colors.black87,
                          fontSize: 64.0,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          SizedBox(height: 25.0,),
          Text(result, style: TextStyle(
            color: Colors.white,
            fontSize: 54.0,
          ),),
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                //erase the board
                game.board = Game.initGameBoard();
                lastValue = "X";
                gameOver = false;
                turn = 0;
                result = "";
                scoreboard = [0,0,0,0,0,0,0,0];
              });
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.deepOrange,
            ),
            icon: Icon(Icons.replay),
            label: Text("Repeat the Game"),
          ),
        ],
      ),
    );
  }
}
