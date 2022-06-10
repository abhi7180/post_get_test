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
  mydata? m;
  bool isLoading = true;

  get()
  async {
    var url = Uri.parse('https://abhiflutter.000webhostapp.com/test.php');
    var response = await http.post(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    Map<String,dynamic> result = jsonDecode(response.body);

    if (response.statusCode == 200) {
      m = await mydata.fromJson(result);
      if (m != null) {
        setState(() {
          isLoading = false;
        });
      } else {
        print("null1");
      }
    } else {
      print("null2");
    }

    setState(() {
      m = mydata.fromJson(result);
    });



    // result.forEach((k,v){
    //   list.add(mydata.fromJson(v));
    // });


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
      body: isLoading ?  Center(
        child: CircularProgressIndicator(),
       ) :  ListView.separated(itemBuilder: (context, index) {

        return Column(
                  children: [
                    ListTile(
                      leading: Text("${m!.data![index].id}"),
                      title: Text("${m!.data![index].address}"),
                      subtitle: Text("${m!.data![index].addressType}"),


                    ),
                    ListTile(
                      leading: Text("${m!.data![index].lat}"),
                      title: Text("${m!.data![index].lang}"),
                      subtitle: Text("${m!.data![index].landmark}"),

                    ),
                    ListTile(
                      leading: Text("${m!.data![index].building}"),
                      title: Text("${m!.data![index].pincode}"),
                      subtitle: Text("${m!.data![index].deliveryCharge}"),
                    ),


                  ],
                );
       }, separatorBuilder: (context,index){
         return Container(height: 2,color: Colors.black,);
      }, itemCount: m!.data!.length)

    );
  }
}

