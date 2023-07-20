import 'package:flutter/material.dart';

import '../../DYMITHRI/ModelsDymithri/RequestsModel.dart';
class FundRequest extends StatelessWidget {
  const FundRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Center(child: Text('Requests')),

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
      body: CustomScrollView(
        slivers: [
          SliverList(

              delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.white,
                        child: ListTile(

                            leading:Image(image: foodReq[index]['image'],),
                            title:Text('Requested For:'),
                            subtitle:Text(foodReq[index]['Description']),

                            trailing:foodReq[index]['Pending Button']
                        ),
                      ),
                    );

                  },childCount: 2
              )
          )
        ],
      ),

    );
  }
}
