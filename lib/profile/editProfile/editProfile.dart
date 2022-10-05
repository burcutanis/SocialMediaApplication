import 'package:cs310_term_project/util/colors.dart';
import 'package:cs310_term_project/util/dimensions.dart';
import 'package:cs310_term_project/util/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../util/auth.dart';
class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String uid = "";

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final AuthService _auth = AuthService();
    final User? user = auth.currentUser;
    if(user != null){
      uid = user.uid;
      print(uid);
    }
    return Scaffold(
      appBar: AppBar(
          title: Text("Edit Profile"),
          backgroundColor: AppColors.appbarColor,
      ),
      body: SafeArea(
      child: Container(
        decoration: decoration,
      child: Padding(
        padding: Dimen.editProfileParentPadding,
        child: SingleChildScrollView(
          padding: Dimen.editProfilePadding,
          child: Column(
            children: [
              const Text("Profile Settings",
              style: TextStyle (
                fontWeight: FontWeight.bold,
                fontSize:20,
              )),
              SizedBox(height: 20),
              Card(
                color: AppColors.editProfileCardColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                margin: Dimen.editProfileCardMargin,
                child: Padding (
                  padding: Dimen.editProfileCardPadding,
                  child: Row (
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          shape:
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          backgroundColor: AppColors.editProfileCardColor,
                        ),

                        // Within the `FirstScreen` widget
                        onPressed: () {
                          // Navigate to the second screen using a named route.
                          Navigator.pushNamed(context, '/accountInfo');
                        },
                        child: const Text('Change Bio',
                            style: TextStyle(
                              color: AppColors.textMainColor,
                              fontSize: 20,
                            )),

                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.more),
                        onPressed: () {
                          Navigator.pushNamed(context, "/accountInfo");
                        },
                      ),
                    ],
                  ),
                ),
              ),

              /*
              Card(
                color: AppColors.editProfileCardColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                margin: Dimen.editProfileCardMargin,
                child: Padding (
                  padding: Dimen.editProfileCardPadding,
                  child: Row (
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          shape:
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          backgroundColor: AppColors.editProfileCardColor,
                        ),

                        // Within the `FirstScreen` widget
                        onPressed: () {
                          // Navigate to the second screen using a named route.
                          Navigator.pushNamed(context, '/reportUser');
                        },
                        child: const Text('Report User',
                            style: TextStyle(
                              color: AppColors.textMainColor,
                              fontSize: 20,
                            )),

                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.report),
                        onPressed: () {
                          Navigator.pushNamed(context, "/reportUser");
                        },
                      ),
                    ],
                  ),
                ),
              ),

              */

              Card(
                color: AppColors.editProfileCardColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                margin: Dimen.editProfileCardMargin,
                child: Padding (
                  padding: Dimen.editProfileCardPadding,
                  child: Row (
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          shape:
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          backgroundColor: AppColors.editProfileCardColor,
                        ),

                        // Within the `FirstScreen` widget
                        onPressed: () async {
                          Navigator.pushNamed(context, "/email");

                        },
                        child: const Text('Change Email',
                            style: TextStyle(
                              color: AppColors.textMainColor,
                              fontSize: 20,
                            )),
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.email),
                        onPressed: () async {
                          Navigator.pushNamed(context, "/email");
                        },
                      ),
                    ],
                  ),
                ),
              ),

              Card(
                color: AppColors.editProfileCardColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                margin: Dimen.editProfileCardMargin,
                child: Padding (
                  padding: Dimen.editProfileCardPadding,
                  child: Row (
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          shape:
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          backgroundColor: AppColors.editProfileCardColor,
                        ),

                        // Within the `FirstScreen` widget
                        onPressed: () async {
                          Navigator.pushNamed(context, "/username");

                        },
                        child: const Text('Change Username',
                            style: TextStyle(
                              color: AppColors.textMainColor,
                              fontSize: 20,
                            )),
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.person),
                        onPressed: () async {
                          Navigator.pushNamed(context, "/username");
                        },
                      ),
                    ],
                  ),
                ),
              ),

              Card(
                color: AppColors.editProfileCardColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                margin: Dimen.editProfileCardMargin,
                child: Padding (
                  padding: Dimen.editProfileCardPadding,
                  child: Row (
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          shape:
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          backgroundColor: AppColors.editProfileCardColor,
                        ),

                        // Within the `FirstScreen` widget
                        onPressed: () {
                          // Navigate to the second screen using a named route.
                          Navigator.pushNamed(context, '/changePassword');
                        },
                        child: const Text("Change Password",
                            style: TextStyle(
                              color: AppColors.textMainColor,
                              fontSize: 20,
                            )),

                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.password),
                        onPressed: () {
                          Navigator.pushNamed(context, "/changePassword");
                        },
                      ),
                    ],
                  ),
                ),
              ),
              /*
              Card(
                color: AppColors.editProfileCardColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                margin: Dimen.editProfileCardMargin,
                child: Padding (
                  padding: Dimen.editProfileCardPadding,
                  child: Row (
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          shape:
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          backgroundColor: AppColors.editProfileCardColor,
                        ),

                        // Within the `FirstScreen` widget
                        onPressed: () {
                          // Navigate to the second screen using a named route.
                          Navigator.pushNamed(context, '/disableAccount');
                        },
                        child: const Text('Deactivate Account',
                            style: TextStyle(
                              color: AppColors.textMainColor,
                              fontSize: 20,
                            )),

                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.account_circle),
                        onPressed: () {
                          Navigator.pushNamed(context, "/disableAccount");
                        },
                      ),
                    ],
                  ),
                ),
              ),

              */

              Card(
                color: AppColors.editProfileCardColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                margin: Dimen.editProfileCardMargin,
                child: Padding (
                  padding: Dimen.editProfileCardPadding,
                  child: Row (
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          shape:
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          backgroundColor: AppColors.editProfileCardColor,
                        ),

                        // Within the `FirstScreen` widget
                        onPressed: () async {

                          await FirebaseAuth.instance.currentUser!.delete();
                          await FirebaseAuth.instance.signOut();
                          Navigator.pushNamed(context, "/welcome");
                        },
                        child: const Text('Delete Account',
                            style: TextStyle(
                              color: AppColors.textMainColor,
                              fontSize: 20,
                            )),
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.delete),
                         onPressed: () async {
                            user!.delete();
                            await auth.signOut();
                            Navigator.pushNamed(context, '/welcome');
                          },
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                color: AppColors.editProfileCardColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                margin: Dimen.editProfileCardMargin,
                child: Padding (
                  padding: Dimen.editProfileCardPadding,
                  child: Row (
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          shape:
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          backgroundColor: AppColors.editProfileCardColor,
                        ),

                        // Within the `FirstScreen` widget
                        onPressed: () {
                          // Navigate to the second screen using a named route.
                          Navigator.pushNamed(context, '/login');
                        },
                        child: const Text('Logout',
                            style: TextStyle(
                              color: AppColors.textMainColor,
                              fontSize: 20,
                            )),

                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.logout),
                        onPressed: () async {
                          await _auth.signOut();
                          Navigator.pushNamed(context, '/welcome');
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
      ),
    );
  }
}
