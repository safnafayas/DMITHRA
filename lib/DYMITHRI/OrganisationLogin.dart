import 'dart:convert';
import 'package:dymithranew/DYMITHRI/OrganisationReg.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../ORGANISATION/OrgHomePage.dart';
import '../connection/connect.dart';
import 'UserSignUp.dart';

class OrgLoginPage extends StatefulWidget {
  const OrgLoginPage({super.key});

  @override
  State<OrgLoginPage> createState() => _OrgLoginPageState();
}

class _OrgLoginPageState extends State<OrgLoginPage> {
  var _namecontroller = TextEditingController();
  var _passcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  Future<void> login() async {
    var data = {
      'username': _namecontroller.text,
      'password': _passcontroller.text,
      'type': 'Organisation',
    };
    var response = await post(
        Uri.parse('${Con.url}spo_org_login.php'),
        body: data);
    print(response.body);
    print(response.statusCode);
    jsonDecode(response.body)['result'] == 'Success'
        ? {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Logged in Successfully'))),
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const OrgHomePage()))
    }
        : {  ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Failed')),
    ),
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OrgLoginPage()),
      ),};

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
                    padding: const EdgeInsets.all(20.0),
                    child: TextField(
                      controller: _namecontroller,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        label: Text(
                          'Username ',
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
                      if (_namecontroller.text.isNotEmpty &&
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
                              builder: (context) => OrgReg(),
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
