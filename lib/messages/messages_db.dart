import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class MessageDB {

  final CollectionReference messageCollection = FirebaseFirestore.instance.collection("messages");

  Future<void> addMessage(String receiver, String sender, String text, String date, String title) async {
    await FirebaseAnalytics.instance.logEvent(name: "User $sender sent a message to $receiver");
    await messageCollection.add({
      'receiver': receiver,
      'sender': sender,
      'text':text,
      'title': title,
      'date':date
    })
        .then((value) => print("Message added"))
        .catchError((error)=>print("Failed to add"));
  }
}