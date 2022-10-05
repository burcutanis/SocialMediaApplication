import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_term_project/util/colors.dart';
import 'package:cs310_term_project/util/dimensions.dart';
import 'package:cs310_term_project/model/accountInfo.dart';
import 'package:cs310_term_project/util/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class EditUsername extends StatefulWidget {
  const EditUsername({Key? key}) : super(key: key);

  @override
  State<EditUsername> createState() => _EditUsernameState();
}

class _EditUsernameState extends State<EditUsername> {
  final _formKey = GlobalKey<FormState>();
  String username = "";
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    String uid = "";
    if(user != null){
      uid = user.uid;
      print(uid);
    }
    void ChangeUsername(String uname) async{
      var db = await FirebaseFirestore.instance;
      db.collection("users").doc(uid).set({
        "username" : uname
      }, SetOptions(merge: true))
          .onError((e, _) => print("Error writing document: $e"));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit the Username",
        ),

        backgroundColor: AppColors.buttonMainColor,
      ),
      body: SafeArea(
      child: Container(
        decoration: decoration,
      child: SafeArea (
        child: SingleChildScrollView(
          child: Padding (
            padding: Dimen.regularParentPadding,
            child: Form (
              key: _formKey,
              child: Column (
                children: [
                  Padding(
                    padding: Dimen.editEmailPadding,
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            contentPadding: Dimen.editContentPadding,
                            label: Container(
                              width: 200,
                              child: Row(
                                children: const [
                                  const SizedBox(width: 4),
                                  const Text('Enter a new username'),
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

                            }
                          },
                          onSaved: (value) {
                            username = value?? '';
                            print(username);
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
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    ChangeUsername(username);
                                    Navigator.pushNamed(context, "/myBottomNavigationBar");
                                  }
                                },
                                child: const Text("Change Username",
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
      ),
    );
  }
}
