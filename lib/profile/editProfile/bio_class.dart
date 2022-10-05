import 'package:cs310_term_project/model/accountInfo.dart';
import 'package:cs310_term_project/profile/profile.dart';
import 'package:cs310_term_project/util/colors.dart';
import 'package:cs310_term_project/util/dimensions.dart';
import 'package:flutter/material.dart';

class AccountCard extends StatelessWidget {
  final Account_Info accountInfo;

  AccountCard({required this.accountInfo});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:400,
      height:100,
      child: Card(
        color: AppColors.cardColor,
        margin: Dimen.classesMargin,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    accountInfo.text,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

