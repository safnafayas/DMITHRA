import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/material.dart';

import '../SharedPreference Use/sharedPrefUse.dart';
import '../connection/connect.dart';

class ShoppingNotification extends StatefulWidget {
  const ShoppingNotification({super.key});

  @override
  State<ShoppingNotification> createState() => _ShoppingNotificationState();
}

class _ShoppingNotificationState extends State<ShoppingNotification> {
  var flag = 0;
  var rqid;
  var lgid;

  @override
  void initState() {
    super.initState();
    myLogin();
    getData();
  }
  Future<void> _refresh() async {
    // Simulate a delay for fetching new data
    await Future.delayed(Duration(seconds: 2));
    setState(() {});
  }
  Future<List<dynamic>> getData() async {
    var response = await post(
      Uri.parse('${Con.url}confirmedProductOrderNotifi.php'),
      body: {'login_id': lgid.toString()},
    );
    print(response);
    var responseData = jsonDecode(response.body);
    var res2 = responseData[0]['result'];
    res2 == "success" ? flag = 1 : flag = 0;
    // if (flag == 1) {
    //   lgid = responseData[0]['login_id'];
    // }
    print(responseData);
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
        title: Text('Notifications'),
      ),
      body: FutureBuilder<List<dynamic>>(
          future: () async {
            await myLogin(); // Call myLogin to get the login id before calling getData
            return getData(); // Now call getData after getting the login id
          }(),
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
                onRefresh:() => _refresh(),
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: Key(snapshot.data![index]['order_id'].toString()),
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
                                                20, 8.0, 8.0, 10.0),
                                            child: Center(
                                              child: Text(
                                                'Wohoo...!!\nYour Order Shipping is Accepted...\n You can collect your product on pick up date',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 15,
                                                  color: Colors.blue,
                                                ),
                                                textAlign: TextAlign.center,
                                                maxLines: 3,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Order Id:',
                                            style: TextStyle(fontWeight: FontWeight.w800),
                                          ),
                                          Text(
                                            '${snapshot.data![index]['order_id'].toString()}',
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Product Id:',
                                            style: TextStyle(fontWeight: FontWeight.w800),
                                          ),
                                          Text(
                                            '${snapshot.data![index]['product_id'].toString()}',
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Rate:',
                                            style: TextStyle(fontWeight: FontWeight.w800),
                                          ),
                                          Text(
                                            '${snapshot.data![index]['rate'].toString()}',
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
                                                'Pick Up Date:',
                                                style: TextStyle(fontWeight: FontWeight.w800),
                                              ),
                                              Text(
                                                '${snapshot.data![index]['pickupdate']}',
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
