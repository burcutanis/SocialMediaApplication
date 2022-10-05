import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_term_project/model/following.dart';
import 'package:firebase_analytics/firebase_analytics.dart';


class FollowingDB {

  final CollectionReference followingCollection = FirebaseFirestore.instance.collection("following");



  Future<void> deleteFollowing(String name, String you) async {
    followingCollection.doc(you+name).delete()
        .then((value) => FirebaseAnalytics.instance.logEvent(name: "User $you deleted follower $name."))
        .catchError((error) => print("Failed to delete"));
  }
}