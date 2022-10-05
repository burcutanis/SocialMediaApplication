import 'package:cs310_term_project/model/post.dart';
import 'package:cs310_term_project/util/colors.dart';
import 'package:cs310_term_project/util/dimensions.dart';
import 'package:cs310_term_project/util/styles.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {

  final Post post;
  final VoidCallback delete;
  final VoidCallback addTitle;



  PostCard({required this.post, required this.delete , required this.addTitle, });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Card(
          color: AppColors.cardColor,
          margin: Dimen.classesMargin,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: Dimen.regularPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Text(
                      post.title,
                      style: TitleStyle,
                      textAlign: TextAlign.center,
                    ),
                    Spacer(),
                    Text(
                        post.date,
                        style: dateStyle,
                    ),
                    SizedBox(width:10),
                  ],
                ),
                SizedBox(height:10),
                Row(
                  children: [
                    Image.asset(post.image, width: 70, height: 70),
                    SizedBox(width:10),
                    Text(
                      post.text,
                      style: textStyle,
                    ),
                    Spacer(),
                    IconButton(
                      iconSize: 14,
                      onPressed: delete,
                      icon: const Icon(Icons.delete, size: 14, color: AppColors.IconColor,),
                    ),
                    IconButton(
                      iconSize: 14,
                      onPressed: addTitle,
                      icon: const Icon(Icons.edit, size: 14, color: AppColors.IconColor,),
                    ),

                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
