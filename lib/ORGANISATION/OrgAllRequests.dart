import 'package:dymithranew/SPONSER/Requests/AcceptedRequests.dart';
import 'package:dymithranew/SPONSER/Requests/Requestedhelps.dart';
import 'package:dymithranew/SPONSER/Requests/Typesof%20Request.dart';
import 'package:flutter/material.dart';


import 'OrgAcceptedRequests.dart';
import 'OrgAllRequestPage.dart';
class OrgAllRequests extends StatelessWidget {
  const OrgAllRequests({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Requests'),
          bottom: TabBar(tabs: [
            Tab(text: 'All Requests',),
            Tab(text: 'Accepted Requests',)
          ]),
        ),
        body: TabBarView(children: [
          AllRequestsPage(),
          AcceptedRequests(),
        ]),

      ),
    );
  }
}
