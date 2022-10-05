import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_term_project/model/follower.dart';
import 'package:firebase_analytics/firebase_analytics.dart';


class FollowerDB {

  final CollectionReference followerCollection = FirebaseFirestore.instance.collection("follower");



  Future<void> deleteFollower(String name, String you) async {
    followerCollection.doc(name+you).delete()
        .then((value) => {
          FirebaseAnalytics.instance.logEvent(name: "User $you deleted follower $name.")
        })
        .catchError((error) => print("Failed to delete"));
  }
}