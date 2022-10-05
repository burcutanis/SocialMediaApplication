import 'package:cs310_term_project/model/feed.dart';
import 'package:cs310_term_project/model/post.dart';
import 'package:cs310_term_project/util/colors.dart';
import 'package:cs310_term_project/util/dimensions.dart';
import 'package:cs310_term_project/util/styles.dart';
import 'package:flutter/material.dart';

class FeedCard extends StatelessWidget {

  final Feed feed;
  final VoidCallback delete;
  final VoidCallback likes;
  final VoidCallback comments;
  final VoidCallback report;


  FeedCard({required this.feed, required this.delete, required this.likes, required this.comments,  required this.report, });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Card(
          margin: Dimen.classesMargin,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          color: AppColors.cardColor,
          child: Padding(
            padding: Dimen.regularPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [

                    Text(
                      feed.username,
                      style: feedtitleStyle,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(width:7),
                    Text(
                      "-",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(width:7),
                    Text(
                      feed.title,
                      style: feedtitleStyle,
                      textAlign: TextAlign.center,
                    ),
                    Spacer(),
                    Text(
                        feed.date,
                        style: feedtextStyle,
                    ),
                    SizedBox(width:10),
                  ],
                ),
                SizedBox(height:10),
                Row(
                  children: [
                    Image.asset(feed.image, width: 70, height: 70),
                    SizedBox(width:10),
                    Text(
                      feed.text,
                      style: feedLikeCommentStyle,
                    ),
                    Spacer(),

                  ],
                ),
                Row(
                  children: [
                    Text(
                      feed.likes.toString(),
                      style: feedLikeCommentStyle,
                    ),
                    IconButton(
                      iconSize: 14,
                      onPressed: likes,
                      icon: const Icon(Icons.thumb_up, size: 14, color: AppColors.IconColor,),
                    ),
                    Text(
                      feed.comments.toString(),
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    IconButton(
                      iconSize: 14,
                      onPressed: comments,
                      icon: const Icon(Icons.comment, size: 14, color: AppColors.IconColor,),
                    ),
                    Spacer(),
                    IconButton(
                      iconSize: 14,
                      onPressed: report,
                      icon: const Icon(Icons.report, size: 14, color: AppColors.IconColor,),
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
