import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_term_project/messages/messages_card.dart';
import 'package:cs310_term_project/messages/messages_db.dart';
import 'package:cs310_term_project/model/messages.dart';
import 'package:cs310_term_project/notifications/notification_db.dart';
import 'package:cs310_term_project/util/colors.dart';
import 'package:cs310_term_project/util/dimensions.dart';
import 'package:cs310_term_project/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';


class AddFollowings extends StatefulWidget {

  const AddFollowings({Key? key}) : super(key: key);

  @override
  State<AddFollowings> createState() => _AddFollowingsState();
}

class _AddFollowingsState extends State<AddFollowings> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  MessageDB db = MessageDB();
  NotificationDB notification_db = NotificationDB();
  String sender = "";
  String uid = "";

  @override
  Widget build(BuildContext context) {

    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    if(user != null){
      uid = user.uid;
      print(uid);
    }

    final CollectionReference followingCol = FirebaseFirestore.instance.collection("following");

    Future<void> addFollowing() async {
      await followingCol.add({
        'name': email,
        'you': uid,
        })
          .then((value) => print("User added"))
          .catchError((error)=>print("Failed to add"));
    }



    return Scaffold(
      appBar: AppBar(
        title: Text("Add to Follow List"),
        backgroundColor: AppColors.appbarColor,
      ),

      body: SafeArea(
        child: Container(
          decoration: decoration,
          child: SingleChildScrollView(
            child: Padding(
              padding: Dimen.messageNotificationPadding,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 60),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(

                        label: Container(
                          width: 200,
                          child: Row(
                            children: [
                              Icon(Icons.person),
                              const SizedBox(width: 4),
                              const Text('Email'),
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
                            return 'Cannot leave it empty';
                          }
                          if(!EmailValidator.validate(value)) {
                            return 'Please enter a valid e-mail address';
                          }
                        }
                      },
                      onSaved: (value) {
                        email = value ?? '';
                      },
                    ),
                    const SizedBox(height: 30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          child: ElevatedButton(
                            style: TextButton.styleFrom(
                              shape:
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              primary: AppColors.white,
                              backgroundColor: AppColors.buttonMainColor,
                            ),
                            onPressed: ()  {
                              setState(() {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  addFollowing();
                                  Navigator.pushNamed(context, '/profile');
                                }
                              });
                            },

                            child: const Text("Follow",
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
            ),
          ),
        ),
      ),
    );
  }
}