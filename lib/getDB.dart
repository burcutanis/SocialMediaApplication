import 'dart:io';
import 'package:cs310_term_project/post/storage_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class getDB {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  StorageService _storageService = StorageService();

  //show the post
  Stream<QuerySnapshot> getPost(String uid) {
    var ref = _firestore.collection("posts").where("ownerId", isEqualTo: uid).snapshots();

    return ref;
  }

  Stream<QuerySnapshot> getFeed() {
    var ref = _firestore.collection("posts").snapshots();

    return ref;
  }

  Stream<QuerySnapshot> getUser(String uid) {
    var ref = _firestore.collection("users").where("uid", isEqualTo: uid).snapshots();
    return ref;
  }

  Stream<QuerySnapshot> getBio(String uid) {
    var ref = _firestore.collection("bio").where("uid", isEqualTo: uid).snapshots();
    return ref;
  }




  Future<String?> getUsername(String uid) async  {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document exists on the database');

      }
      String? usernamex = documentSnapshot.get("username") ;
     // print(usernamex);
      return usernamex;
    });
  }

  /*Stream <DocumentSnapshot> getLike(String id) {
      var ref = _firestore.collection('likes').doc(id).get();
      return ref ;

    }*/



  Stream<QuerySnapshot> getFollowers(String uid) {
    var ref = _firestore.collection("follower").where("you", isEqualTo: uid).snapshots();
    return ref;
  }

  Stream<QuerySnapshot> getFollowings(String uid) {
    var ref = _firestore.collection("following").where("you", isEqualTo: uid).snapshots();
    return ref;
  }


  //delete the post
  Future<void> removePost(String docId) {
    var ref = _firestore.collection("posts").doc(docId).delete();

    return ref;
  }

  Future<void> removeFollowers(String docId) {
    var ref = _firestore.collection("follower").doc(docId).delete();
    return ref;
  }

  Future<void> removeFollowings(String docId) {
    var ref = _firestore.collection("following").doc(docId).delete();
    return ref;
  }

  Future<void> removeUser(String uid) {
    var ref = _firestore.collection("users").doc(uid).delete();

    return ref;
  }
}



