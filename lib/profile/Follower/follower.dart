import 'package:cs310_term_project/getDB.dart';
import 'package:cs310_term_project/util/auth.dart';
import 'package:cs310_term_project/util/colors.dart';
import 'package:cs310_term_project/util/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';


class MyFollowers extends StatefulWidget {
  const MyFollowers({Key? key}) : super(key: key);

  @override
  State<MyFollowers> createState() => _MyFollowersState();
}

class _MyFollowersState extends State<MyFollowers> {

  List<User> users = [
  ];

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
      value: AuthService().user,
      initialData: null,
      child: MyFollowers2(),

    );
  }
}

class MyFollowers2 extends StatefulWidget {
  @override
  _MyFollowers2State createState() => _MyFollowers2State();
}

class _MyFollowers2State extends State<MyFollowers2> {
  getDB _statusService = getDB();



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final user = Provider.of<User?>(context);



    while (user == null){
      return Scaffold(
          appBar: AppBar(
            title: Text("My Followers"),
            centerTitle: true,
            backgroundColor: AppColors.appbarColor,
          ),
          body: const Center(
            child: Text("LOADING",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
      );
    }

    String uid = user.uid;



    return Scaffold(
      appBar: AppBar(
        title: Text("My Followers"),
        centerTitle: true,
        backgroundColor: AppColors.appbarColor,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _statusService.getFollowers(uid),
        builder: (context, snaphot) {
          return !snaphot.hasData
              ? CircularProgressIndicator()
              : ListView.builder(
              itemCount: snaphot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot myfollowers = snaphot.data!.docs[index];

                getFollowers() async {
                  var db = await FirebaseFirestore.instance;
                  db.collection("users").doc(uid).set({
                    "followers":  snaphot.data!.docs.length
                  }, SetOptions(merge: true))
                      .onError((e, _) => print("Error writing document: $e"));
                }
                getFollowers();
                Future<void> _showChoiseDialog(BuildContext context) {
                  return showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            title: const Text(
                              "Do you want to delete it?",
                              textAlign: TextAlign.center,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(8.0))),
                            content: Container(
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        _statusService
                                            .removeFollowers(myfollowers.id);
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        "Yes",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        "No",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                )));
                      });
                }

                return Padding(

                  padding: const EdgeInsets.all(20.0),
                  child: InkWell(
                    onTap: () {
                      _showChoiseDialog(context);
                    },
                    child: Container(
                      height: size.height * .08,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.blue, width: 2),
                        borderRadius:
                        BorderRadius.all(Radius.circular(10)),
                        gradient: LinearGradient (
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            AppColors.decoration1,
                            AppColors.decoration2,
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(12, 17, 0, 17),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${myfollowers['name']}",
                                  style: TitleStyle,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}


