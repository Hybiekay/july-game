import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int player = 1;
  int computer = 2;
  List board = List.filled(9, 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        leading: Container(
          alignment: Alignment.center,
          child: const Text(
            "60",
            style: TextStyle(fontSize: 20),
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.pause)),
          IconButton(
              onPressed: () {
                setState(() {
                  board = List.filled(9, 0);
                });
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
                    onTap: () {
                      setState(() {
                        board[i] = player;
                      });
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
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}
