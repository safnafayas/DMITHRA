import 'package:flutter/material.dart';

class DonatePage extends StatelessWidget {
  const DonatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
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
            ],
          ),
        ],

      ),
      drawer: Drawer(),


    );
  }
}
