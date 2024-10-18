import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int player = 1;
  int computer = 2;
  int playerrWinining = 0;
  int computerWinning = 0;
  bool isComputerTurn = false;
  List board = List.filled(9, 0);
  Timer? _timer;
  int time = 60;
  String status = "Your Turn";
  int coin = 0;

  startTime() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (time > 0) {
        setState(() {
          time--;
        });
      } else {
        timer.cancel();

        if (playerrWinining > computerWinning) {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: const Center(child: Text('You Win')),
                    content: SizedBox(
                      height: 200,
                      child: Column(
                        children: [
                          Image.asset(
                            "images/money.png",
                            height: 100,
                          ),
                          Text(
                            "Coin: $coin",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                              "You Win against computer by $playerrWinining to $computerWinning"),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Row(
                              children: [
                                Icon(Icons.restart_alt),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "Restart",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ));
        } else if (computerWinning > playerrWinining) {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: const Center(child: Text('You lose')),
                    content: SizedBox(
                      height: 247,
                      child: Column(
                        children: [
                          Image.asset(
                            "images/money.png",
                            height: 100,
                          ),
                          Text(
                            "Coin: $coin",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                              "You lose to computer by $computerWinning to $playerrWinining"),
                          Container(
                            margin: const EdgeInsets.only(top: 7),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.restart_alt_rounded),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Restart",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 7),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.stop),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "End Game",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ));
        } else {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: const Center(child: Text('Game Over')),
                    content: SizedBox(
                      height: 247,
                      child: Column(
                        children: [
                          Image.asset(
                            "images/money.png",
                            height: 100,
                          ),
                          Text(
                            "Coin: $coin",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                              "You lose to computer by $computerWinning to $playerrWinining"),
                          Container(
                            margin: const EdgeInsets.only(top: 7),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.restart_alt_rounded),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Restart",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 7),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.stop),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "End Game",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ));
        }
      }
    });
  }

  runComputer() async {
    if (hasWon(player, board)) {
      setState(() {
        playerrWinining++;
        board = List.filled(9, 0);
        coin += 20;
      });
    }

    await Future.delayed(const Duration(milliseconds: 200), () async {
      int? blocking;
      int? winning;
      List avaliableMove = [];

      if (board.every((element) => element != 0) && time > 2) {
        setState(() {
          board = List.filled(9, 0);
        });
      }

      // [1,1,1,0,0,0,0,0,0]
      for (int i = 0; i < board.length; i++) {
        List<int> demoBoard = List.from(board);
        if (demoBoard[i] != 0) {
          continue;
        }
        demoBoard[i] = computer;
        if (hasWon(computer, demoBoard)) {
          winning = i;
        }

        demoBoard[i] = player;

        if (hasWon(player, demoBoard)) {
          blocking = i;
        }

        avaliableMove.add(i);
      }

      if (winning != null) {
        makeMove(computer, winning);
      } else if (blocking != null) {
        makeMove(computer, blocking);
      } else {
        if (avaliableMove.isNotEmpty) {
          var random = Random().nextInt(avaliableMove.length);
          var randomMove = avaliableMove[random];
          makeMove(computer, randomMove);
        }
      }

      if (hasWon(computer, board)) {
        Future.delayed(const Duration(milliseconds: 200), () {
          setState(() {
            board = List.filled(9, 0);
            computerWinning++;
          });
        });
      }

      if (board.every((element) => element != 0)) {
        await Future.delayed(const Duration(milliseconds: 200), () {
          setState(() {
            board = List.filled(9, 0);
          });
        });
      }

      // if (hasWon(player, board)) {
      //   showDialog(
      //     context: context,
      //     builder: (context) => AlertDialog(
      //       title: Text("You Won"),
      //     ),
      //   );
      // }
    });
  }

  void makeMove(int check, int index) {
    setState(() {
      board[index] = check;
    });
  }

  bool hasWon(int check, List board) {
    return board[0] == check && board[1] == check && board[2] == check ||
        board[3] == check && board[4] == check && board[5] == check ||
        board[6] == check && board[7] == check && board[8] == check ||
        board[0] == check && board[3] == check && board[6] == check ||
        board[1] == check && board[4] == check && board[7] == check ||
        board[2] == check && board[5] == check && board[8] == check ||
        board[0] == check && board[4] == check && board[8] == check ||
        board[2] == check && board[4] == check && board[6] == check;
  }

  @override
  void initState() {
    startTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        leading: Container(
          alignment: Alignment.center,
          child: Text(
            "$time",
            style: const TextStyle(fontSize: 20),
          ),
        ),
        title: Row(
          children: [
            Text("P: $playerrWinining "),
            Text("C: $computerWinning "),
          ],
        ),
        actions: [
          Text(
            "$coin",
            style: const TextStyle(fontSize: 20),
          ),
          IconButton(
              onPressed: () {
                if (_timer != null && !_timer!.isActive) {
                  startTime();
                } else {
                  setState(() {
                    _timer?.cancel();
                  });
                }
              },
              icon: Icon(_timer != null && _timer!.isActive
                  ? Icons.pause
                  : Icons.play_arrow)),
          IconButton(
              onPressed: () {
                _timer?.cancel();
                setState(() {
                  board = List.filled(9, 0);
                  time = 60;
                  playerrWinining = 0;
                  computerWinning = 0;
                  coin = 0;
                });
                startTime();
              },
              icon: const Icon(Icons.lock_reset_rounded))
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            height: MediaQuery.of(context).size.height * 0.5,
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              children: [
                for (int i = 0; i < board.length; i++)
                  GestureDetector(
                    onTap: () async {
                      if (board[i] != 0) {
                        setState(() {
                          status = 'Already Played Into';
                        });
                        return;
                      }
                      if (time < 1) {
                        setState(() {
                          status = "Time Up";
                        });
                        return;
                      }

                      if (!isComputerTurn) {
                        setState(() {
                          board[i] = player;
                          isComputerTurn = true;
                          status = "Computer Turn";
                        });
                        await runComputer();
                        setState(() {
                          isComputerTurn = false;
                          status = "Your Turn";
                        });
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: board[i] == player
                            ? Colors.green
                            : board[i] == computer
                                ? Colors.redAccent
                                : Colors.amber.shade300,
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Text(
                        board[i] == player
                            ? "X"
                            : board[i] == computer
                                ? "O"
                                : "",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
              ],
            ),
          ),
          Text(
            status,
            style: const TextStyle(
              fontSize: 22,
            ),
          )
        ],
      ),
    );
  }
}
