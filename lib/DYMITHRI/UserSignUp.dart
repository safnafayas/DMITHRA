import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../connection/connect.dart';
import 'UserloginPage.dart';

class UserSignUp extends StatefulWidget {
  const UserSignUp({Key? key}) : super(key: key);

  @override
  _UserSignUpState createState() => _UserSignUpState();
}

class _UserSignUpState extends State<UserSignUp> {
  var _phonenumbercontroller = TextEditingController();
  var _UDIDcontroller = TextEditingController();
  var _passcontroller = TextEditingController();
  var _namecontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  Future<void> usersignUp() async {
    var data = {
      'UDID': _UDIDcontroller.text,
      'password': _passcontroller.text,
      'name': _namecontroller.text,
      'contact_number': _phonenumbercontroller.text,
      'type': 'user',
    };

    var url = Uri.parse('${Con.url}user_Register.php');
    var response = await http.post(url, body: data);

    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);

      if (responseData['result'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registered Successfully')),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to register')),
        );
        Navigator.pop(context);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to connect to the server')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: 132,
                ),
                Form(
                  key: _formkey,
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    height: 650,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(120),
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 120,
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                              image: DecorationImage(
                                fit: BoxFit.contain,
                                image: AssetImage('assets/Images/Rectangle 44.png'),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: TextFormField(
                            controller: _UDIDcontroller,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: 'Enter UDID',
                              labelStyle: TextStyle(fontSize: 20),
                              focusColor: Colors.cyan,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your UDID';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: TextFormField(
                            controller: _namecontroller,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: 'Your name',
                              labelStyle: TextStyle(fontSize: 20),
                              focusColor: Colors.cyan,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: TextFormField(
                            controller: _passcontroller,
                            obscureText: true,
                            obscuringCharacter: '*',
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(fontSize: 20),
                              focusColor: Colors.cyan,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: _phonenumbercontroller,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Contact Number',
                              labelStyle: TextStyle(fontSize: 20),
                              focusColor: Colors.cyan,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your contact number';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            if (_formkey.currentState!.validate()) {
                              usersignUp();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please fill all the required fields'),
                                ),
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
                                'Sign Up',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 25,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "You already have an account?",
                              style: TextStyle(fontSize: 18),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => UserLoginPage()),
                                );
                              },
                              child: Text(
                                'Log In',
                                style: TextStyle(
                                  fontSize: 20,
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
          ],
        ),
      ),
    );
  }
}
