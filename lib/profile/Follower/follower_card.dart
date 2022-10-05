import 'package:cs310_term_project/model/follower.dart';
import 'package:cs310_term_project/util/colors.dart';
import 'package:cs310_term_project/util/dimensions.dart';
import 'package:cs310_term_project/util/styles.dart';
import 'package:flutter/material.dart';

class FollowerCard extends StatelessWidget {
  final Follower follower;
  final VoidCallback delete;

  FollowerCard({required this.follower, required this.delete,  });

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
                //Image.asset(follower.image, width: 70, height: 70),
                //SizedBox(width: 10,),
                Text(
                  follower.name,
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