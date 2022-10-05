import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import '../post/storage_service.dart';

class ImageUploads extends StatefulWidget {
  ImageUploads({Key? key}) : super(key: key);

  @override
  _ImageUploadsState createState() => _ImageUploadsState();
}

class _ImageUploadsState extends State<ImageUploads> {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;


  File? _photo;
  String mediaUrl = '';
  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);

      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;


    final user = Provider.of<User?>(context);

    Future uploadFile(BuildContext context) async {
      if (_photo == null) return;
      final fileName = basename(_photo!.path);
      final destination = 'profilePics/$fileName';

      try {
        final ref = firebase_storage.FirebaseStorage.instance
            .ref(destination)
            .child('file/');

        await ref.putFile(_photo!);
        String imageUrl = await ref.getDownloadURL();
        print(imageUrl);

        void inputData() async{
          final myUser =  await auth.currentUser;
          final uid = myUser?.uid;

          var db = await FirebaseFirestore.instance;
          db.collection("users").doc(uid).set({
            "profilePicture" : imageUrl
          }, SetOptions(merge: true))
              .onError((e, _) => print("Error writing document: $e"));

        }

        inputData();

      } catch (e) {
        print('error occured');
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Profile Picture"),
        centerTitle: true,

      ),

      body: Column(
        children: <Widget>[
          SizedBox(
            height: 82,
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                _showPicker(context);
              },
              child: CircleAvatar(
                radius: 100,
                backgroundColor: Colors.grey[200],
                child: _photo != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(150),
                  child: Image.file(
                    _photo!,
                    width: 250,
                    height: 250,
                    fit: BoxFit.fill,
                  ),
                )
                    : Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(250)),
                  width: 250,
                  height: 250,
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 32,
          ),
          RaisedButton(
            color: Colors.blueAccent,
            child: Text("Change", style: TextStyle(color: Colors.white),),
            onPressed: (){
              uploadFile(context);
            },
          )

        ],
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Gallery'),
                      onTap: () {
                        imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}