import 'package:flutter/material.dart';
import 'package:onlinedatabase/loginpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class dashboard extends StatefulWidget {
  const dashboard({Key? key}) : super(key: key);

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  String id = "0", name = "", gender = "", city = "", password = "";
  SharedPreferences? prefs;

  getdata() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      id = prefs!.getString('id')!;
      name = prefs!.getString('name')!;
      gender = prefs!.getString('gender')!;
      city = prefs!.getString('city')!;
      password = prefs!.getString('password')!;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text("$id"),
          Text("$name"),
          Text("$gender"),
          Text("$city"),
          Text("$password"),
          IconButton(onPressed: () async {
            await prefs!.clear();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
              return login();
            },));
          }, icon: Icon(Icons.logout))
        ],
      ),

    );
  }
}