import 'package:cs310_term_project/model/post.dart';
import 'package:cs310_term_project/util/colors.dart';
import 'package:cs310_term_project/util/dimensions.dart';
import 'package:cs310_term_project/util/styles.dart';
import 'package:flutter/material.dart';

class EditPost extends StatefulWidget {
  const EditPost({Key? key}) : super(key: key);

  @override
  State<EditPost> createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  final _formKey = GlobalKey<FormState>();
  Post post = Post(title: 'Post1', text: 'Text for post1', date: '19/05/2022', image: 'assets/person.png', likes: 1, comments: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit the Post",
          style: TextStyle (
            backgroundColor: AppColors.appbarColor,
          ),
        ),

        backgroundColor: AppColors.buttonMainColor,
      ),
      body: SafeArea(
    child: Container(
      decoration: decoration,
        child: SingleChildScrollView(
          child: Padding (
            padding: Dimen.regularPadding,
            child: Form (
              key: _formKey,
              child: Column (
                children: [
                  Padding(
                    padding: Dimen.SendPadding,
                    child: Column(
                      children: [

                        TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(

                            label: Container(
                              width: 200,
                              child: Row(
                                children: [
                                  Icon(Icons.feed),
                                  const SizedBox(width: 4),
                                  const Text('Title'),
                                ],
                              ),
                            ),
                            fillColor: AppColors.fillColor,
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
                              else {
                                post.addTitle(value);
                                print("xxx,${post.title}");
                              }

                            }
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            contentPadding: Dimen.textContentPadding,
                            label: Container(
                              width: 100,
                              child: Row(
                                children: const [
                                  const Icon(Icons.feed),
                                  const SizedBox(width: 4),
                                  const Text('Text'),
                                ],
                              ),
                            ),
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
                              else {
                                post.addText(value);
                                print("xxx,${post.text}");
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
                                child: const Text("Change",
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
    );
  }
}
