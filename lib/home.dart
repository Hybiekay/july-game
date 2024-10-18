import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future login() async {
    showDialog(context: context, builder: (context) => const SignUpLoginDialog());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            GestureDetector(
              onTap: () => login(),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text("Login"),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                decoration: const BoxDecoration(color: Colors.amber),
                height: 200,
                width: MediaQuery.sizeOf(context).width * 0.4,
              ),
              Container(
                decoration: const BoxDecoration(color: Colors.amber),
                height: 200,
                width: MediaQuery.sizeOf(context).width * 0.4,
              ),
              20.toHeightSize(),
              20.toWidthSize(),
            ],
          )
        ],
      ),
    );
  }
}

class SignUpLoginDialog extends StatefulWidget {
  const SignUpLoginDialog({
    super.key,
  });

  @override
  State<SignUpLoginDialog> createState() => _SignUpLoginDialogState();
}

class _SignUpLoginDialogState extends State<SignUpLoginDialog> {
  bool islogin = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 400,
        child: Column(
          children: [
            15.toHeightSize(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      islogin = true;
                    });
                  },
                  child: Container(
                    height: 50,
                    width: 150,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: islogin ? Colors.amber : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.amber)),
                    child: const Text(
                      "login",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      islogin = false;
                    });
                  },
                  child: Container(
                    height: 50,
                    width: 150,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: islogin ? Colors.white : Colors.amber,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.amber)),
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            20.toHeightSize(),
            islogin
                ? Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: "Enter your Emaill",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        10.toHeightSize(),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: "Enter your Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        15.toHeightSize(),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amber,
                              fixedSize: const Size(200, 40)),
                          onPressed: () {},
                          child: const Text("Login"),
                        ),
                        20.toHeightSize(),
                      ],
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: "Enter your Emaill",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        10.toHeightSize(),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: "Enter your Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        15.toHeightSize(),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amber,
                              fixedSize: const Size(200, 40)),
                          onPressed: () {},
                          child: const Text("Sign Up"),
                        ),
                        20.toHeightSize(),
                      ],
                    ),
                  ),
            const Row(
              children: [
                Expanded(
                  child: Divider(
                    color: Colors.amber,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Or"),
                ),
                Expanded(
                    child: Divider(
                  color: Colors.amber,
                )),
              ],
            ),
            ElevatedButton.icon(
              onPressed: () {},
              label: const Text("Sign Up with Google"),
              icon: const FlutterLogo(),
            ),
          ],
        ),
      ),
    );
  }
}

extension HeightSizedBox on int {
  Widget toHeightSize() {
    return SizedBox(
      height: toDouble(),
    );
  }

  Widget toWidthSize() {
    return SizedBox(
      width: toDouble(),
    );
  }
}
