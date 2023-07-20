import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          actions:<Widget>[
          IconButton(
          onPressed:(){},
      icon:Icon(Icons.search),

    ),
    Padding(
    padding: const EdgeInsets.all(8.0),
    child: IconButton(onPressed: (){}, icon:Icon(Icons.notifications_none)),
      ),


]
    )
    );
  }
}
