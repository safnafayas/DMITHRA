import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../../connection/connect.dart';
import '../../SharedPreference Use/sharedPrefUse.dart';

class AccessoriesRequested extends StatefulWidget {
  var type;
  AccessoriesRequested({Key? key, required this.type}) : super(key: key);

  @override
  State<AccessoriesRequested> createState() => _AccessoriesRequestedState();
}

class _AccessoriesRequestedState extends State<AccessoriesRequested> {
  var flag = 0;
  var rqid;
  var lgid;

  @override
  void initState() {
    super.initState();
    myLogin();
    getData();
  }

  Future<List<dynamic>> getData() async {
    var data = {
      'type': widget.type,
    };
    print(data);
    var response = await post(Uri.parse('${Con.url}views/view_request.php'), body: data);
    var responseData = jsonDecode(response.body);
    print(responseData[0]['result']);
    print(response.body);
    if (responseData.length > 0 && responseData[0]['result'] == 'success') {
        flag = 1;
        rqid = responseData[0]['req_id'].toString();
    } else {

        flag = 0;

    }

    return responseData;
  }

  Future<void> updateStatus(String reqId) async {
    var data = {
      'req_id': reqId,
      'login_id': lgid.toString(),
    };

    var response = await post(Uri.parse('${Con.url}acceptRequest.php'), body: data);
    var jsonResponse = jsonDecode(response.body);
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);

      if (responseData['result'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Accepted Successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to send request')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to connect to the server')),
      );
    }
  }

  Future<void> myLogin() async {
    lgid = await getSavedData();
    print('loginid: $lgid');
    getReq().then((req_id) {
      if (req_id != null) {
        setState(() {
          rqid = req_id;
        });
      }
      print('loginid: $lgid');
    });
  }
  void showConfirmationDialog(String reqId, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text('Are you sure you want to accept?'),
          actions: <Widget>[
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                updateStatus(reqId);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: const <Widget>[
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            print('Error: ${snapshot.error}');
            return const Center(
              child: Text('Error occurred'),
            );
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(
              child: Text('No Data..'),
            );
          }

          if (flag == 0) {
            return const Center(child: Text('Nothing to show'));
          }
else
          return SizedBox(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemCount: snapshot.data?.length ?? 0, // Add null check here
                itemBuilder: (context, index) {
                  if (snapshot.data == null || index >= snapshot.data!.length) {
                    // Handle null data or index out of bounds
                    return SizedBox.shrink();
                  }

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 30,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
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
                                        'Requested for:',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      Visibility(
                                        visible: snapshot.data![index]['type'] != 'money' ? false : true,
                                        child: Row(
                                          children: [
                                            const Text(
                                              'UDID:',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                            Text(
                                              ' Rs.${snapshot.data![index]['Amount'].toString()}',
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Visibility(
                                    visible: widget.type == 'food'? true:false,
                                    child: Text(snapshot.data![index]['Foodtype'] ?? 'No Food Type'),
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        'Description:',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      Text(snapshot.data![index]['Description'].toString()),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            'User:',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                          Text(snapshot.data![index]['Name'].toString()),
                                        ],
                                      ),
                                      SizedBox(width: 30,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              const Text(
                                                'UDID:',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                              Text(snapshot.data![index]['UDID'].toString()),
                                            ],
                                          ),
                      ]
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        'Contact Name:',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      Text(snapshot.data![index]['Contact_name']),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        'Contact Address:',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      Text(snapshot.data![index]['Contact_address'] ?? 'No Contact name'),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        'Contact Number:',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      Text(snapshot.data![index]['Contact_number'].toString()),
                                    ],
                                  ),
                                  Visibility(
                                    visible: widget.type== 'medicine' ?true:false,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: 349,
                                        height: 200,
                                        child: Image(
                                          fit: BoxFit.cover,
                                          image: NetworkImage('${Con.url}prescribtionUpload/${snapshot.data![index]['Image']}'),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: InkWell(
                                      onTap: () {
                                        showConfirmationDialog(snapshot.data![index]['req_id'].toString(), context);

                                        // updateStatus(snapshot.data![index]['req_id'].toString());
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 349,
                                        color: Colors.green,
                                        child: const Center(
                                          child: Text(
                                            'Accept',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
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
