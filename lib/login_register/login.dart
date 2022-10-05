import 'dart:io' show Platform;
import 'package:cs310_term_project/bottomNavigationBar.dart';
import 'package:cs310_term_project/util/auth.dart';
import 'package:cs310_term_project/util/colors.dart';
import 'package:cs310_term_project/util/dimensions.dart';
import 'package:cs310_term_project/util/styles.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);


  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  int loginCounter = 0;
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String pass = '';
  bool? remember = false;

  final AuthService _auth = AuthService();

  Future loginUser() async {
    dynamic result = await _auth.signInWithEmailPass(email, pass);
    if(result is String) {
      _showDialog('Login Error', result);
      FirebaseAnalytics.instance.logEvent(name: "Login error");
    } else if (result is User) {
      //User signed in

      Navigator.pushNamedAndRemoveUntil(context, '/myBottomNavigationBar', (route) => false);
    } else {
      _showDialog('Login Error', result.toString());
      FirebaseAnalytics.instance.logEvent(name: "Login error");
    }
  }


  Future<void> _showDialog(String title, String message) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text(message),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login",
          style: TextStyle (
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.buttonMainColor,
      ),
      body: SafeArea(
        child: Container(
          decoration: decoration,
          child: SingleChildScrollView(
            child: Padding (
              padding: Dimen.loginPadding1,
              child: Column (
                children: [
                  Padding(
                    padding: Dimen.loginPadding,
                    child: Column(
                      children: [
                        Image.asset("assets/SuDorm.png", width: 150, height: 150),
                        SizedBox(height: 20,),
                        Text("Welcome to SUform",
                          style: suDormTitle,
                        ),
                        const SizedBox(height: 25, width: 5),
                        const Text("Please enter your email and password",
                          style: TextStyle(
                              color: AppColors.textMainColor,
                              fontSize: 18
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 30, 20, 110),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              label: Container(
                                width: 100,
                                child: Row(
                                  children: const [
                                    const Icon(Icons.email),
                                    const SizedBox(width: 4),
                                    const Text('Email'),
                                  ],
                                ),
                              ),
                              fillColor: AppColors.fillColor,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            validator: (value) {
                              if(value != null){
                                if(value.isEmpty) {
                                  return 'Cannot leave e-mail empty';
                                }
                                if(!EmailValidator.validate(value)) {
                                  return 'Please enter a valid e-mail address';
                                }
                              }
                            },
                            onSaved: (value) {
                              email = value?? '';
                              print(email);
                            },
                          ),
                          const SizedBox(height: 20),

                          TextFormField(
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,

                            decoration: InputDecoration(
                              label: Container(
                                width: 150,
                                child: Row(
                                  children: [
                                    Image.asset("assets/lock.jpg", width:30, height: 30),
                                    const SizedBox(width: 4),
                                    const Text('Password'),
                                  ],
                                ),
                              ),
                              fillColor: AppColors.fillColor,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            validator: (value) {
                              if(value != null){
                                if(value.isEmpty) {
                                  return 'Cannot leave password empty';
                                }
                                if(value.length < 6) {
                                  return 'Password too short';
                                }
                              }
                            },
                            onSaved: (value) {
                              pass = value ?? '';
                              print(pass);

                            },
                          ),
                          const SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(
                                width: 60.0,
                                height: 60.0,
                                child: ElevatedButton(
                                  style: TextButton.styleFrom(
                                    shape:
                                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                    primary: AppColors.white,
                                    backgroundColor: AppColors.buttonMainColor,
                                  ),
                                  onPressed: () async{
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      await loginUser();
                                      await FirebaseAnalytics.instance.logEvent(name: "User logged in");
                                    }
                                  },

                                  child: const Text("Sign In",
                                    style: TextStyle (
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don’t have an account? ",
                        style: TextStyle(fontSize: 20),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/register'),
                        child: const Text(
                          "Register",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.linkColor),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
