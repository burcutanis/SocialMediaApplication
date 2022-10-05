import 'package:cs310_term_project/model/user.dart';
import 'package:cs310_term_project/util/colors.dart';
import 'package:cs310_term_project/util/dimensions.dart';
import 'package:cs310_term_project/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cs310_term_project/login_register/register.dart';
class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  String? old_password;
  String? password;
  String? conform_password;
  bool remember = false;

  MyUser user = MyUser(password: "test", username: "test", email:"test");

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Success"),
          content: new Text("You changed your password successfully"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.pushNamed(context, '/myBottomNavigationBar');
              },
            ),
          ],
        );
      },
    );
  }
  


  @override
  Widget build(BuildContext context) {

    void _changePassword(String newPassword) async {
      final user = await FirebaseAuth.instance.currentUser;

      user?.updatePassword(newPassword).then((value) => _showDialog(context)).catchError((err) => {
        print("Error was occured")
      });
      print(newPassword);

    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Change Password"),
        backgroundColor: AppColors.appbarColor,
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
                      padding: Dimen.regularParentPadding,
                      child: Column(
                        children: const [
                          Text("Change Password",
                              style: TextStyle(
                                color: AppColors.textMainColor,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              )),
                           SizedBox(height: 25, width: 5),
                        ],
                      ),
                    ),
                    Padding(
                      padding: Dimen.SendPadding,
                      child: Column(
                        children: [
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
                                    const Text('New Password'),
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
                                  print("xxx1,${user.password}");
                                }

                              }
                            },
                            onSaved: (value) {
                              password = value ?? '';
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                            decoration: InputDecoration(
                              hintText: "Re-enter the new password",
                              label: Container(
                                width: 300,
                                child: Row(
                                  children: [
                                    Image.asset("assets/lock.jpg", width:30, height: 30),
                                    const SizedBox(width: 4),
                                    const Text('Re-enter the new Password'),

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
                              conform_password = value ?? '';
                              if(value != null ){
                                if(value.isEmpty) {
                                  return 'Cannot leave password empty';
                                }
                                if ("${user.password}"!= conform_password) {
                                  return 'Not match';
                                }
                                if(value.length < 6) {
                                  return 'Password too short';
                                }
                              }
                            },
                            onSaved: (value) {
                              conform_password = value ?? '';
                            },

                          ),
                          const SizedBox(height: 20),
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
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      _changePassword(password!);
                                    }
                                  },
                                  child: const Text("Change Password",
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

