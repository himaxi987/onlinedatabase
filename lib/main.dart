import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'loginpage.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: login(),
  ));
}

class form extends StatefulWidget {
  const form({Key? key}) : super(key: key);

  @override
  State<form> createState() => _formState();
}

class _formState extends State<form> {
  TextEditingController t = TextEditingController();
  TextEditingController t1 = TextEditingController();
  String gender = "", name = "", city = "", password = "";

  bool a = false;
  bool b = false;
  bool c = false;
  bool d = false;
  bool e = false;
  List<String> cityy = [
    'Ahmedabad',
    'Surat',
    'Mumbai',
    'Delhi',
    'Vapi',
    'Agra',
    'Bharuch',
    'Jamnagar',
    'Rajkot',
    'Panchgini'
  ];

  putdata(
    String name,
    String gender,
    String city,
    String password,
  ) async {
    var url = Uri.parse('https://database34.000webhostapp.com/login.php');
    Map m = {
      'name': name,
      'gender': gender,
      'city': city,
      'password': password,
    };
    var response = await http.post(url, body: m);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }

  String v = "Ahmedabad";
  String submit = "", submit1 = "";
  bool name1 = false;
  bool g = false;

  List<DropdownMenuItem<String>> getdata() {
    List<DropdownMenuItem<String>> list = [];
    for (int i = 0; i < cityy.length; i++) {
      list.add(DropdownMenuItem(
        child: Text(cityy[i]),
        value: cityy[i],
      ));
    }
    return list;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //putdata(name, gender, hobby, city, password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form'),
      ),
      body: ListView(
        children: [
          // Container(
          //   alignment: Alignment.topLeft,
          // child: Text(
          //   'Name : ',
          //   style: TextStyle(fontSize: 18),
          // ),
          // ),
          Container(
            margin: EdgeInsets.all(10),
            child: TextField(
              onChanged: (value) {
                name = value;
              },
              controller: t,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                // labelText: 'Name',
              ),
            ),
          ),
          Container(
            //margin: EdgeInsets.all(10),
            alignment: Alignment.topLeft,
            child: Text(
              "Gender :",
              style: TextStyle(fontSize: 18),
            ),
          ),
          ListTile(
            title: Text("Female"),
            leading: Radio(
                onChanged: (value) {
                  setState(() {
                    gender = value.toString();
                  });
                },
                value: "female",
                groupValue: gender),
          ),
          ListTile(
            title: Text("Male"),
            leading: Radio(
                onChanged: (value) {
                  setState(() {
                    gender = value.toString();
                  });
                },
                value: "male",
                groupValue: gender),
          ),

          Container(
            alignment: Alignment.topLeft,
            child: Text(
              "City : ",
              style: TextStyle(fontSize: 18),
            ),
          ),
          DropdownButton(
            onChanged: (value) {
              setState(() {
                city = value as String;
              });
            },
            icon: Icon(Icons.arrow_drop_down_circle_outlined),
            value: v,
            items: getdata(),
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              'Password : ',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: TextField(
              onChanged: (value) {
                password = value;
              },
              controller: t1,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  // name1 = !name1;
                  putdata(name, gender, city, password);
                });
              },
              child: Text('Submit')),
          // name1
          //     ? Container(
          //         margin: EdgeInsets.all(20),
          //         child: Text(
          //             "Name: $submit,\nGender: $gender,\nHobby: $check,$check1,$check2,$check3,$check4,\nCity: $v,\nPassword: $submit1",
          //             style: TextStyle(fontSize: 25)),
          //       )
          //     : Spacer()
        ],
      ),
    );
  }
}
