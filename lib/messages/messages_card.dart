import 'package:cs310_term_project/model/messages.dart';
import 'package:cs310_term_project/util/colors.dart';
import 'package:cs310_term_project/util/dimensions.dart';
import 'package:cs310_term_project/util/styles.dart';
import 'package:flutter/material.dart';

class MessagesCard extends StatelessWidget {

  final Messages message;

  MessagesCard({required this.message });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          color: AppColors.decoration1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          margin: Dimen.classesMargin,
          child: Padding(
            padding: Dimen.regularPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Text(
                      message.title,
                      style: TitleStyle,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(width: 5,),
                    Text(
                      "-",
                      style: TitleStyle,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(width: 5,),
                    Text(
                      message.sender,
                      style: TitleStyle,
                      textAlign: TextAlign.center,
                    ),
                    Spacer(),
                    Text(
                      message.date,
                      style: dateStyle,
                    ),
                    SizedBox(width:10),
                  ],
                ),
                SizedBox(height:10),
                Row(
                  children: [
                    Text(
                      message.text,
                      style: textStyle,
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