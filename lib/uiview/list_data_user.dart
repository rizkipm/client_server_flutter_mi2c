import 'package:client_server_flutter_mi2c/model/model_list_user_data.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class ListDataUserView extends StatefulWidget {
  const ListDataUserView({super.key});

  @override
  State<ListDataUserView> createState() => _ListDataUserViewState();
}

class _ListDataUserViewState extends State<ListDataUserView> {

  late Future<List<DataUser>?> futureUser;



  Future<List<DataUser>?> getDataUser() async {
    print('getDataUser called...');
    try {
      final response = await http.get(
        Uri.parse('https://reqres.in/api/users?page=2'),
        headers: {
          'x-api-key': 'reqres-free-v1',
        },
      );
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        return modelListDataUserFromJson(response.body).data;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }

      // return modelListDataUserFromJson(response.body).data;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      return null;
    }
  }


  //fecth method data user
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureUser = getDataUser();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('List Data User')),

      body: FutureBuilder<List<DataUser>?>(
        future: futureUser,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.purple));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No user data found.'));
          }else{

            List<DataUser> dataUser = snapshot.data!;
            // final users = snapshot.data!;
            return ListView.builder(
              itemCount: dataUser.length,
              itemBuilder: (context, index) {
                final data = dataUser[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(

                              data.avatar ?? '',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            '${data.firstName} ${data.lastName}',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          subtitle: Text(data.email ?? '-'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

        },
      ),
    );
  }
}
