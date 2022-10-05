import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? _userFromFirebase(User? user) {
    return user;
  }

  Stream<User?> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
  }
  Future<dynamic> signInWithEmailPass(String email, String pass) async {
    try {
      UserCredential uc = await _auth.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );
      return uc.user;
    } on FirebaseAuthException catch (e) {
      if(e.code == 'user-not-found') {
        return e.message ?? 'E-mail and/or Password not found';
      } else if(e.code == 'wrong-password') {
        return e.message ?? 'Password is not correct';
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> registerUserWithEmailPass(String email, String pass, String username) async {
    try {
      var uc = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      await _firestore
          .collection("users")
          .doc(uc.user!.uid)
          .set ({
        'username': username,
        'email': email,
        'uid':  uc.user!.uid,
        'profilePicture': "",
        'followers': 0,
        'following': 0,
        'postNum': 0,
        'bio': "",
      });
      return uc.user;
    } on FirebaseAuthException catch (e) {
      if(e.code == 'email-already-in-use') {
        return e.message ?? 'E-mail already in use';
      } else if (e.code == 'weak-password') {
        return e.message ?? 'Your password is weak';
      }
    }
  }

  Future signOut() async {
    await _auth.signOut();
  }
}

