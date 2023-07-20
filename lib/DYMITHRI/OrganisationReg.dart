import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../connection/connect.dart';
import 'OrganisationLogin.dart';

class OrgReg extends StatefulWidget {
  const OrgReg({super.key});

  @override
  State<OrgReg> createState() => _OrgRegState();
}

class _OrgRegState extends State<OrgReg> {
  var _orgname = TextEditingController();
  var _orgcategory = TextEditingController();
  var _address = TextEditingController();
  var _location = TextEditingController();
  var _contactnumber = TextEditingController();
  var _email = TextEditingController();
  var _password = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  Future<void> orgregister() async {
    var data = {
      'username': _orgname.text,
      'password': _password.text,
      'address': _address.text,
      'contact_number': _contactnumber.text,
      'email': _email.text,
      'location': _location.text,
      'type': 'Organisation',
      'org_category': _orgcategory.text,
    };
    var response = await post(
        Uri.parse('${Con.url}org_reg.php'),
        body: data);
    print(response.body);
    print(response.statusCode);
    jsonDecode(response.body)['result'] == 'success'
        ? {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Registered Successfully'))),
            Navigator.pop(context)
          }
        : {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Failed to register'))),
            Navigator.pop(context)
          };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 8.0, top: 20, bottom: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          height: 80,
                          width: 80,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      'assets/Images/EllipseL.png')))),
                      const Image(
                          image: AssetImage(
                              'assets/Images/ORGANIZATION REGISTRATION.png'))
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, bottom: 10, top: 15),
                child: TextField(
                  controller: _orgname,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: 'Organisation Name',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide(
                          color: Color.fromARGB(
                        200,
                        61,
                        193,
                        235,
                      )),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(
                      200,
                      61,
                      193,
                      235,
                    ))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, bottom: 10, top: 15),
                child: TextField(
                  controller: _orgcategory,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: 'Organisation Category',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide(
                          color: Color.fromARGB(
                        200,
                        61,
                        193,
                        235,
                      )),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(
                      200,
                      61,
                      193,
                      235,
                    ))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, bottom: 10, top: 15),
                child: TextField(
                  controller: _address,
                  maxLines: 3,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: 'Address',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide(
                          color: Color.fromARGB(
                        200,
                        61,
                        193,
                        235,
                      )),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(
                      200,
                      61,
                      193,
                      235,
                    ))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, bottom: 10, top: 15),
                child: TextField(
                  controller: _location,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: 'location',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide(
                          color: Color.fromARGB(
                        200,
                        61,
                        193,
                        235,
                      )),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(
                      200,
                      61,
                      193,
                      235,
                    ))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, bottom: 5, top: 10),
                child: TextField(
                  controller: _contactnumber,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text('Contact Number', textAlign: TextAlign.start),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide(
                          color: Color.fromARGB(
                        200,
                        61,
                        193,
                        235,
                      )),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(
                      200,
                      61,
                      193,
                      235,
                    ))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, bottom: 10, top: 15),
                child: TextField(
                  controller: _email,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: 'E-mail',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide(
                          color: Color.fromARGB(
                        200,
                        61,
                        193,
                        235,
                      )),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(
                      200,
                      61,
                      193,
                      235,
                    ))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, bottom: 10, top: 15),
                child: TextField(
                  controller: _password,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  obscuringCharacter: '*',
                  decoration: const InputDecoration(
                    hintText: 'Password',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide(
                          color: Color.fromARGB(
                        200,
                        61,
                        193,
                        235,
                      )),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(
                      200,
                      61,
                      193,
                      235,
                    ))),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  if (_orgcategory.text.isNotEmpty &&
                      _orgcategory.text.isNotEmpty &&
                      _address.text.isNotEmpty &&
                      _location.text.isNotEmpty &&
                      _contactnumber.text.isNotEmpty &&
                      _email.text.isNotEmpty &&
                      _password.text.isNotEmpty) {
                    if (_formkey.currentState!.validate()) {
                      orgregister();
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('All fields Required')));
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
                      borderRadius: BorderRadius.all(Radius.circular(100))),
                  height: 50,
                  width: 200,
                  child: const Center(
                      child: Text(
                    'Register',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 25),
                  )),
                ),
              ),

              // SizedBox(height:5,),
              Padding(
                padding: const EdgeInsets.only(
                    left: 8.0, right: 8.0, top: 8.0, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const OrgLoginPage()));
                        },
                        child: const Text(
                          ' LogIn',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w800),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
