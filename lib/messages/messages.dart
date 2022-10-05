import 'package:cs310_term_project/messages/messages_card.dart';
import 'package:cs310_term_project/messages/messages_db.dart';
import 'package:cs310_term_project/model/messages.dart';
import 'package:cs310_term_project/util/colors.dart';
import 'package:cs310_term_project/util/dimensions.dart';
import 'package:cs310_term_project/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class MyMessages extends StatefulWidget {
  const MyMessages({Key? key}) : super(key: key);


  @override
  State<MyMessages> createState() => _MyMessagesState();
}

class _MyMessagesState extends State<MyMessages> {

  String username = "";
  String uid = "";
  dynamic _user = [];

  List<Messages> messages = [
    Messages(text: "THE PAGE TO SEE MESSAGES", date: "", title: "PLEASE", receiver: "", sender: "REFRESH")
  ];


  MessageDB db = MessageDB();
  Future callMessages() async {
    //FirebaseAuth.instance.signInWithEmailAndPassword(email: "deneme@gmail.com", password: "deneme");
    messages.clear();
    List<dynamic> allmessages = [];
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    if(user != null){
      uid = user.uid;
    }
    await FirebaseFirestore.instance.collection("users").doc(uid).get().then((value) => {_user.add(value.data())});
    await db.messageCollection.get().then((snapshot) => snapshot.docs.forEach((element) {allmessages.add(element.data());}));
    username = _user[0]["username"];

    setState(() {

      allmessages.forEach((element) => {
        if(element["receiver"] == username || element["sender"] == username){
          messages.add(Messages(
              date: (element["date"]),
              text: element["text"],
              receiver: element["receiver"],
              sender: element["sender"],
              title: element["title"]))}
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Messages"),
          backgroundColor: AppColors.appbarColor,
          actions: [   IconButton(
            iconSize: 14,
            onPressed: () {
              Navigator.pushNamed(context, "/sendMessages");
            },
            icon: const Icon(Icons.add_circle, size: 35, color: Colors.white,),
          ),
            IconButton(onPressed: () => {callMessages()}, icon: Icon(Icons.refresh_outlined)),

          ],


        ),
        body: FutureBuilder(
            future: db.messageCollection.get(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.done && snapshot.hasData && snapshot.data != null){
                List<dynamic> allmessages = [];

                return SingleChildScrollView(
                  child: SafeArea(
                    child: Container(

                      child: Padding(
                        padding: Dimen.messageNotificationPadding,
                        child: Column(
                          children: [
                            Column(
                              children: messages.map((message) => MessagesCard(
                                message: message,
                              )).toList(),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                )
                ;
              }
              else{
                return Center(
                  child: Container(
                    padding: const EdgeInsets.only(top: 300.0),
                    child: Column(
                        children: const [
                          CircularProgressIndicator(),
                          Text("Waiting for loading...", style: TextStyle(fontSize: 24.0),)
                        ]
                    ),
                  ),
                );
              }
            }
        )



    );
  }
}