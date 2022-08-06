import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:onlinedatabase/dashboard.dart';
import 'package:onlinedatabase/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  TextEditingController t = TextEditingController();
  TextEditingController t1 = TextEditingController();
  SharedPreferences? prefs;
  String? name;

  storedata() async {
    prefs = await SharedPreferences.getInstance();
    name = prefs?.getString("name");
    if (name != null) {
      print("not null= $name");
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return dashboard();
        },
      ));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    storedata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextField(
            controller: t,
          ),
          TextField(
            controller: t1,
          ),
          TextButton(
              onPressed: () async {
                String user = t.text;
                String pass = t1.text;
              //  Map m = {'user': '$user', 'password': '$pass'};

                var url = Uri.parse('https://database34.000webhostapp.com/logincheck.php');
                var response = await http.post(url, body: {'user': '$user', 'password': '$pass'});
                print('Response status: ${response.statusCode}');
                print('Response body: ${response.body}');
                List l = jsonDecode(response.body);
                print(l);

                if (l.length == 0) {
                  print("Username or Password does not exist");
                } else {
                  Map m = l[0];
                  await prefs!.setString('id', m['id']);
                  await prefs!.setString('name', m['name']);
                  await prefs!.setString('gender', m['gender']);
                  await prefs!.setString('city', m['city']);
                  await prefs!.setString('password', m['password']);
                }

                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return dashboard();
                  },
                ));
              },
              child: Text("Login")),
          TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return form();
                  },
                ));
              },
              child: Text("Register now"))
        ],
      ),
    );
  }
}