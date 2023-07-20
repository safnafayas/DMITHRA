import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/material.dart';

import '../connection/connect.dart';

class ViewOrders extends StatefulWidget {
  const ViewOrders({Key? key}) : super(key: key);

  @override
  _ViewOrdersState createState() => _ViewOrdersState();
}

class _ViewOrdersState extends State<ViewOrders> {
  var productid;
  var status;
  var stock;
  var orderid;
  var pickupdate;
  Future<List<dynamic>> getdata() async {
    var flag;
    var response = await get(Uri.parse('${Con.url}/view_orders.php'));
    print(response.body);
    var res2 = jsonDecode(response.body)[0]['result'];
    print('result is: $res2');
    res2 == "success" ? flag = 1 : flag = 0;
    return jsonDecode(response.body);
  }
  Future<dynamic> sendData() async {
    var data = {
      'order_id': orderid.toString(),
      'status':status.toString(),
      'product_id':productid.toString(),
      'stock':stock.toString(),



    };
    print(data);

    var response =
    await post(Uri.parse('${Con.url}updateOrder.php'), body: data);
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['result'] == 'success') {
        // ScaffoldMessenger.of(context).showSnackBar(
            // snackMsg('Updated Order Status: (${status})....'));

        return json.decode(response.body);
      } else
        throw Exception('Error returned');
    }
  }
  // Future<dynamic> sendNoti() async {
  //   var data = {
  //     'order_id': orderid,
  //     'product_id':productid,
  //     'msg_from':'Seller',
  //
  //     'pickupdate':pickupdate,
  //
  //
  //     'date':DateTime.now().toString()
  //
  //
  //
  //   };
  //
  //   var response =
  //   await post(Uri.parse('${Con.url}toNotification.php'), body: data);
  //   print(response.body);
  //   print(response.statusCode);
  //   if (response.statusCode == 200) {
  //     if (jsonDecode(response.body)['result'] == 'success') {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('Accepted Successfully')),
  //       );
  //       return json.decode(response.body);
  //     } else
  //       throw Exception('Error returned');
  //   }
  // }
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
                                  Row(
                                    children: [
                                      Text('Order Id: ',style: TextStyle(fontWeight: FontWeight.bold),),
                                      Text(snapshot.data![index]['order_id']),
                                    ],
                                  ),

                                  Row(
                                    children: [
                                      Text('Product Id: ',style: TextStyle(fontWeight: FontWeight.bold),),

                                      Text(snapshot.data![index]['product_id']),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('Product Name: ',style: TextStyle(fontWeight: FontWeight.bold),),

                                      Text(snapshot.data![index]['product_name']),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('Description: ',style: TextStyle(fontWeight: FontWeight.bold),),

                                      Text(snapshot.data![index]['description']),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('Rate: ',style: TextStyle(fontWeight: FontWeight.bold),),

                                      Text(snapshot.data![index]['rate']),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('Pick Up Date: ',style: TextStyle(fontWeight: FontWeight.bold),),

                                      Text(snapshot.data![index]['pickupdate']),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.network(
                                      '${Con.url}productImagesUpload/${snapshot.data![index]['image']}',
                                      height: 100,
                                      width: 100,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ElevatedButton(
                                        onPressed: () {
                            orderid = snapshot.data![index]['order_id'];
                            productid = snapshot.data![index]['product_id'];
                            status = 'declined';
                            sendData();
                            setState(() {});
                            },
                              child: Text('Reject'),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.red),
                                textStyle: MaterialStateProperty.all(TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                )),
                                padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 24,
                                )),
                              ),
                            ),
                                      ),



                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            orderid = snapshot.data![index]['order_id'];
                                            productid = snapshot.data![index]['product_id'];
                                            status = 'accepted';
                                            stock = stock ?? 0;
                                            stock--;
                                            sendData();
                                            setState(() {});
                                          },
                                          child: Text('Accept'),
                                          style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty.all(Colors.green),
                                            textStyle: MaterialStateProperty.all(TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            )),
                                            padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                                              vertical: 12,
                                              horizontal: 24,
                                            )),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
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
