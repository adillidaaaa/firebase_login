import 'package:fire/home.dart';
import 'package:fire/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _usernamecontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8))),
        title: Center(
            child: const Text(
          " login ",
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
        )),
        titleTextStyle: TextStyle(color: Color.fromARGB(255, 255, 248, 248)),
        backgroundColor: Color.fromARGB(255, 73, 133, 82),
      ),
      backgroundColor: Color.fromARGB(255, 210, 229, 245),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                  controller: _usernamecontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: "username")),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _passwordcontroller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "password ",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Register()));
                },
                child: const Text("signup"),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  checklogin(context);
                },
                child: const Text("  login  "))
          ],
        ),
      ),
    );
  }

  void checklogin(BuildContext ctx) async {
    final username = _usernamecontroller.text;
    final pswd = _passwordcontroller.text;

    if (username.isNotEmpty && pswd.isNotEmpty) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: username,
          password: pswd,
        );
        // If login is successful, navigate to the home page
        Navigator.pushReplacement(
          context as BuildContext,
          MaterialPageRoute(
            builder: (context) => Homepage(),
          ),
        );
      } catch (e) {
        String errorMessage = "An error occurred. Please try again.";

        if (e is FirebaseAuthException) {
          switch (e.code) {
            // case 'user-not-found':
            //   errorMessage = "No user found for this email.";
            //   break;
            case 'INVALID_LOGIN_CREDENTIALS':
              errorMessage = "USER NAME OR PASSWORD IS INVALID .";
              break;
            case 'wrong-password':
              errorMessage = "Wrong password provided for this user.";
              break;
            default:
              errorMessage = e.message ?? "Unknown error occurred.";
              break;
          }
        }

        // Show the error message to the user
        ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
          content: Text(
            errorMessage,
            style: TextStyle(color: Colors.red),
          ),
        ));
      }
    } else {
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        content: Text(
          "Please enter username and password",
          style: TextStyle(color: Colors.red),
        ),
      ));
    }
  }
}
