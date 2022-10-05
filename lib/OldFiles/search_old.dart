
import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:search_page/search_page.dart';

class Person {
  final String name, surname;
  final num age;

  Person(this.name, this.surname, this.age);
}


Future<List<Person>?> getRequest() async {
  //replace your restFull API here.
  String url = "https://jsonplaceholder.typicode.com/users";
  final response = await http.get(Uri.parse(url));

  var responseData = json.decode(response.body);

  //Creating a list to store input data;
  List<Person> people = [];
  for (dynamic singleUser in responseData) {
    Person person = Person(singleUser["name"],singleUser["username"],singleUser["id"]);
    //Adding user to the list.
    people.add(person);
  }
  return people;
}

class SearchScreen extends StatelessWidget {

  List<Person>? snapshotData = [Person("", "", 0)];

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
                      trailing: Text('${person.age} yo'),
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
            items: snapshotData ?? [Person("", "", 0)],
            searchLabel: 'Search people',
            suggestion: Center(
              child: Text('Filter people by name, surname or age'),
            ),
            failure: Center(
              child: Text('No person found :('),
            ),
            filter: (person) => [
              person.name,
              person.surname,
              person.age.toString(),
            ],
            builder: (person) => ListTile(
              title: Text(person.name),
              subtitle: Text(person.surname),
              trailing: Text('${person.age} yo'),
            ),
          ),
        ),
        child: Icon(Icons.search),
      ),
    );
  }
}