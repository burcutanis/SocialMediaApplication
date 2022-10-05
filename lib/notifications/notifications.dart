import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_term_project/model/notifications.dart';
import 'package:cs310_term_project/util/colors.dart';
import 'package:cs310_term_project/util/dimensions.dart';
import 'package:cs310_term_project/util/styles.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cs310_term_project/notifications/notifications.dart';
import 'package:cs310_term_project/notifications/notification_card.dart';
import 'package:cs310_term_project/notifications/notification_db.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {

  String username = "";
  String uid = "";
  dynamic _user = [];
  String? email = "";

  List<AppNotification> notifications = [
    AppNotification(notificationDatetime: DateTime.now(), content: "Page", receiver: "this", sender: "Refresh", notificationId: 0)
  ];

  void deleteNotification(AppNotification notification){
    setState(() {
      notifications.remove(notification);
      db.deleteNotification(notification.notificationId);
    });
  }

  NotificationDB db = NotificationDB();
  callNotifications() async {


    await FirebaseAnalytics.instance.logEvent(name: "User called for notifications");


    //FirebaseAuth.instance.signInWithEmailAndPassword(email: "deneme@gmail.com", password: "deneme");
    notifications.clear();
    List<dynamic> allnotifications = [];
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    if(user != null){
      uid = user.uid;
      print(uid);
      email = user.email;
    }


    await FirebaseFirestore.instance.collection("users").doc(uid).get().then((value) => {_user.add(value.data())});
    await db.notificationCollection.get().then((snapshot) => snapshot.docs.forEach((element) {allnotifications.add(element.data());}));
    username = _user[0]["username"];
    setState(() {

      allnotifications.forEach((element) => {
        if(element["receiver"] == email){
          notifications.add(AppNotification(
              notificationDatetime: DateTime.parse(element["notificationDatetime"]),
              content: element["content"],
              receiver: element["receiver"],
              sender: element["sender"],
              notificationId: element["notificationId"]))}
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(

        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Notifications"),
          backgroundColor: AppColors.appbarColor,
          elevation: 0.0,
          actions: [IconButton(onPressed: () => {callNotifications()}, icon: Icon(Icons.refresh_outlined))],
        ),

        body: FutureBuilder(
            future: db.notificationCollection.get(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.done && snapshot.hasData && snapshot.data != null){

                return SafeArea(
                  child: Container(
                    decoration: decoration,
                    child: SingleChildScrollView(
                      child: SafeArea(

                        child: Padding(
                          padding: Dimen.messageNotificationPadding,
                          child: Column(
                            children: [
                              Column(
                                children:
                                notifications.map((notification) => NotificationCard(notification: notification, delete: (){deleteNotification(notification);})).toList(),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
              else{
                return Center(
                  child: Container(
                    padding: const EdgeInsets.only(top: 300.0),
                    child: Column(
                        children: const [
                          CircularProgressIndicator(),
                          Text("Waiting for loading...", style: TextStyle(fontSize: 24.0),)
                        ]
                    ),
                  ),
                );
              }
            }
        )


    );
  }
}