import 'package:flutter/material.dart';
import 'package:tic_tac/UI/Theme/Color.dart';
import 'package:tic_tac/Utlitis/Game_login.dart';

class MyGame extends StatefulWidget {
  const MyGame({Key? key}) : super(key: key);

  @override
  State<MyGame> createState() => _MyGameState();
}

class _MyGameState extends State<MyGame> {
  String lastvalue = "X";
  bool gameover = false;
  int turn = 0;
  List<int> scoreboard = [0, 0, 0, 0, 0, 0, 0, 0];
  String result = "";

  Game game = Game();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    game.board = Game.initGameBoard();
    print(game.board);
  }

  @override
  Widget build(BuildContext context) {
    double boardwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MainColor.primaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "It's ${lastvalue} turn".toUpperCase(),
            style: TextStyle(color: Colors.white, fontSize: 58),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            width: boardwidth,
            height: boardwidth,
            child: GridView.count(
              crossAxisCount: Game.boardlenth ~/ 3,
              padding: EdgeInsets.all(16),
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              children: List.generate(
                Game.boardlenth,
                (index) {
                  return GestureDetector(
                    onTap: gameover
                        ? null
                        : () {
                            if (game.board![index] == "") {
                              setState(() {
                                game.board![index] = lastvalue;
                                turn++;
                                gameover = game.winnerCheck(
                                    lastvalue, index, scoreboard, 3);
                                if (gameover) {
                                  result = "$lastvalue is the Winner";
                                } else if (!gameover && turn == 9) {
                                  result = "It's a draw!";
                                  gameover = true;
                                }
                                if (lastvalue == "X")
                                  lastvalue = "O";
                                else
                                  lastvalue = "X";
                              });
                            }
                          },
                    child: Container(
                      width: Game.blocSize,
                      height: Game.blocSize,
                      decoration: BoxDecoration(
                        color: MainColor.secondaryColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          game.board![index],
                          style: TextStyle(
                              color: game.board![index] == "X"
                                  ? Colors.blue
                                  : Colors.redAccent,
                              fontSize: 64.0),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: 25.0,
          ),
          Text(
            result,
            style: TextStyle(color: Colors.white, fontSize: 54),
          ),
          ElevatedButton.icon(
            onPressed: () {
              setState(
                () {
                  game.board = Game.initGameBoard();
                  lastvalue = "X";
                  gameover = false;
                  turn = 0;
                  result = "";
                  scoreboard = [0, 0, 0, 0, 0, 0, 0, 0];
                },
              );
            },
            icon: Icon(Icons.replay),
            label: Text("Repeat the game"),
          )
        ],
      ),
    );
  }
}
