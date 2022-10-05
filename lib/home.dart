
import 'package:cs310_term_project/home.dart';
import 'package:cs310_term_project/util/colors.dart';
import 'package:cs310_term_project/util/dimensions.dart';
import 'package:cs310_term_project/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cs310_term_project/bottomNavigationBar.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}


class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: TextButton(
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
      appBar: AppBar(
        title: Text("Home Page"),
        centerTitle: true,
        backgroundColor: AppColors.appbarColor,
      ),
      body: SafeArea(
      child: Container(
        decoration: decoration,
      child: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 40, 5, 300),
            child: Column(
              children: [
                Text("Welcome To SuForm",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                  ),
                ),
                SizedBox(height:20),
                Image.asset("assets/SuDorm.png", width: 140, height: 140),
                SizedBox(height:20),
                Row(
                  children: [
                    SizedBox(
                      height: 150,
                      width:200,
                      child: Card(
                        color: AppColors.editProfileCardColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        margin: Dimen.editProfileCardMargin,
                        child: Padding (
                          padding: Dimen.editProfileCardPadding,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              shape:
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                              backgroundColor: Colors.orangeAccent,
                            ),

                            // Within the `FirstScreen` widget
                            onPressed: () {
                              // Navigate to the second screen using a named route.
                              Navigator.pushNamed(context, '/search');
                            },
                            child: const Text('Go to Search Page',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.textMainColor,
                                  fontSize: 20,
                                )),

                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 150,
                      width:200,
                      child: Card(
                        color: AppColors.editProfileCardColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        margin: Dimen.editProfileCardMargin,
                        child: Padding (
                          padding: Dimen.editProfileCardPadding,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              shape:
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                              backgroundColor: Colors.cyanAccent,
                            ),

                            // Within the `FirstScreen` widget
                            onPressed: () {
                              // Navigate to the second screen using a named route.
                              Navigator.pushNamed(context, '/feed');
                            },
                            child: const Text('Go to Feeds Page',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.textMainColor,
                                  fontSize: 20,
                                )),

                          ),
                        ),
                      ),
                    ),


                  ],
                ),
                SizedBox(height:20),
                Row(
                  children: [
                    SizedBox(
                      height: 150,
                      width:200,
                      child: Card(
                        color: AppColors.editProfileCardColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        margin: Dimen.editProfileCardMargin,
                        child: Padding (
                          padding: Dimen.editProfileCardPadding,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              shape:
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                              backgroundColor: Colors.greenAccent,
                            ),

                            // Within the `FirstScreen` widget
                            onPressed: () {
                              // Navigate to the second screen using a named route.
                              Navigator.pushNamed(context, '/post');
                            },
                            child: const Text('Go to My Post Page',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.textMainColor,
                                  fontSize: 20,
                                )),

                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 150,
                      width:200,
                      child: Card(
                        color: AppColors.editProfileCardColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        margin: Dimen.editProfileCardMargin,
                        child: Padding (
                          padding: Dimen.editProfileCardPadding,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              shape:
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                              backgroundColor: Colors.redAccent.shade100,
                            ),

                            // Within the `FirstScreen` widget
                            onPressed: () {
                              // Navigate to the second screen using a named route.
                              Navigator.pushNamed(context, '/profile');
                            },
                            child: const Text('Go to your Profile',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.textMainColor,
                                  fontSize: 20,
                                )),

                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),

    ),
    ),
    );

  }
}

