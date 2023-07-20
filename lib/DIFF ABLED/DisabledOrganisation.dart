import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/material.dart';

import '../DYMITHRI/ModelsDymithri/OrganisationModel.dart';
import '../connection/connect.dart';

class DisabledOrganisation extends StatefulWidget {
  const DisabledOrganisation({Key? key}) : super(key: key);

  @override
  _DisabledOrganisationState createState() => _DisabledOrganisationState();
}

class _DisabledOrganisationState extends State<DisabledOrganisation> {
  Future<List<dynamic>> getdata() async {
    var flag;
    var response = await get(Uri.parse('${Con.url}/views/view_organisation.php'));
    print(response.body);
    var res2 = jsonDecode(response.body)[0]['result'];
    print('result is: $res2');
    res2 == "success" ? flag = 1 : flag = 0;
    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
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
          FutureBuilder<List<dynamic>>(
            future: getdata(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (snapshot.hasError) {
                return SliverFillRemaining(
                  child: Center(
                    child: Text('Error: ${snapshot.error}'),
                  ),
                );
              } else {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 5,
                          child: Container(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(snapshot.data![index]['Org_name']),
                                  Text(snapshot.data![index]['Org_category']),
                                  Text(snapshot.data![index]['Email']),
                                  Text(snapshot.data![index]['Address']),
                                  Text(snapshot.data![index]['Location']),
                                  Text(snapshot.data![index]['Contact_number'].toString()),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: snapshot.data!.length,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
