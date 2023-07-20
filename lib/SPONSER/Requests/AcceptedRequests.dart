import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../../connection/connect.dart';
import '../../SharedPreference Use/sharedPrefUse.dart';
class AcceptedRequests extends StatefulWidget {

  AcceptedRequests({Key? key}) : super(key: key);

  @override
  State<AcceptedRequests> createState() => _AcceptedRequestsState();
}

class _AcceptedRequestsState extends State<AcceptedRequests> {
  var flag = 0;
  var rqid;
  var lgid;

  @override
  void initState() {
    super.initState();
    myLogin();
    getReq().then((req_id) {
      if (req_id != null) {
        setState(() {
          rqid = req_id;
        });
      }
    });
  }

  Future<List<dynamic>> getData() async {

    var response = await post(
        Uri.parse('${Con.url}views/view_accepted.php'));
    var responseData = jsonDecode(response.body);
    var res2 = responseData[0]['result'];
    res2 == "success" ? flag = 1 : flag = 0;
    if (flag == 1) {
      rqid = responseData[0]['req_id'];

    }

    return responseData;
  }



  Future<void> myLogin() async {
    lgid = await getSavedData();
    print('loginid: $lgid');
    rqid = await getReq();
     print('reqid: $rqid');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: FutureBuilder<List<dynamic>>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            print('Error: ${snapshot.error}');
            return Center(
              child: Text('Error occurred'),
            );
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return Center(
              child: Text('No Data..'),
            );
          }

          if (flag == 0) {
            return Center(child: Text('Nothing to show'));
          }


          return SizedBox(
            child: Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 30,
                      child: Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        decoration: BoxDecoration(color: Colors.white),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Accepted',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800),
                                      ),

                                    ],
                                  ),

                                  Row(
                                    children: [
                                      Text(
                                        'Description:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800),
                                      ),
                                      Text('${snapshot
                                          .data![index]['Description']
                                          .toString()}'),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text('Requested by:${snapshot
                                          .data![index]['Name']}'),
                                      Text('Request id:${snapshot
                                          .data![index]['req_id']}'),
                                    ],
                                  ),
                              
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),

    );
  }
}
