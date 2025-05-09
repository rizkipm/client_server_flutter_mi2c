import 'dart:convert';

import 'package:client_server_flutter_mi2c/model/model_users.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListUserView extends StatefulWidget {
  const ListUserView({super.key});

  @override
  State<ListUserView> createState() => _ListUserViewState();
}

class _ListUserViewState extends State<ListUserView> {

  bool isLoading = false;
  List<ModelUsers> listUsers = [];

  //do in background untuk fetching data
  Future getUser() async{

    try{
      setState(() {
        isLoading = true;
      });

      //proses untuk akses url
      http.Response res = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
      var data = res.body;

      setState(() {
        var decodedData = json.decode(data);
        for (var i in decodedData){
          listUsers.add(ModelUsers.fromJson(i));
        }
      });

    }catch(e){
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()))
        );
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: listUsers.length,
        itemBuilder: (context, index){
          return Padding(
            padding: EdgeInsets.only(top: 8, left: 8, right: 8),
            child: Card(
              child: ListTile(
                title: Text(listUsers[index].name ?? "", 
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                  ),
                ),
                subtitle: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(listUsers[index].email ?? ""),
                    Text(listUsers[index].username ?? ""),
                    Text(listUsers[index].address.city ?? ""),

                    //memanggil string di dalam string
                    Text("Email : " + listUsers[index].email),
                    Text("Username : ${listUsers[index].username}"),

                    //TASK :
                    //1. Memanggil semua parameter
                    //2. Detail Page dan menampilkan detail dari user sesuai dengan yang di klik (ini sama dengan detail page sebelumnya)

                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
