import 'dart:io' show Platform;
import 'package:cs310_term_project/model/user.dart';
import 'package:cs310_term_project/util/auth.dart';
import 'package:cs310_term_project/util/colors.dart';
import 'package:cs310_term_project/util/dimensions.dart';
import 'package:cs310_term_project/util/styles.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:email_validator/email_validator.dart';


class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  String? conform_password;
  String emailx = '';
  String pass = '';
  String uname = '';
  bool? remember = false;
  MyUser user = MyUser(password: "test", username: "test", email:"test");

  final AuthService _auth = AuthService();

  Future RegisterUser() async {
    dynamic result = await _auth.registerUserWithEmailPass(emailx, pass, uname);
    if(result is String) {
      _showDialog('Register Error', result);
      FirebaseAnalytics.instance.logEvent(name: "Register error");

    } else if (result is User) {
      //User signed in
      FirebaseAnalytics.instance.logEvent(name: "User logged in");
      Navigator.pushNamed(context, '/login');
    } else {
      _showDialog('Register Error', result.toString());
      FirebaseAnalytics.instance.logEvent(name: "Register Error");

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
        title: const Text("Register",
          style: TextStyle (
            fontSize: 30,
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
              padding: Dimen.regularPadding,
              child: Form (
                key: _formKey,
                child: Column (
                  children: [
                    Padding(
                      padding: Dimen.loginPadding,
                      child: Column(
                        children: [
                          Image.asset("assets/SuDorm.png", width: 150, height: 150),
                          SizedBox(height: 20,),
                          const Text("Welcome to SUform",
                              style: TextStyle(
                                color: AppColors.textMainColor,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              )),
                          const SizedBox(height: 25, width: 5),
                          const Text("Please enter an email and password",
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
                      padding: Dimen.registerPadding,
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
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: AppColors.buttonMainColor,
                                ),
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
                                else {
                                  user.addEmail(value);
                                  print("xxx,${user.email}");
                                }

                              }
                            },
                            onSaved: (value) {
                              emailx = value ?? '';
                              print(emailx);
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: "Enter a username",

                              label: Container(
                                width: 200,
                                child: Row(
                                  children: const [
                                    Icon(Icons.person),
                                    SizedBox(width: 4),
                                    Text('Username'),
                                  ],
                                ),
                              ),
                              fillColor: AppColors.fillColor,
                              filled: true,
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: AppColors.buttonMainColor,
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            validator: (value) {
                              if(value != null){
                                if(value.isEmpty) {
                                  return 'Cannot leave username empty';
                                }
                                else {
                                  user.addUser(value);
                                  print("xxx1,${user.username}");
                                }

                              }
                            },
                            onSaved: (value) {
                              uname = value?? '';
                              print(uname);
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                            decoration: InputDecoration(
                              hintText: "Enter a password",

                              label: Container(
                                width: 200,
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
                                borderSide: const BorderSide(
                                  color: AppColors.buttonMainColor,
                                ),
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
                                else {
                                  user.addPassword(value);
                                  print("xxx3,${user.password}");
                                }
                              }
                            },
                            onSaved: (value) {
                              pass = value?? '';
                              print(pass);
                            },

                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                            decoration: InputDecoration(
                              hintText: "Re-enter the password",
                              label: Container(
                                width: 200,
                                child: Row(
                                  children: [
                                    Image.asset("assets/lock.jpg", width:30, height: 30),
                                    const SizedBox(width: 4),
                                    const Text('Confirm Password'),

                                  ],
                                ),
                              ),
                              fillColor: AppColors.fillColor,
                              filled: true,
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: AppColors.buttonMainColor,
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            validator: (value) {
                              if(value != null ){
                                conform_password = value;

                                if(value.isEmpty) {
                                  return 'Cannot leave password empty';
                                }
                                if ("${user.password}" != conform_password) {
                                  return 'Not match';
                                }
                              }
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
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      await RegisterUser();
                                      await FirebaseAnalytics.instance.logEvent(name: "New user registered");


                                    }
                                  },
                                  child: const Text("Register",
                                    style: TextStyle (
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Do you have an account? ",
                          style: TextStyle(fontSize: 20),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(context, '/login'),
                          child: const Text(
                            "Sign In",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.linkColor),
                          ),
                        ),

                      ],
                    ),
                    SizedBox(height: 50,),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
