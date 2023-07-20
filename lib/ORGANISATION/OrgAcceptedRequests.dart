import 'package:flutter/material.dart';

import '../DYMITHRI/ModelsDymithri/RequestsModel.dart';
class OrgAcceptedRequests extends StatefulWidget {
  const OrgAcceptedRequests({super.key});

  @override
  State<OrgAcceptedRequests> createState() => _OrgAcceptedRequestsState();
}

class _OrgAcceptedRequestsState extends State<OrgAcceptedRequests> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        title:Text('Accepted:'),
                        subtitle:Text(foodReq[index]['Description']),

                      ),
                    ),
                  );

                },childCount: 2,
              )
          )
        ],
      ),
    );
  }
}
