import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class NotificationDB {

  final CollectionReference notificationCollection = FirebaseFirestore.instance.collection("notifications");

  Future<void> addNotification(String receiver, String sender, String content, String notificationDatetime, int notificationId) async {
    notificationCollection.doc(notificationId.toString()).set({
      'receiver': receiver,
      'sender': sender,
      'content':content,
      'notificationId': notificationId,
      'notificationDatetime':notificationDatetime
    })
        .then((value) => print("Notification added"))
        .catchError((error)=>print("Failed to add"));
  }

  Future<void> deleteNotification(int notificationId) async {
    FirebaseAnalytics.instance.logEvent(name: "User deleted a notification");
    notificationCollection.doc(notificationId.toString()).delete()
        .then((value) => print("Notification deleted"))
        .catchError((error) => print("Failed to delete"));
  }

}