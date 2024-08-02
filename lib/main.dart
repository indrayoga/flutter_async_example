import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(App());
}

class App extends StatelessWidget {

  List<Map<String,dynamic>> allUser = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Belajar Asynchronous"),
        ),
        body: FutureBuilder(
            future: getAllUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Text("Loading"),
                );
              } else {
                return ListView.builder(
                  itemBuilder: (context, index) => ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(allUser[index]['avatar']),
                    ),
                    title: Text("${allUser[index]['first_name']}"),
                    subtitle: Text("${allUser[index]['email']}"),
                  ),
                  itemCount: allUser.length,
                );
              }
            }),
      ),
    );
  }

  Future getAllUser() async {
    var response = await http.get(Uri.parse("https://reqres.in/api/users"));
    List data = (json.decode(response.body) as Map<String,dynamic>)["data"];
    data.forEach((element){
      allUser.add(element);
    });
  }
}
