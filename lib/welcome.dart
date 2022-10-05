import 'dart:convert';
import 'dart:core';

import 'package:cs310_term_project/util/colors.dart';
import 'package:cs310_term_project/util/dimensions.dart';
import 'package:cs310_term_project/util/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:search_page/search_page.dart';
import 'package:cs310_term_project/welcome.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        title: const Text('Welcome Screen'),
        backgroundColor: AppColors.appbarColor,
      ),
      body: SafeArea(
        child: Container(
            decoration: decoration,

          child: Container(
          color: Colors.white54,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 100, 10, 0),
                child: Center(
                  child: Column(
                    children: [
                      const Text("Welcome To ",
                        style: TextStyle(
                            fontFamily: "Signatra",
                            fontSize: 45,
                            fontWeight: FontWeight.w800,
                            color: AppColors.welcome,
                         ),
                      ),
                      const Text("SuForm",
                             style: TextStyle(
                            fontFamily: "Signatra",
                            fontSize: 45,
                               fontWeight: FontWeight.w800,
                               color: AppColors.welcome,
                         ),
                      ),
                      SizedBox(height: 20),
                      Image.asset("assets/SuDorm.png", width: 170, height: 200),
                    ],
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.fromLTRB(3, 20, 3, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget> [
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        width:120,
                        height: 50,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            shape:
                               RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            backgroundColor: AppColors.buttonMainColor,
                          ),

                          // Within the `FirstScreen` widget
                          onPressed: () {
                            // Navigate to the second screen using a named route.
                            Navigator.pushNamed(context, '/login');
                          },
                          child: const Text('Login',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 20,
                          )),

                        ),
                      ),
                    ),
                    SizedBox(width: 15.0,),
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        width:120,
                        height: 50,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            shape:
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            backgroundColor: AppColors.buttonMainColor,
                          ),

                          // Within the `FirstScreen` widget
                          onPressed: () {
                            // Navigate to the second screen using a named route.
                            Navigator.pushNamed(context, '/register');
                          },
                          child: const Text('Register',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 20,
                              )),

                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ),
    ),
    );
  }
}