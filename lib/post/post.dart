
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_term_project/model/feed.dart';
import 'package:cs310_term_project/util/auth.dart';
import 'package:cs310_term_project/util/colors.dart';
import 'package:cs310_term_project/feeds/feed_class.dart';
import 'package:cs310_term_project/util/dimensions.dart';
import 'package:cs310_term_project/util/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../getDB.dart';


class Posts extends StatefulWidget {
  const Posts({Key? key}) : super(key: key);

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
      value: AuthService().user,
      initialData: null,
      child: Posts2(),
    );
  }
}


class Posts2 extends StatefulWidget {
  @override
  _Posts2State createState() => _Posts2State();
}

class _Posts2State extends State<Posts2> {
  getDB _statusService = getDB();



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final user = Provider.of<User?>(context);

    while (user == null){
      return Scaffold(
          appBar: AppBar(
            title: Text("My Posts"),
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
    String? email = user.email ?? "test";
    List<String> emailList = email.split("@");
    print(emailList[0]);
    return Scaffold(
        appBar: AppBar(
          title: Text("My Posts"),
          centerTitle: true,
          backgroundColor: AppColors.appbarColor,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: _statusService.getPost(uid),
          builder: (context, snaphot) {
            return !snaphot.hasData
                ? CircularProgressIndicator()
                : ListView.builder(
                itemCount: snaphot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot mypost = snaphot.data!.docs[index];


                  setPostCount() async {
                    var db = await FirebaseFirestore.instance;

                    db.collection("users").doc(uid).set({
                      "postNum": snaphot.data!.docs.length
                    }, SetOptions(merge: true))
                        .onError((e, _) => print("Error writing document: $e"));
                  }
                  setPostCount();

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
                                              .removePost(mypost.id);
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
                    child: Container(
                      height: size.height * .23,
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
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(height: 10),
                            Row(
                              children: [
                                SizedBox(width: 15),
                                Text(
                                  "${mypost['title']}",
                                  style: feedtitleStyle,
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(width:5),
                                Spacer(),
                                Text(
                                  "${mypost['date']}",
                                  style:  TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,),
                                ),
                                SizedBox(width:10),
                              ],
                            ),
                            SizedBox(height:10),
                            Row(
                              children: [
                                Center(
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(mypost['image']),
                                      radius: size.height * 0.04,
                                    )),
                                SizedBox(width:15),
                                Text(
                                  "${mypost['text']}",
                                  style: feedLikeCommentStyle,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "${mypost['likes'].toString()}",
                                  style: feedLikeCommentStyle,
                                ),
                                IconButton(
                                  iconSize: 16,
                                  onPressed: () {
                                    print("likes");
                                  },
                                  icon: const Icon(Icons.thumb_up, size: 16, color: AppColors.IconColor,),
                                ),

                                SizedBox(width:10),
                                Text(
                                  "${mypost['comments'].toString()}",
                                  style: feedLikeCommentStyle,
                                ),
                                IconButton(
                                  iconSize: 16,
                                  onPressed: () {
                                    print("dislikes");
                                  },
                                  icon: const Icon(Icons.thumb_down, size: 16, color: AppColors.IconColor,),
                                ),
                                SizedBox(width:10),
                                IconButton(
                                  iconSize: 18,
                                  onPressed: () {
                                    _showChoiseDialog(context);
                                  },
                                  icon: const Icon(Icons.delete, size: 18, color: AppColors.IconColor,),
                                ),
                                /*
                                        IconButton(
                                          iconSize: 14,
                                          onPressed: report,
                                          icon: const Icon(Icons.report, size: 14, color: AppColors.IconColor,),
                                        ),*/

                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          },
        )
    );
  }
}

