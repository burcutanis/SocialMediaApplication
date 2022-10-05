import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_term_project/model/accountInfo.dart';
import 'package:cs310_term_project/util/colors.dart';
import 'package:cs310_term_project/util/dimensions.dart';
import 'package:cs310_term_project/util/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
class EditBio extends StatefulWidget {
  const EditBio({Key? key}) : super(key: key);

  @override
  State<EditBio> createState() => _EditBioState();
}

class _EditBioState extends State<EditBio> {
  String bio = "";
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    String uid = "";
    if(user != null){
      uid = user.uid;
      print(uid);
    }

    Future uploadBioToFirebase(BuildContext context) async {
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      var db = await FirebaseFirestore.instance;
      db.collection("users").doc(uid).set({
        "bio" : bio
      }, SetOptions(merge: true))
          .onError((e, _) => print("Error writing document: $e"));
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit the Bio",
        ),
        backgroundColor: AppColors.buttonMainColor,
      ),
      body: SafeArea(
        child: Container(
          decoration: decoration,
          child: SafeArea (
            child: SingleChildScrollView(
              child: Padding (
                padding: Dimen.regularParentPadding,
                child: Form (
                  key: _formKey,
                  child: Column (
                    children: [
                      Padding(
                        padding: Dimen.editBio,
                        child: Column(
                          children: [
                            TextFormField(
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                contentPadding: Dimen.textContentPadding,
                                label: Container(
                                  width: 200,
                                  child: Row(
                                    children: const [
                                      const SizedBox(width: 4),
                                      const Text('Enter a new bio'),
                                    ],
                                  ),
                                ),
                                fillColor: AppColors.cardColor,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: AppColors.buttonMainColor,
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              validator: (value) {
                                if(value != null){
                                  if(value.isEmpty) {
                                    return 'Cannot leave e-mail empty';
                                  }
                                }
                              },
                              onSaved: (value) {
                                bio = value?? '';
                                print(bio);
                              },
                            ),
                            const SizedBox(height: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SizedBox(
                                  width: 60.0,
                                  height: 60.0,
                                  child: ElevatedButton(
                                    style: TextButton.styleFrom(
                                      shape:
                                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                      primary: AppColors.white,
                                      backgroundColor: AppColors.buttonMainColor,
                                    ),
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState!.save();
                                        await uploadBioToFirebase(context);
                                        Navigator.pushNamed(context, "/myBottomNavigationBar");
                                      }
                                    },
                                    child: const Text("Change Bio",
                                      style: TextStyle (
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
