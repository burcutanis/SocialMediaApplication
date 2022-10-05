import 'dart:convert';
import 'dart:core';


import 'package:cs310_term_project/messages/sendMessages.dart';
import 'package:cs310_term_project/post/add_post.dart';
import 'package:cs310_term_project/post/editPost.dart';
import 'package:cs310_term_project/login_register/login.dart';
import 'package:cs310_term_project/login_register/register.dart';
import 'package:cs310_term_project/profile/Following/addFollowing.dart';
import 'package:cs310_term_project/profile/editProfile/bioInfo.dart';
import 'package:cs310_term_project/profile/editProfile/editBio.dart';
import 'package:cs310_term_project/profile/Follower/follower.dart';
import 'package:cs310_term_project/bottomNavigationBar.dart';
import 'package:cs310_term_project/profile/editProfile/editEmail.dart';
import 'package:cs310_term_project/profile/editProfile/editUsername.dart';
import 'package:cs310_term_project/profile/editProfile/email.dart';
import 'package:cs310_term_project/profile/editProfile/changePassword.dart';
import 'package:cs310_term_project/profile/editProfile/deleteAccount.dart';
import 'package:cs310_term_project/profile/editProfile/editProfile.dart';
import 'package:cs310_term_project/feeds/feed.dart';
import 'package:cs310_term_project/home.dart';
import 'package:cs310_term_project/messages/messages.dart';
import 'package:cs310_term_project/notifications/notifications.dart';
import 'package:cs310_term_project/post/post.dart';
import 'package:cs310_term_project/profile/Following/following.dart';
import 'package:cs310_term_project/profile/editProfile/username.dart';
import 'package:cs310_term_project/profile/profile.dart';
import 'package:cs310_term_project/profile/profile_picture.dart';


import 'package:cs310_term_project/search/searchScreen.dart';
import 'package:cs310_term_project/util/auth.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:cs310_term_project/welcome.dart';

import 'package:flutter/material.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /* DatabaseReference ref = FirebaseDatabase.instance.ref("users");

  await ref.set({
    "name": "John",
    "age": 18,
    "address": {
      "line1": "100 Street View"
    }
  });
  User data;*/


  runApp(
    MaterialApp(
      title: 'CS 310 TERM PROJECT',
      // Start the app with the "/" named route. In this case, the app starts
      // on the FirstScreen widget.

      home: MyFirebaseApp(),
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/welcome': (context) => const WelcomeScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/search': (context) => SearchScreen(),
        '/login' : (context) => Login(),
        '/register': (context) => Register(),
        '/home': (context) => Home(),
        '/profile': (context) => MyProfile(),
        '/myBottomNavigationBar': (context) => MyBottomNavigationBar(),
        // MyBottomNavigationBar.routeName: (context) => MyBottomNavigationBar(), // We pass here the data
        '/editProfile': (context) => EditProfile(),
        '/messages': (context) => MyMessages(),
        '/notifications': (context) => NotificationView(),
        '/feed': (context) => Feeds(),
        '/post': (context) => Posts(),
        '/accountInfo': (context) => AccountInfo(),
        '/email': (context) => MyEmail(),
        '/username': (context) => MyUsername(),
        '/changePassword': (context) => ChangePassword(),
        '/deleteAccount': (context) => DeleteAccount(),
        '/add_post': (context) => AddPost(),
        '/follower': (context) => MyFollowers(),
        '/following': (context) => MyFollowing(),
        '/editPost': (context) => EditPost(),
        '/profile_picture': (context) => ImageUploads(),
        '/editBio': (context) => EditBio(),
        '/editEmail': (context) => EditEmail(),
        '/editUsername': (context) => EditUsername(),
        '/sendMessages': (context) => SendMessages(),
        '/addFollowing': (context) => AddFollowings(),


      },
    ),
  );
}

class MyFirebaseApp extends StatelessWidget {

  //final Future<FirebaseApp> _init = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    /*return FutureBuilder(
      future: _init,
      builder: (context, snapshot) {
        if(snapshot.hasError) {
          return ErrorScreen(message: snapshot.error.toString());
        }
        if(snapshot.connectionState == ConnectionState.done) {*/
    return StreamProvider<User?>.value(
      value: AuthService().user,
      initialData: null,
      child: AuthenticationStatus(),
    );/*
        }
        return const WaitingScreen();
      },);*/
  }
}


class AuthenticationStatus extends StatefulWidget {
  const AuthenticationStatus({Key? key}) : super(key: key);

  @override
  State<AuthenticationStatus> createState() => _AuthenticationStatusState();
}

class _AuthenticationStatusState extends State<AuthenticationStatus> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    if (user == null ) {
      return WelcomeScreen();
    }
    else {
      return MyBottomNavigationBar();
    }
  }
}


class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key, required this.message}) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CS310 Spring'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(message),
      ),
    );
  }
}


class WaitingScreen extends StatelessWidget {
  const WaitingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: const Text('Connecting to Firebase', style: TextStyle(fontSize: 24,)),
        ),
      ),
    );
  }
}


