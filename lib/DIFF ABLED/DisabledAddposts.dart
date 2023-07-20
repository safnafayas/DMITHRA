import 'package:flutter/material.dart';
class DisabledAppPost extends StatelessWidget {
  const DisabledAppPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
          slivers:[
            SliverAppBar(
              stretch: true,

              backgroundColor: Colors.white,
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications_none),
                  ),
                ),
              ],
            ),
          ]
      ),
    );
  }
}
