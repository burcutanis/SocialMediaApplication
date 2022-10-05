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


class SendMessages extends StatefulWidget {

  const SendMessages({Key? key}) : super(key: key);

  @override
  State<SendMessages> createState() => _SendMessagesState();
}

class _SendMessagesState extends State<SendMessages> {
  final _formKey = GlobalKey<FormState>();
  String username = '';
  String message = '';
  String title = '';
  MessageDB db = MessageDB();
  NotificationDB notification_db = NotificationDB();
  String sender = "";
  String uid = "";
  dynamic _user = [];

  @override
  Widget build(BuildContext context) {

    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    if(user != null){
      uid = user.uid;
      print(uid);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Send Messages"),
        backgroundColor: AppColors.appbarColor,
      ),

      body: SafeArea(
        child: Container(
          decoration: decoration,
          child: SingleChildScrollView(
            child: Padding(
              padding: Dimen.SendPadding,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(

                        label: Container(
                          width: 200,
                          child: Row(
                            children: [
                              Icon(Icons.person),
                              const SizedBox(width: 4),
                              const Text('Username'),
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

                        }
                      },
                      onSaved: (value) {
                        username = value ?? '';
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(

                        label: Container(
                          width: 200,
                          child: Row(
                            children: [
                              Icon(Icons.title),
                              const SizedBox(width: 4),
                              const Text('Title'),
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

                        }
                      },
                      onSaved: (value) {
                        title = value ?? '';
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text("Message:",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        )),
                    SizedBox(height: 5),
                    TextFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 150.0),
                        fillColor: AppColors.fillColor,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      validator: (value) {
                        if(value != null){
                          if(value.isEmpty) {
                            return 'Cannot leave text field empty';
                          }
                        }
                      },
                      onSaved: (value) {
                        message = value ?? '';
                      },
                    ),
                    const SizedBox(height: 20),

                    const SizedBox(height: 20),
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
                                  db.addMessage(username, sender, message, DateTime.now().toString().split(' ')[0], title);

                                  notification_db.addNotification(username, sender, "sent you a message", DateTime.now().toString(), Random().nextInt(1000000));
                                  Navigator.pushNamed(context, '/messages');
                                }
                              });
                            },

                            child: const Text("Post",
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