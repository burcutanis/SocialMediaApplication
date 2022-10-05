import 'package:cs310_term_project/util/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class DeleteAccount extends StatefulWidget {
  const DeleteAccount({Key? key}) : super(key: key);

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delete Account"),
        backgroundColor: AppColors.appbarColor,
      ),
      body: RaisedButton(
          onPressed: () async {
            FirebaseAuth.instance.currentUser?.delete();
            await FirebaseAuth.instance.signOut();
          }
      )
    );
  }
}
