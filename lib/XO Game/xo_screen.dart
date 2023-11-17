import 'package:flutter/material.dart';
import 'package:games_community/colors.dart';
import 'package:particles_flutter/particles_flutter.dart';

class XOGame extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<XOGame> {
  late List<List<String>> board;
  late String currentPlayer;
  late bool gameOver;

  @override
  void initState() {
    super.initState();
    startNewGame();
  }

  void startNewGame() {
    board = List.generate(3, (_) => List.filled(3, ''));
    currentPlayer = 'X';
    gameOver = false;
  }

  void makeMove(int row, int col) {
    if (board[row][col] == '' && !gameOver) {
      setState(() {
        board[row][col] = currentPlayer;
        if (checkWin(currentPlayer)) {
          gameOver = true;
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                'Game Over',
                style: TextStyle(color: AppColors.blue),
              ),
              content: Text(
                'Player $currentPlayer wins!',
                style: TextStyle(color: AppColors.blue, fontSize: 20),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(
                    'Play Again',
                    style: TextStyle(
                        color: AppColors.blue, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    startNewGame();
                  },
                ),
              ],
            ),
          );
        } else if (checkDraw()) {
          gameOver = true;
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Game Over'),
              content: const Text('It\'s a draw!'),
              actions: <Widget>[
                TextButton(
                  child: const Text('Play Again'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    startNewGame();
                  },
                ),
              ],
            ),
          );
        } else {
          currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
        }
      });
    }
  }

  bool checkWin(String player) {
    // Check rows
    for (int i = 0; i < 3; i++) {
      if (board[i][0] == player &&
          board[i][1] == player &&
          board[i][2] == player) {
        return true;
      }
    }

    // Check columns
    for (int i = 0; i < 3; i++) {
      if (board[0][i] == player &&
          board[1][i] == player &&
          board[2][i] == player) {
        return true;
      }
    }

    // Check diagonals
    if (board[0][0] == player &&
        board[1][1] == player &&
        board[2][2] == player) {
      return true;
    }

    if (board[0][2] == player &&
        board[1][1] == player &&
        board[2][0] == player) {
      return true;
    }

    return false;
  }

  bool checkDraw() {
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j] == '') {
          return false;
        }
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.blue,
      appBar: AppBar(
        backgroundColor: AppColors.blue,
        centerTitle: true,
        title: const Text('XO Game'),
      ),
      body: Stack(
        children: [
          CircularParticle(
            width: w,
            height: h,
            awayRadius: w / 5,
            numberOfParticles: 150,
            speedOfParticles: 1.5,
            maxParticleSize: 7,
            particleColor: Colors.white.withOpacity(.7),
            awayAnimationDuration: const Duration(milliseconds: 600),
            awayAnimationCurve: Curves.easeInOutBack,
            onTapAnimation: true,
            isRandSize: true,
            isRandomColor: false,
            connectDots: true,
            enableHover: true,
            hoverColor: Colors.black,
            hoverRadius: 90,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Player $currentPlayer\'s turn',
                    style: TextStyle(
                        fontSize: 25,
                        color: AppColors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  GridView.builder(
                    clipBehavior: Clip.hardEdge,
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 2.0,
                      crossAxisSpacing: 2.0,
                      crossAxisCount: 3,
                    ),
                    itemCount: 9,
                    itemBuilder: (context, index) {
                      int row = index ~/ 3;
                      int col = index % 3;
                      return GestureDetector(
                        onTap: () => makeMove(row, col),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(),
                          ),
                          child: Center(
                            child: Text(
                              board[row][col],
                              style: TextStyle(
                                  fontSize: 40, color: AppColors.blue),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
