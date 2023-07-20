import 'package:flutter/material.dart';

import '../../DYMITHRI/ModelsDymithri/RequestsModel.dart';
class OrgFundRequest extends StatelessWidget {
  const OrgFundRequest({super.key});

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

                            leading:Image(image: fundReq[index]['image'],),
                            title:Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Requested For:'),
                                Text(fundReq[index]['Amount'],)
                              ],
                            ),
                            subtitle:Text(fundReq[index]['Description']),

                            trailing:foodReq[index]['Accept Button']
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
