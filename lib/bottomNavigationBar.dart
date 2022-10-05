import 'package:cs310_term_project/post/add_post.dart';
import 'package:cs310_term_project/feeds/feed.dart';
import 'package:cs310_term_project/post/post.dart';
import 'package:cs310_term_project/profile/profile.dart';
import 'package:cs310_term_project/search/searchScreen.dart';
import 'package:cs310_term_project/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:cs310_term_project/home.dart';



class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<MyBottomNavigationBar> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<MyBottomNavigationBar> {
  int selectedIndex = 0;

  //list of widgets to call ontap
  final widgetOptions = [
    new Home(),
    new SearchScreen(),
    new AddPost(),
    new Posts(),
    new Feeds(),
    new MyProfile(),

  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  final widgetTitle = ["Home", "Search", "Add Posts", "Posts", "Feeds",  "Profile"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: widgetOptions.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: AppColors.bottomNavbarIcons,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: AppColors.bottomNavbarIcons,
              ),
              label: "Search"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.photo_camera,
                color: AppColors.bottomNavbarIcons,
              ),
              label: "Add Posts"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.list,
                color: AppColors.bottomNavbarIcons,
              ),
              label: "Posts"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.feed,
                color: AppColors.bottomNavbarIcons,
              ),
              label: "Feeds"),

          BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle,
                color: AppColors.bottomNavbarIcons,
              ),
              label: "Profile"),
        ],
        currentIndex: selectedIndex,
        fixedColor: AppColors.bottomNavbarLabel,
        onTap: onItemTapped,
        selectedLabelStyle: TextStyle(color: AppColors.bottomNavbarLabel, fontSize: 20),
        unselectedFontSize: 16,
        selectedIconTheme:
        IconThemeData( opacity: 1.0, size: 30.0),
        unselectedIconTheme:
        IconThemeData( opacity: 1.0, size: 30.0),

      ),
    );
  }
}
