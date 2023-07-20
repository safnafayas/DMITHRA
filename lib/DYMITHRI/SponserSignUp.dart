import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../connection/connect.dart';
import 'UserloginPage.dart';

class SignUpSponsor extends StatefulWidget {
  const SignUpSponsor({Key? key}) : super(key: key);

  @override
  State<SignUpSponsor> createState() => _SignUpSponsorState();
}

class _SignUpSponsorState extends State<SignUpSponsor> {
  var _phonenumbercontroller = TextEditingController();
  var _username = TextEditingController();
  var _emailcontroller = TextEditingController();
  var _passcontroller = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  Future<void> sponsorregister() async {
    var data = {
      'username': _username.text,
      'password': _passcontroller.text,
      'email': _emailcontroller.text,
      'contact_number': _phonenumbercontroller.text,
      'type': 'sponsor',
    };
    var response = await post(Uri.parse('${Con.url}sponser_reg.php'), body: data);

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
        child: Container(
          height: MediaQuery.of(context).size.height, // Set a fixed height
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Form(
                key: _formkey,
                child: Container(
                  height: 680,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(120)),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 120,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            image: DecorationImage(
                              fit: BoxFit.contain,
                              image: AssetImage('assets/Images/Rectangle 44.png'),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: TextFormField(
                          controller: _emailcontroller,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(fontSize: 20),
                            focusColor: Colors.cyan,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: TextFormField(
                          controller: _username,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            labelStyle: TextStyle(fontSize: 20),
                            focusColor: Colors.cyan,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
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
                        padding: const EdgeInsets.all(12),
                        child: TextFormField(
                          controller: _phonenumbercontroller,
                          keyboardType: TextInputType.text,
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
                      InkWell(
                        onTap: () {
                          if (_username.text.isNotEmpty &&
                              _phonenumbercontroller.text.isNotEmpty &&
                              _emailcontroller.text.isNotEmpty &&
                              _passcontroller.text.isNotEmpty) {
                            if (_formkey.currentState!.validate()) {
                              sponsorregister();
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('All fields Required')),
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
                              'SignUp',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 25),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "You already have an account?",
                              style: TextStyle(fontSize: 18),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => UserLoginPage()));
                              },
                              child: Text(
                                'LogIn',
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
