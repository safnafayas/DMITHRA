import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart';

import '../../SharedPreference Use/sharedPrefUse.dart';
import '../../UserNotifications/ShoppingUserNotifi.dart';
import '../../connection/connect.dart';
import 'DisabledShopping.dart';

class ShoppingDetailPage extends StatefulWidget {
  ShoppingDetailPage({
    Key? key,
    required this.image,
    this.description,
    this.productid,
    this.productname,
    this.rate,
    this.loginiD,
  });
  var lgid;

  var productid;
  var image;
  var description;
  var rate;
  var productname;
  var loginiD;
  @override
  State<ShoppingDetailPage> createState() => _ShoppingDetailPageState();
}

class _ShoppingDetailPageState extends State<ShoppingDetailPage> {
  var _dateInput = TextEditingController();
  var valueText;
  var pickupDate;
  String? lgid;

  @override
  void initState() {
    super.initState();
    print(widget.rate);
    print(widget.image);
    myLogin().then((value) {

      setState(() {
        lgid = value;
      });
    });
  }

  // @override
  // void initState() {
  //   super.initState();
  //   print(widget.rate);
  //   print(widget.image);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(child: Text('Shopping')),
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ShoppingNotification(),));

            },
            icon: const Icon(Icons.notifications_none),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 20),
        child: Card(
          elevation: 10,
          child: Container(
            alignment: Alignment.center,
            height: 600,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 350,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: widget.image,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    '${widget.productname}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text('Product ID: ${widget.productid}'),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text('Rate: ${widget.rate}'),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(widget.description),
                ),
                SizedBox(height: 40),
                Row(
                  children: [
                    SizedBox(width: 30),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: InkWell(
                        onTap: () {
                          _displayTextInputDialog(context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 300,
                          height: 50,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Buy Now',
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          color: Colors.green,
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
  }
  Future<String?> myLogin() async {
    var lgid = await getSavedData();
    print('loginid: $lgid');
    return lgid;
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Pick Up Your Date'),
          content: TextField(
            controller: _dateInput,
            decoration: InputDecoration(
              icon: Icon(Icons.calendar_today),
              labelText: "Enter Date",
            ),
            readOnly: true,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1950),
                lastDate: DateTime(2100),
              );

              if (pickedDate != null) {
                String formattedDate =
                DateFormat('yyyy-MM-dd').format(pickedDate);
                print(formattedDate);

                setState(() {
                  _dateInput.text = formattedDate;
                });
              }
            },
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Proceed'),
              onPressed: () {
                sendData(lgid.toString());

                if (_dateInput.text.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text('Choose Date'),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Ok'),
                          )
                        ],
                      );

                    },
                  );
                } else {
                  sendData(lgid.toString());
                  setState(() {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    _dateInput.text = '';
                  });
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> sendData(String lgid) async {
    var data = {
      "user_id": lgid.toString(),
      "product_id": widget.productid,
      "rate": widget.rate,
      "date": DateTime.now().toString(),
      'pickupdate': _dateInput.text
    };
   print(data);
    var response = await post(
        Uri.parse('${Con.url}requestorder.php'), body: data);

    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
        if (jsonDecode(response.body)['result'] == 'success') {
          ScaffoldMessenger.of(context).showSnackBar(snackBar('Order Placed Successfully..'));
          Navigator.push(context, MaterialPageRoute(builder: (context) => ShoppingCart(),));
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Please Note:'),
                content: Text('You will be notified when the product shipping is initiated'),
                actions: <Widget>[
                  ElevatedButton(
                    child: Text('OK'),
                    onPressed: () {
                      // Code to execute when the OK button is pressed
                      Navigator.of(context).pop(); // Close the dialog
                    },
                  ),
                ],
              );
            },
          );

        } else {
          ScaffoldMessenger.of(context).showSnackBar(snackBar('Failed to request order....'));


        }
      } else {
        throw Exception('Error returned');
      }
    }

    SnackBar snackBar(String message) {
      return SnackBar(content: Text(message));
    }
  }

