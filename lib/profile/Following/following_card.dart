import 'package:cs310_term_project/model/following.dart';
import 'package:cs310_term_project/util/colors.dart';
import 'package:cs310_term_project/util/dimensions.dart';
import 'package:cs310_term_project/util/styles.dart';
import 'package:flutter/material.dart';

class FollowingCard extends StatelessWidget {
  final Following following;
  final VoidCallback delete;
  FollowingCard({required this.following, required this.delete });

  @override
  Widget build(BuildContext context) {
    return   Card(
      color: AppColors.cardColor,
      margin: Dimen.classesMargin,
      child: Padding(
        padding: Dimen.regularPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                //Image.asset(following.image, width: 70, height: 70),
                //SizedBox(width: 10,),
                Text(
                  following.name,
                  style: TitleStyle,
                  textAlign: TextAlign.center,
                ),
                Spacer(),
                IconButton(
                  iconSize: 14,
                  onPressed: delete,
                  icon: const Icon(Icons.delete, size: 14, color: AppColors.IconColor,),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}