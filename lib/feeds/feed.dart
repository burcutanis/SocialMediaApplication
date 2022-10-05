import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_term_project/model/feed.dart';
import 'package:cs310_term_project/util/auth.dart';
import 'package:cs310_term_project/util/colors.dart';
import 'package:cs310_term_project/feeds/feed_class.dart';
import 'package:cs310_term_project/util/dimensions.dart';
import 'package:cs310_term_project/util/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../getDB.dart';


class Feeds extends StatefulWidget {
  const Feeds({Key? key}) : super(key: key);

  @override
  State<Feeds> createState() => _FeedsState();
}

class _FeedsState extends State<Feeds> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
        value: AuthService().user,
    initialData: null,
    child: Feeds2(),
    );
  }
}

/*
 class Userclass {
  String? userName;

  void showDisplayName(String userUid) async {
    var collection = FirebaseFirestore.instance.collection('users');
    var docSnapshot = await collection.doc(userUid).get();

    Map<String, dynamic> data = docSnapshot.data()!;

    userName = data['email'];
    print(userName);

  }
}

*/



class Feeds2 extends StatefulWidget {
  @override
  _Feeds2State createState() => _Feeds2State();
}

class _Feeds2State extends State<Feeds2> {
  getDB _statusService = getDB();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;



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


    return Scaffold(
        appBar: AppBar(
          title: Text("Feeds Page"),
          centerTitle: true,
          backgroundColor: AppColors.appbarColor,
        ),
        body: StreamBuilder<QuerySnapshot> (
          stream: _statusService.getFeed(),
          builder: (context, snaphot) {
            return !snaphot.hasData
                ? CircularProgressIndicator()
                : ListView.builder(
                itemCount: snaphot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot mypost = snaphot.data!.docs[index];

                  String ownerIdStr = "${mypost['ownerId']}";
                 /*
                  Future<String?> getUsername(String id) async  {
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(id)
                        .get()
                        .then((DocumentSnapshot documentSnapshot) {
                      if (documentSnapshot.exists) {
                        print('Document exists on the database');
                        String? usernamex = documentSnapshot.get("username") ;
                        return usernamex;
                      }
                    }).asStream();
                  }
                  */

                  String? email =  "${mypost['ownerEmail']}";
                  List<String> emailList = email.split("@");
                  print(emailList[0]);
                  print(email);


               /*
                 Future<String?> getname(id) async {
                   await FirebaseFirestore.instance
                       .collection('users')
                       .doc(id)
                       .get()
                       .then((DocumentSnapshot documentSnapshot) {
                     if (documentSnapshot.exists) {
                       print('Document exists on the database');

                       String? usernamex = documentSnapshot.get("username");
                       return usernamex;
                     }
                   });
                 }
                  FeedUsername = getname(ownerIdStr);
                 print(FeedUsername);
                 */

                /* Userclass userobj = Userclass();
                 userobj.showDisplayName(ownerIdStr);
                 print(userobj.userName);*/

                  IncreaseLikes(String id) async {
                    var db = await FirebaseFirestore.instance;
                    String likeStr = "${mypost['likes'].toString()}";
                    var likeInt = int.parse(likeStr);
                    assert(likeInt is int);
                    print(likeInt);
                    likeInt++;
                    db.collection("posts").doc(id).set({
                      "likes" :  likeInt,
                    }, SetOptions(merge: true))
                        .onError((e, _) => print("Error writing document: $e"));
                  }

                  IncreaseDislikes(String id) async {
                    var db = await FirebaseFirestore.instance;
                    String DislikeStr = "${mypost['comments'].toString()}";
                    var DislikeInt = int.parse(DislikeStr);
                    assert(DislikeInt is int);
                    print(DislikeInt);
                    DislikeInt++;
                    db.collection("posts").doc(id).set({
                      "comments" :  DislikeInt,
                    }, SetOptions(merge: true))
                        .onError((e, _) => print("Error writing document: $e"));
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
                                Text(
                                  "-",
                                  style: feedtitleStyle,
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(width:5),
                                Text(
                                  emailList[0],
                                  style: feedtitleStyle,
                                  textAlign: TextAlign.center,
                                ),
                                Spacer(),
                                Text(
                                  "${mypost['date']}",
                                  style: feedtextStyle,
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
                                Spacer(),
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
                                  iconSize: 14,
                                  onPressed: () {
                                    IncreaseLikes(mypost.id);
                                    print("likes");
                                  },
                                  icon: const Icon(Icons.thumb_up, size: 14, color: AppColors.IconColor,),
                                ),

                                Text(
                                  "${mypost['comments'].toString()}",
                                  style: feedLikeCommentStyle,
                                ),
                                IconButton(
                                  iconSize: 14,
                                  onPressed: () {
                                    IncreaseDislikes(mypost.id);
                                    print("likes");
                                  },
                                  icon: const Icon(Icons.thumb_down, size: 14, color: AppColors.IconColor,),
                                ),
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

