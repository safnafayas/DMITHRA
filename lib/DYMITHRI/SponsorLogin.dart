import 'dart:convert';

import 'package:dymithranew/SharedPreference%20Use/sharedPrefUse.dart';
import 'package:flutter/material.dart';
import '../SPONSER/SponsorHome.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../connection/connect.dart';
import 'SponserSignUp.dart';
// final client = http.Client();
// client.timeout = const Duration(seconds: 60); //
class SponsorLoginPage extends StatefulWidget {
  const SponsorLoginPage({super.key});

  @override
  State<SponsorLoginPage> createState() => _SponsorLoginPageState();
}

class _SponsorLoginPageState extends State<SponsorLoginPage> {
  @override
  var loginid;
  var _name = TextEditingController();
  var _passcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  Future<void> login() async {
    var data = {
      'username': _name.text,
      'password': _passcontroller.text,
      'type': 'Sponsor'
    };
    var response = await post(
        Uri.parse('${Con.url}spo_org_login.php'),
        body: data);

    var jsonResponse = jsonDecode(response.body);

    if (jsonResponse['result'] == 'Success') {
      loginid=jsonDecode(response.body)['login_id'];
      print(loginid);
      saveData(loginid);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Logged in Successfully')),);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SponsorHome()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed')),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SponsorLoginPage()),
      );
    }
  }


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(
        200,
        61,
        193,
        235,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SingleChildScrollView(
            child: Container(
              height: 450,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.only(topLeft: Radius.circular(120)),
              ),
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 120,
                        width: 150,
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30)),
                            image: DecorationImage(
                                fit: BoxFit.contain,
                                image: AssetImage(
                                    'assets/Images/Rectangle 44.png'))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextField(
                        controller: _name,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          label: Text(
                            'Username',
                            style: TextStyle(fontSize: 20),
                          ),
                          focusColor: Colors.cyan,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 10),
                      child: TextField(
                        controller: _passcontroller,
                        obscureText: true,
                        obscuringCharacter: '*',
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          label: Text(
                            'Password',
                            style: TextStyle(fontSize: 20),
                          ),
                          focusColor: Colors.cyan,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        if (_name.text.isNotEmpty &&
                            _passcontroller.text.isNotEmpty) {
                          login();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('All fields Required')));
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>SponsorHome()));
                        }
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(
                              200,
                              61,
                              193,
                              235,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(100))),
                        height: 50,
                        width: 200,
                        child: const Center(
                            child: Text(
                          'Login',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 25),
                        )),
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Dont have an account?",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SignUpSponsor()));
                            },
                            child: const Text(
                              ' SignUp',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w800),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
