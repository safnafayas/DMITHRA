
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';
import '../../connection/connect.dart';
import '../../SharedPreference Use/sharedPrefUse.dart';

class RequestHelpNotifi extends StatefulWidget {
  const RequestHelpNotifi({Key? key}) : super(key: key);

  @override
  State<RequestHelpNotifi> createState() => _RequestHelpNotifiState();
}

class _RequestHelpNotifiState extends State<RequestHelpNotifi> {
  var flag = 0;
  var rqid;
  var lgid;

  @override
  void initState() {
    super.initState();
    getData(); // Fetch the data here before the FutureBuilder
    myLogin();
  }

  Future<void> _refresh() async {
    // Simulate a delay for fetching new data
    await Future.delayed(Duration(seconds: 2));
    setState(() {});
  }
  Future<List<dynamic>> getData() async {
    var response = await post(
      Uri.parse('${Con.url}acceptNotifi.php'),
      body: {'login_id': lgid.toString()},
    );
    var responseData = jsonDecode(response.body);
    var res2 = responseData[0]['result'];
    res2 == "success" ? flag = 1 : flag = 0;

    print('Response Data: $responseData'); // Add this line

    return responseData;
  }


  Future<void> myLogin() async {
    lgid = await getSavedData();
    print('loginid: $lgid');

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification'),
      ),
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
              height: MediaQuery.of(context).size.height,
              child: RefreshIndicator(
                onRefresh: _refresh,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: Key(snapshot.data![index]['req_id'].toString()),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: Colors.red,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      onDismissed: (direction) {
                        // Handle dismiss action here
                        // For example, you can remove the item from the list
                        setState(() {
                          snapshot.data!.removeAt(index);
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 30,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0), // Set rounded border
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0), // Set rounded border
                            ),
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
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                55, 8.0, 8.0, 10.0),
                                            child: Center(
                                              child: Text(
                                                'Congratulations ...!!\nYour Help Request Is Accepted',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 15,
                                                  color: Colors.green,
                                                ),
                                                textAlign: TextAlign.center,
                                                maxLines: 2,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Description:',
                                            style: TextStyle(fontWeight: FontWeight.w800),
                                          ),
                                          Text(
                                            '${snapshot.data![index]['Description'].toString()}',
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'Request id:',
                                                style: TextStyle(fontWeight: FontWeight.w800),
                                              ),
                                              Text(
                                                '${snapshot.data![index]['req_id']}',
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
