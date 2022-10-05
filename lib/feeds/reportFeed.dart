import 'package:cs310_term_project/model/feed.dart';
import 'package:cs310_term_project/feeds/feed_class.dart';
import 'package:cs310_term_project/util/colors.dart';
import 'package:cs310_term_project/util/dimensions.dart';
import 'package:cs310_term_project/util/styles.dart';
import 'package:flutter/material.dart';

class ReportFeed extends StatefulWidget {
  const ReportFeed({Key? key}) : super(key: key);

  @override
  State<ReportFeed> createState() => _ReportFeedState();
}

class _ReportFeedState extends State<ReportFeed> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Report Feed",
          style: TextStyle (
            backgroundColor: AppColors.appbarColor,
          ),
        ),
        backgroundColor: AppColors.buttonMainColor,
      ),
      body: SafeArea(
        child: Container(
          decoration: decoration,
          child: SafeArea (
            child: SingleChildScrollView(
              child: Padding (
                padding: Dimen.regularParentPadding,
                child: Form (
                  key: _formKey,
                  child: Column (
                    children: [
                      Padding(
                        padding: Dimen.reportFeed,
                        child: Column(
                          children: [
                            Text("Reason of reporting this post",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold
                            ),),
                            SizedBox(height: 10,),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 100.0),
                                fillColor: AppColors.cardColor,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: AppColors.buttonMainColor,
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              validator: (value) {
                                if(value != null){
                                  if(value.isEmpty) {
                                    return 'Cannot leave it empty';
                                  }


                                }
                              },
                            ),
                            const SizedBox(height: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SizedBox(
                                  width: 60.0,
                                  height: 60.0,
                                  child: ElevatedButton(
                                    style: TextButton.styleFrom(
                                      shape:
                                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                      primary: AppColors.white,
                                      backgroundColor: AppColors.buttonMainColor,
                                    ),
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState!.save();
                                        Navigator.pushNamed(context, "/bottomNavigationBar");
                                      }
                                    },
                                    child: const Text("Report the post",
                                      style: TextStyle (
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
