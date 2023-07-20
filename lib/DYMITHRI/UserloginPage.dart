import 'dart:convert';

import 'package:dymithranew/SharedPreference%20Use/sharedPrefUse.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../connection/connect.dart';
import 'UserSignUp.dart';
import 'disabled.dart';

class UserLoginPage extends StatefulWidget {
  const UserLoginPage({Key? key}) : super(key: key);

  @override
  State<UserLoginPage> createState() => _UserLoginPageState();
}

class _UserLoginPageState extends State<UserLoginPage> {
  var _UDIDcontroller = TextEditingController();
  var _passcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  var loginid;
  Future<void> login() async {
    var data = {
      'UDID': _UDIDcontroller.text,
      'password': _passcontroller.text,
      'type': 'user',
    };

    var responses = await post(
      Uri.parse('${Con.url}user_login.php'),
      body: data,
    );

    var jsonResponse = jsonDecode(responses.body);

    if (jsonResponse['result'] == 'Success') {
      loginid=jsonDecode(responses.body)['login_id'];
      print(loginid);
      saveData(loginid);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Logged in Successfully')),);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DisabledPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed')),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const UserLoginPage()),
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(200, 61, 193, 235),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            height: 450,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(120)),
            ),
            child: Form(
              key: _formkey,
              child: Column(
                children: [

                     Container(
                      height: 120,
                      width: 150,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage('assets/Images/Rectangle 44.png'),
                        ),
                      ),
                    ),
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: TextField(
                        controller: _UDIDcontroller,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          label: Text(
                            'Enter UDID ',
                            style: TextStyle(fontSize: 20),
                          ),
                          focusColor: Colors.cyan,
                        ),
                    ),
                     ),

                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: TextField(
                        controller: _passcontroller,
                        obscureText: true,
                        obscuringCharacter: '*',
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          label: Text(
                            'Password',
                            style: TextStyle(fontSize: 20),
                          ),
                          focusColor: Colors.cyan,
                        ),
                      ),
                   ),

                  SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      if (_UDIDcontroller.text.isNotEmpty &&
                          _passcontroller.text.isNotEmpty) {
                        print('ready to login data not empty');
                        login();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('All fields Required')),
                        );
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(200, 61, 193, 235),
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      ),
                      height: 50,
                      width: 200,
                      child: Center(
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(fontSize: 15),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserSignUp(),
                            ),
                          );
                        },
                        child: Text(
                          'SignUp',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

