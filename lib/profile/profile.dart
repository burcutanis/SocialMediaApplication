
import 'package:cs310_term_project/getDB.dart';
import 'package:cs310_term_project/util/auth.dart';
import 'package:cs310_term_project/util/colors.dart';
import 'package:cs310_term_project/util/dimensions.dart';
import 'package:cs310_term_project/util/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';



class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  getDB _statusService = getDB();
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    String uid = "";
    if(user != null){
      uid = user.uid;
      print(uid);
    }
    while (user == null){
      return Scaffold(
          appBar: AppBar(
            title: Text("My Profile"),
            backgroundColor: AppColors.appbarColor,
            actions: [
              IconButton(
                icon: Icon(Icons.message),
                onPressed: () {
                  Navigator.pushNamed(context, "/messages");
                },
              ),
              IconButton(
                icon: Icon(Icons.add_alert),
                onPressed: () {
                  Navigator.pushNamed(context, "/notifications");
                },
              ),
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  Navigator.pushNamed(context, "/editProfile");
                },
              ),
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: () async {
                  await _auth.signOut();
                  Navigator.pushNamed(context, '/login');
                },
              ),
            ],
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

    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile"),

        backgroundColor: AppColors.appbarColor,
        actions: [
          IconButton(
            icon: Icon(Icons.message),
            onPressed: () {
              Navigator.pushNamed(context, "/messages");
            },
          ),
          IconButton(
            icon: Icon(Icons.add_alert),
            onPressed: () {
              Navigator.pushNamed(context, "/notifications");
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, "/editProfile");
            },
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await _auth.signOut();
              Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
            },
          ),
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
                return Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            AppColors.decoration1,
                            AppColors.decoration2,
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(
                            5, 5, 5, 500),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment
                              .spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets
                                      .fromLTRB(
                                      10, 10, 16, 0),
                                  child: CircleAvatar(
                                    backgroundColor: Colors
                                        .grey,
                                    child: ClipOval(
                                      child: TextButton(
                                          style: TextButton
                                              .styleFrom(
                                            shape:
                                            RoundedRectangleBorder(
                                                borderRadius: BorderRadius
                                                    .circular(
                                                    15)),
                                            backgroundColor: AppColors
                                                .editProfileCardColor,
                                          ),

                                          onPressed: () {
                                            Navigator
                                                .pushNamed(
                                                context,
                                                '/profile_picture');
                                          },
                                          child: myuser['profilePicture'] ==
                                              ""
                                              ? CircleAvatar(
                                            child:Text("${myuser['username']}"[0].toUpperCase(),
                                              style: TextStyle(
                                                fontSize: 25,
                                              ),
                                            ),
                                            radius: 30,
                                          )
                                              :
                                          Image(
                                            image: NetworkImage(
                                              myuser['profilePicture'],),
                                            fit: BoxFit.fill,)
                                      ),
                                    ),
                                    radius: 60,
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment
                                      .start,
                                  children: [
                                    Padding(
                                      padding: Dimen
                                          .profileIconPadding,
                                      child: Text("${myuser['postNum']}",
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, '/post');
                                      },
                                      child: const Text(
                                          'Posts',
                                          style: TextStyle(
                                            color: AppColors
                                                .textMainColor,
                                            fontSize: 18,
                                          )),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment
                                      .start,
                                  children: [
                                    Padding(
                                      padding: Dimen
                                          .profileIconPadding,
                                      child: Text(
                                        "${myuser['followers']}",
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context,
                                            '/follower');
                                      },
                                      child: const Text(
                                          'Follower',
                                          style: TextStyle(
                                            color: AppColors
                                                .textMainColor,
                                            fontSize: 18,
                                          )),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment
                                      .start,
                                  children: [
                                    Padding(
                                      padding: Dimen
                                          .profileIconPadding,
                                      child: Text(
                                        "${myuser['following']}",
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context,
                                            '/following');
                                      },
                                      child: const Text(
                                          'Following',
                                          style: TextStyle(
                                            color: AppColors
                                                .textMainColor,
                                            fontSize: 18,
                                          )),
                                    ),
                                  ],
                                ),

                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(40, 12, 0, 0),
                                  child: Text("${myuser['username']}",
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                        fontWeight: FontWeight
                                            .bold,
                                        fontSize: 20,
                                      )),
                                ),
                              ],
                            ),
                            SizedBox(height: 10,),
                            const Text(
                              "My BIO",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              width: 450,
                              height: 130,
                              child: Card(
                                color: Colors.grey.shade300,
                                margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18)),
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
                                          Row(
                                            children: [

                                              SizedBox(width: 20,),
                                              myuser['bio'] == ""
                                                  ? const Expanded(
                                                  child: Text("You can write informations about yourself here",
                                                    textAlign: TextAlign.start,
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 20,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                    ),
                                                  )
                                              )

                                                  : Expanded(
                                                  child: Text("${myuser['bio']}",
                                                    textAlign: TextAlign.start,
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 20,
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                    ),
                                                  )
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
                            SizedBox(height: 10,),
                            const Divider(
                              color: Colors.purple,
                              thickness: 2.5,
                              height: 15,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, '/post');
                              },
                              child: const Text(
                                  'My posts',
                                  style: TextStyle(
                                    color: AppColors
                                        .textMainColor,
                                    fontSize: 25,
                                  )),
                            ),

                            const Divider(
                              color: Colors.purple,
                              thickness: 2.5,
                              height: 15,
                            ),



                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
          );

        },

      ),
    );

  }
}





