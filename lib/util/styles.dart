import 'package:cs310_term_project/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



final suDormTitle = const TextStyle(
  color: AppColors.textMainColor,
  fontSize: 20,
  fontWeight: FontWeight.bold,
);



final MainTitleStyle = GoogleFonts.montserrat(
  fontWeight: FontWeight.w900,
  color: Colors.blueAccent,
  fontSize: 40,
);

final decoration = BoxDecoration(
  gradient: LinearGradient (
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      AppColors.decoration1,
      AppColors.decoration2,
    ],
  ),
);

final feedtitleStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w500,
);

final feedLikeCommentStyle = TextStyle(
  fontSize: 18,

);

final feedtextStyle = TextStyle(
  fontSize: 17,
  fontWeight: FontWeight.w400,
);

final TitleStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w500,
);

final dateStyle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w400,
);

final textStyle = TextStyle(
  fontSize: 18,
);



