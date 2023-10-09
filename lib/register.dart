// import 'package:firebase_core/firebase_core.dart';
import 'package:fire/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // TextEditingController _usernamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8))),
        title: Center(
            child: const Text(
          " sign in ",
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
        )),
        titleTextStyle: TextStyle(color: Color.fromARGB(255, 255, 248, 248)),
        backgroundColor: Color.fromARGB(255, 73, 133, 82),
      ),
      backgroundColor: Color.fromARGB(255, 210, 229, 245),
      body: Column(
        children: [
          // Center(
          //   child: Text(""),
          // ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: "Name")),
          ),
          // Center(
          //   child: Text(""),
          // ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
                controller: emailcontroller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: "email")),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: "Phone")),
          ),
          // Center(
          //   child: Text(""),
          // ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
                controller: passwordcontroller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: "password")),
          ),
          // Center(
          //   child: Text(""),
          // ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "confirm password")),
          ),
          // Center(
          //   child: Text(""),
          // ),
          SizedBox(
            height: 40,
          ),
          ElevatedButton(
              onPressed: () {
                signup();
              },
              child: const Text("submit"))
        ],
      ),
    );
  }

  void signup() async {
    //final username = usernamecontroller.text;
    final passwrd = passwordcontroller.text;
    final email = emailcontroller.text;
    if (passwrd.isNotEmpty && email.isNotEmpty) {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: passwrd)
          .then(
            (value) => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Homepage(),
              ),
            ),
          );
    }
  }
}
