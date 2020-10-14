import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
         primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String url="https://jsonplaceholder.typicode.com/albums/1";
  List data;
  @override
  void initState(){
    super.initState();
    this.getJsonData();
  }
  Future<String> getJsonData() async{
    var response = await http.get(
      Uri.encodeFull(url),
      headers: {"Accept": "Application/json"}
    );
    print(response.body);
    setState(() {
      var convertDataToJson = json.decode(response.body);
     data = convertDataToJson('data');
    });
    return "success";
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Retrieve json via HTTP GET"),
      ),
      body: new ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index){
          return new Container(
           child: new Center(
             child: new Column(
               crossAxisAlignment: CrossAxisAlignment.stretch,
               children: <Widget>[
                 new Card(child: new Container(child: new Text(data[index]['name']),
                 padding: const EdgeInsets.all(20.0),
                 ),
                 )
               ],
      ),
      ),
      );
  },
      ),
    );
}
}
