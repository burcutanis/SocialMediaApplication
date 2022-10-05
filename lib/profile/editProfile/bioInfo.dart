import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_term_project/getDB.dart';
import 'package:cs310_term_project/model/accountInfo.dart';
import 'package:cs310_term_project/util/colors.dart';
import 'package:cs310_term_project/util/dimensions.dart';
import 'package:cs310_term_project/util/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class AccountInfo extends StatefulWidget {
  const AccountInfo({Key? key}) : super(key: key);

  @override
  State<AccountInfo> createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {


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
        title: Text("My Bio"),
        backgroundColor: AppColors.appbarColor,
        actions: [
          IconButton(
            iconSize: 14,
            onPressed: () {
              Navigator.pushNamed(
                  context, "/editBio");
            },
            icon: const Icon(
              Icons.edit, size: 25,
              color: Colors.white,),
          ),
          SizedBox(width: 30,),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _statusService.getUser(uid),
          builder: (context, snaphot) {
            return !snaphot.hasData
                ? CircularProgressIndicator()
                : ListView.builder(
                itemCount: snaphot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot myuser = snaphot.data!.docs[index];
                  return SafeArea(
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
                                  color: AppColors.cardColor,
                                  margin: Dimen.classesMargin,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(10, 30, 0, 0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .end,
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,

                                      children: [
                                        Column(
                                          children: [
                                            const Text(
                                              "BIO:",
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
                                                  "${myuser['bio']}",
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
                                                        context, "/editBio");
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
                  );
                }
            );
          }
      ),
    );
  }
}

