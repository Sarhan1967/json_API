import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Json_App',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Users'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Future<List<User>> _getUsers() async {
    var data = await http.get("http://myjson.dit.upm.es/api/bins/57yp");
    var jsonData = json.decode(data.body);

    List<User> users= [];
    for(var u in jsonData) {
      User user = User(u["index"], u["age"], u["name"], u["gender"], u["company"], u["email"], u["phone"], u["address"]);
      users.add(user);
    }

    print("the Number is " + users.length.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: FutureBuilder(
          future: _getUsers(),
          builder: (BuildContext context, AsyncSnapshot asyncSnapshot){

          },
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

//Model Class
class User{
  final String index;
  final int age;
  final String name;
  final String gender;
  final String company;
  final String email;
  final int phone;
  final String address;

  User(this.index, this.age, this.name,
      this.gender, this.company, this.email, this.phone, this.address);


}
