
import 'dart:core';

import 'package:flutter/material.dart';

import 'package:search_page/search_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Person {
  final String name, surname;
  final String id;

  Person(this.name, this.surname, this.id);
}
void _showPostDetail(BuildContext context, Map<String, dynamic> map) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: new Text("Post Detail"),
        content: Text('Title: ${map["title"]}\nText: ${map["text"]}\nPost Date: ${map["date"]}\nOwner Email: ${map["ownerEmail"]}'),
        actions: <Widget>[
          new FlatButton(
            child: new Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void _showUserDetail(BuildContext context, Map<String, dynamic> map) {
  if(map["profilePicture"] == ""){
    showDialog(
      context: context,
      builder: (BuildContext context) {

        return AlertDialog(

          title: new Text("User Detail"),
          content:

          Column(
            children: [
              CircleAvatar( radius: 50.0, backgroundImage: NetworkImage("https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png"), backgroundColor: Colors.transparent, ),
              SizedBox(
                width: 150,
                height: 50,
              ),
              Text('Username: ${map["username"]}\nBio: ${map["bio"]}\nEmail: ${map["email"]}\nFollowers: ${map["followers"]}\nFollowing: ${map["following"]}'),

            ],
          ),

          actions: <Widget>[
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  else{
    showDialog(
      context: context,
      builder: (BuildContext context) {

        return AlertDialog(

          title: new Text("User Detail"),
          content:

          Column(
            children: [
              CircleAvatar( radius: 50.0, backgroundImage: NetworkImage(map["profilePicture"]), backgroundColor: Colors.transparent, ),
              SizedBox(
                width: 150,
                height: 50,
              ),
              Text('Username: ${map["username"]}\nBio: ${map["bio"]}\nEmail: ${map["email"]}\nFollowers: ${map["followers"]}\nFollowing: ${map["following"]}'),

            ],
          ),

          actions: <Widget>[
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}

void takeData(BuildContext context,String id) async{
  final FirebaseFirestore db;
  db = FirebaseFirestore.instance;
  num counter = 0;

  await db.collection("posts").get().then((event) {
    for (var doc in event.docs) {
      if(doc.data()["postId"] == id){
        counter++;
        _showPostDetail(context, doc.data());
      }
    }
    if(counter == 0){
      db.collection("users").get().then((event) {
        for (var doc2 in event.docs) {
          if(doc2.data()["uid"] == id ){
            _showUserDetail(context, doc2.data());
          }
        }
      });
    }

  });

}


Future<List<Person>?> getRequest() async {
  final FirebaseFirestore db;
  db = FirebaseFirestore.instance;
  List<Person> people = [];

  await db.collection("users").get().then((event) {
    for (var doc in event.docs) {
      Person person = Person(doc.data()["email"],doc.data()["username"],doc.data()["uid"]);
      people.add(person);
    }
  });

  await db.collection("posts").get().then((event) {
    for (var doc in event.docs) {
      Person person = Person(doc.data()["text"],doc.data()["title"],doc.data()["postId"]);
      people.add(person);
    }
  });

  return people;
}

class SearchScreen extends StatelessWidget {

  List<Person>? snapshotData = [Person("", "", "")];

  late Future<List<Person>?> futureData = getRequest();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Search Page'),
      ),
      body: Center(
        child: FutureBuilder <List<Person>?>(
          future: futureData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Person>? people = snapshot.data;
              snapshotData = snapshot.data;
              return
                ListView.builder(
                  itemCount: people?.length,
                  itemBuilder: (context, index) {
                    final Person person = people![index];
                    return ListTile(
                      title: Text(person.name),
                      subtitle: Text(person.surname),
                      onTap: () {
                        takeData(context,person.id);
                      },
                    );
                  },
                );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            // By default show a loading spinner.
            return CircularProgressIndicator();
          },

        ),

      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Search people',
        onPressed: () => showSearch(
          context: context,
          delegate: SearchPage<Person>(
            onQueryUpdate: (s) => print(s),
            items: snapshotData ?? [Person("", "", "")],
            searchLabel: 'Search people and posts',
            suggestion: Center(
              child: Text('Filter by name or content '),
            ),
            failure: Center(
              child: Text('No person found :('),
            ),
            filter: (person) => [
              person.name,
              person.surname,
              person.id,
            ],
            builder: (person) => ListTile(
              title: Text(person.name),
              subtitle: Text(person.surname),
            ),
          ),
        ),
        child: Icon(Icons.search),
      ),
    );
  }
}
