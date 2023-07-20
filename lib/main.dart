import 'package:dymithranew/DIFF%20ABLED/disableddonate.dart';
import 'package:dymithranew/DYMITHRI/Firstpage.dart';
import 'package:dymithranew/DYMITHRI/sample.dart';
import 'package:flutter/material.dart';

import 'DIFF ABLED/DisabledOnlineClass.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

          scaffoldBackgroundColor:const Color.fromRGBO(56, 129, 139, 20),
          primarySwatch: Colors.grey),

      home: const FirstPage(),
      debugShowCheckedModeBanner: false,

    );
  }
}
