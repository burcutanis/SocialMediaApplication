import 'package:flutter/material.dart';

class Dimen {
  static const double parentMargin = 20.0;
  static const double bigParentMargin = 25.0;
  static const double regularMargin2 = 12.0;
  static const double regularMargin = 8.0;
  static const double login_left = 50.0;
  static const double login_right = 50.0;
  static const double login_top = 10.0;
  static const double editP_right = 20.0;
  static const double editP_left = 20.0;
  static const double editP_top = 10.0;

  static get regularParentPadding => const EdgeInsets.all(parentMargin);
  static get bigParentPadding => const EdgeInsets.all(bigParentMargin);
  static get regularPadding => const EdgeInsets.all(regularMargin);
  static get editProfileCardPadding => const EdgeInsets.all(regularMargin2);
  static get messageCardPadding => const EdgeInsets.all(regularMargin2);
  static get editProfileCardMargin=> const EdgeInsets.fromLTRB(10, 8, 0, 8);
  static get reportFeed => const   EdgeInsets.fromLTRB(40, 30, 40, 500);
  static get editBio => const   EdgeInsets.fromLTRB(40, 30, 40, 500);
  static get messageCardMargin=> const EdgeInsets.fromLTRB(10, 8, 0, 8);
  static get editProfileParentPadding => const EdgeInsets.fromLTRB(editP_left, editP_top, editP_right, 0);
  static get loginPadding => const EdgeInsets.fromLTRB(login_left, login_top, login_right, 0);
  static get loginPadding1 => const  EdgeInsets.fromLTRB(40, 30, 40, 80);
  static get registerPadding => const  EdgeInsets.fromLTRB(40, 30, 40, 30);
  static get messageNotificationPadding =>   const EdgeInsets.fromLTRB(25, 25, 25, 700);
  static get editEmailPadding =>   const EdgeInsets.fromLTRB(25, 25, 25, 500);
  static get searchResultPadding =>   const EdgeInsets.fromLTRB(0, 25, 25, 25);
  static get followPadding =>   const EdgeInsets.fromLTRB(25, 25, 25, 700);
  static get editContentPadding =>   const EdgeInsets.fromLTRB(20, 20, 20, 40);
  static get SendPadding =>  const   EdgeInsets.fromLTRB(40, 30, 40, 400);
  static get textContentPadding =>  const  EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 100.0);
  static get postPadding =>   const EdgeInsets.fromLTRB(25, 25, 25, 600);
  static get infoPadding =>   const EdgeInsets.fromLTRB(25, 25, 25, 400);
  static get classesMargin =>   const EdgeInsets.fromLTRB(0, 10, 0, 10);
  static get deactivatePadding =>   const EdgeInsets.fromLTRB(30, 100, 30, 300);
  static get editProfilePadding =>   const EdgeInsets.fromLTRB(20, 20, 20, 400);
  static get profileIconPadding =>   const EdgeInsets.fromLTRB(0, 24, 0, 0);
  static get profilePadding =>  const EdgeInsets.fromLTRB(5, 5, 10, 100);
  static get profilePicturePadding =>  EdgeInsets.fromLTRB(50, 50, 50, 400);


}