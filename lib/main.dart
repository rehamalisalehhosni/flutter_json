import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(new MaterialApp(home: new Firstpage(), routes: <String, WidgetBuilder>{
    '/secondPage': (BuildContext context) => new SecondPage()
  }));
}

class Firstpage extends StatefulWidget {
  @override
  _FirstpageState createState() => _FirstpageState();
}

class _FirstpageState extends State<Firstpage> {
  List data;
  Future<String> getData() async {
    http.Response response = await http.get(
        Uri.encodeFull('https://jsonplaceholder.typicode.com/posts'),
        headers: {"Accept": 'Application/json'});
    this.setState(() {
      data = json.decode(response.body);
    });
    print(data);
  }

  @override
  void initState() {
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Home'),
      ),
      body: new ListView.builder(
        itemCount: data == null ? 10 : data.length,
        itemBuilder: (BuildContext context,int index){
          return new Card(
              child: new Text(data[index]['title']),
          );
        },
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Second'),
      ),
      body: new Center(
        child:
            new Column(children: <Widget>[Icon(Icons.face), Text('Second ')]),
      ),
    );
  }
}
