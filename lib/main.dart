import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:post_get_test/myclass.dart';


void main() {
  runApp(MaterialApp(
    home: first(),
  ));
}

class first extends StatefulWidget {

  @override
  State<first> createState() => _firstState();
}

class _firstState extends State<first> {

  List<mydata> list =[];
  get()
  async {
    var url = Uri.parse('https://abhiflutter.000webhostapp.com/test.php');
    var response = await http.post(url);
    print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');

    dynamic result = jsonDecode(response.body);

    result.forEach((v){
      list.add(mydata.fromJson(v));
    });

  }


  @override
  void initState() {
    super.initState();
    get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
        return ListTile(
          title: Text("${list[index].data}"),

        );
      },),
    );
  }
}

