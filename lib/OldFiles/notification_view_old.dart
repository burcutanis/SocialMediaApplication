import 'package:flutter/material.dart';
import 'package:cs310_term_project/notification_old.dart';
import 'package:cs310_term_project/notification_card._olddart';

class NotificationView extends StatefulWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  List<AppNotification> notifications = [
    AppNotification(notificationDatetime: DateTime(2022,04,23), content: " liked your post.", receiver: "Gurkan", sender: "Bahadır", notificationId: 1),
    AppNotification(notificationDatetime: DateTime(2022,05,10), content: " sent you a message.", receiver: "Burcu", sender: "Yekta", notificationId: 1),
    AppNotification(notificationDatetime: DateTime(2022,05,16), content: " followed you.", receiver: "Meltem", sender: "Burcu", notificationId: 1)

  ];


  void deleteNotification(AppNotification notification){
    setState(() {
      notifications.remove(notification);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Notifications", style: TextStyle(color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Column(
                    children: notifications.map((notification) => NotificationCard(notification: notification, delete: (){deleteNotification(notification);})).toList()
                )
              ],
            ),
          ),
        ),
      ),

    );
  }
}
