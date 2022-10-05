import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_term_project/model/post.dart';
import 'package:cs310_term_project/post/storage_service.dart';
import 'package:cs310_term_project/util/auth.dart';
import 'package:cs310_term_project/util/colors.dart';
import 'package:cs310_term_project/util/dimensions.dart';
import 'package:cs310_term_project/util/styles.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';


class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
      value: AuthService().user,
      initialData: null,
      child: UploadPost(),
    );
  }
}

class UploadPost extends StatefulWidget {
  const UploadPost({Key? key}) : super(key: key);

  @override
  State<UploadPost> createState() => _UploadPostState();
}


class _UploadPostState extends State<UploadPost> {
  List<Post> posts = [];
  final _formKey = GlobalKey<FormState>();
  bool isUploading = false;
  String text = "";
  String title = "";
  String date  = DateTime.now().toString();
  int likes  = 0;
  int comments  = 0;
  final ImagePicker _picker = ImagePicker();
  dynamic _pickImage;

  XFile? _image;
  String mediaUrl = '';
  String postId = Uuid().v4();

  Future handleChooseFromGallery() async {
    //Navigator.pop(context);
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedFile;
    });
  }

  Future handleTakePhoto() async {
    //Navigator.pop(context);
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = pickedFile;
    });
  }

  selectImage(parentContext) {
    return showDialog(
      context: parentContext,
      builder: (context) {
        return SimpleDialog(
          title: Text("Create Post"),
          children: <Widget>[
            SimpleDialogOption(
                child: Text("Image from Gallery"),
                onPressed: handleChooseFromGallery),
            SimpleDialogOption(
                child: Text("Photo with Camera"),
                onPressed: handleTakePhoto),
            SimpleDialogOption(
              child: Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            )
          ],
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    print(date);
    List<String> xdate = date.split(" ");
    print(xdate[0]);
    final user = Provider.of<User?>(context);
    var size = MediaQuery.of(context).size;
    // print(user);

    Future uploadPostToFirebase(BuildContext context) async {
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      StorageService _storageService = StorageService();
      Reference firebaseStorageRef = FirebaseStorage.instance.ref();

      try {
        var ref = _firestore.collection("posts");
        if (_image == null) {
          mediaUrl = "";
        }
        else {
          mediaUrl = await _storageService.uploadMedia(File(_image!.path));
        }
        var documentRef = await ref.add({
          'image': mediaUrl,
          'text': text,
          'title': title,
          "postId": postId,
          "ownerId": user!.uid,
          "ownerEmail": user.email,
          "likes": likes,
          "comments": comments,
          'date': xdate[0],
        });

        print("Upload complete");
        setState(() {
          _image = null;
        });
      } on FirebaseException catch(e) {
        print('ERROR: ${e.code} - ${e.message}');
      } catch (e) {
        print(e.toString());
      }

    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Post Page"),
        backgroundColor: AppColors.appbarColor,
        centerTitle: true,

      ),

      body: SafeArea(
        child: Container(
          decoration: decoration,
          child: SingleChildScrollView(
            child: Padding(
              padding: Dimen.SendPadding,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                        child: Text(
                          "Upload Image",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.0,
                          ),
                        ),
                        onPressed: () => selectImage(context)),

                    Container(
                      height: 180,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: ClipRRect(
                        child: _image != null
                            ? Image.file(File(_image!.path)) : TextButton(
                          onPressed: () => selectImage(context),
                          child: const Icon(Icons.add_a_photo,
                            size:100,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    if(_image != null) OutlinedButton(
                      onPressed: (){
                        setState(() {
                          _image = null;
                        });
                      },
                      child: Text('Cancel'),
                    ),
                    const SizedBox(height: 20),

                    TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        label: Container(
                          width: 100,
                          child: Row(
                            children: const [
                              const Icon(Icons.feed),
                              const SizedBox(width: 4),
                              const Text('Title'),
                            ],
                          ),
                        ),
                        fillColor: AppColors.fillColor,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      validator: (value) {
                        if(value != null){
                          if(value.isEmpty) {
                            return 'Cannot leave empty';
                          }
                        }
                      },
                      onSaved: (value) {
                        title = value ?? '';
                        print(title);
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text("Text:",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        )),
                    SizedBox(height: 5),
                    TextFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 150.0),
                        fillColor: AppColors.fillColor,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      validator: (value) {
                        if(value != null){
                          if(value.isEmpty) {
                            return 'Cannot leave text field empty';
                          }
                        }
                      },
                      onSaved: (value) {
                        text = value ?? '';
                        print(text);
                      },
                    ),
                    const SizedBox(height: 20),

                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          child: ElevatedButton(
                            style: TextButton.styleFrom(
                              shape:
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              primary: AppColors.white,
                              backgroundColor: AppColors.buttonMainColor,
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                await uploadPostToFirebase(context);
                                await FirebaseAnalytics.instance.logEvent(name: "User posted");
                              }
                            },
                            child: const Text("Post",
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
            ),
          ),
        ),
      ),
    );
  }
}

