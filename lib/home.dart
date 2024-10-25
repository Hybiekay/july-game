import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final firebaseAuth = FirebaseAuth.instance;
  Future login() async {
    showDialog(
        context: context, builder: (context) => const SignUpLoginDialog());
  }

  logOut() {
    try {
      firebaseAuth.signOut();
      setState(() {});
    } on FirebaseAuthException {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Row(children: [
                  const Text("Username"),
                  10.toWidthSize(),
                  GestureDetector(
                      onTap: () {
                        logOut();
                      },
                      child: const Text("Log out"))
                ]);
              }
              return Row(
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
              );
            }),
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
  bool isloginPage = false;
  final firebaseAuth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  Future login() async {
    try {
      setState(() {
        isLoading = true;
      });
     
      await firebaseAuth.signInWithEmailAndPassword(
          email: emailcontroller.text.trim(),
          password: passwordController.text.trim());
      setState(() {
        isLoading = false;
      });
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Login Successfully")));
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("${e.message}")));
      print("Error ${e.message}");
    }
  }

  Future registerUser() async {
    try {
      setState(() {
        isLoading = true;
      });

      await firebaseAuth.createUserWithEmailAndPassword(
          email: emailcontroller.text.trim(),
          password: passwordController.text.trim());

      setState(() {
        isLoading = false;
      });
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Register successufuly")));
    } on FirebaseAuthException catch (error) {
      setState(() {
        isLoading = false;
      });
      // Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("${error.message}"),
        backgroundColor: Colors.red,
      ));
      print("Error ${error.message}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 400,
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(color: Colors.amber),
              )
            : Column(
                children: [
                  15.toHeightSize(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isloginPage = true;
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 150,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: isloginPage ? Colors.amber : Colors.white,
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
                            isloginPage = false;
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 150,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: isloginPage ? Colors.white : Colors.amber,
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
                  isloginPage
                      ? Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: emailcontroller,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Email Is required";
                                    } else if (!value.contains("@") &&
                                        !value.trim().contains(" ")) {
                                      return "Enter a valid Email";
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Enter your Emaill",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                10.toHeightSize(),
                                TextFormField(
                                  controller: passwordController,
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
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      login();
                                    }
                                  },
                                  child: const Text("Login"),
                                ),
                                20.toHeightSize(),
                              ],
                            ),
                          ),
                        )
                      : Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: emailcontroller,
                                  validator: (value) {
                                    if (value == null || value == "") {
                                      return "Email Is required";
                                    } else if (!value.contains("@") &&
                                        !value.contains(".")) {
                                      return "Enter a valid Email";
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Enter your Emaill",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                10.toHeightSize(),
                                TextFormField(
                                  controller: passwordController,
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
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      registerUser();
                                    }
                                  },
                                  child: const Text("Sign Up"),
                                ),
                                20.toHeightSize(),
                              ],
                            ),
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
                    iconAlignment: IconAlignment.start,
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
