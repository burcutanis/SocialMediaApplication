import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_term_project/getDB.dart';
import 'package:cs310_term_project/model/accountInfo.dart';
import 'package:cs310_term_project/util/colors.dart';
import 'package:cs310_term_project/util/dimensions.dart';
import 'package:cs310_term_project/util/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class MyEmail extends StatefulWidget {
  const MyEmail({Key? key}) : super(key: key);

  @override
  State<MyEmail> createState() => _MyEmailState();
}

class _MyEmailState extends State<MyEmail> {


  getDB _statusService = getDB();

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    String uid = "";
    String? email = "";
    if (user != null) {
      uid = user.uid;
      email = user.email;
      print(uid);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("My Email"),
        backgroundColor: AppColors.appbarColor,
      ),
      body: SafeArea(
                    child: Container(
                      decoration: decoration,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: Dimen.messageNotificationPadding,
                          child: Column(
                            children: [
                              SizedBox(
                                width: 450,
                                height: 130,
                                child: Card(
                                  margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(10, 30, 0, 0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      children: [
                                        Column(
                                          children: [
                                            const Text(
                                              "Email:",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(width: 20,),
                                                Text(
                                                  email!,
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                                Spacer(),
                                                IconButton(
                                                  iconSize: 14,
                                                  onPressed: () {
                                                    Navigator.pushNamed(
                                                        context, "/editEmail");
                                                  },
                                                  icon: const Icon(
                                                    Icons.edit, size: 14,
                                                    color: Colors.red,),
                                                ),

                                              ],
                                            ),

                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
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
