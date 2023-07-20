 import 'dart:convert';
// import 'dart:math';
//
 import 'dart:math';

import 'package:flutter/material.dart';

import '../../DYMITHRI/ModelsDymithri/GridItemShopping.dart';
import '../../SharedPreference Use/sharedPrefUse.dart';
import '../../UserNotifications/ShoppingUserNotifi.dart';
import '../../connection/connect.dart';
import 'DetailPage.dart';
import 'package:http/http.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({super.key});

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
 var lgid;
  Future<List<dynamic>> getdata() async {
    var flag;
    var response =
    await get(Uri.parse('${Con.url}views/view_product.php'));
    print(response.body);
    var res2 = jsonDecode(response.body)[0]['result'];
    print('result is: $res2');
    res2 == "success" ? flag = 1 : flag = 0;
    return jsonDecode(response.body);
  }

  Future<void> myLogin() async {
    lgid = await getSavedData();
    print('loginid: $lgid');


  }


 @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:AppBar(
        title:Center(child: Text('Shopping')),
        backgroundColor: Colors.white,
        actions:<Widget>[IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ShoppingNotification(),));
          },
          icon: const Icon(Icons.notifications_none),
        ),
        ]
      ) ,
    body: FutureBuilder(
      future: getdata(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print('Error: ${snapshot.error}');
          return const Center(
            child: Text('Error occurred'),
          );
        }

        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Hi..',style:TextStyle(fontWeight: FontWeight.w800,fontSize: 20)),
              ),  Padding(
                padding: const EdgeInsets.only(top:0,left: 8,bottom: 10),
                child: Text('Shop with us..,',style:TextStyle(fontWeight: FontWeight.w400,fontSize: 18)),
              ),
              Expanded(
                child: GridView.builder(

                    itemCount:snapshot.data!.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

                      mainAxisSpacing: 8,
                      crossAxisSpacing: 4,
                      childAspectRatio: 0.7,
                      crossAxisCount: 2,
                    ), itemBuilder:(context,index){
                return InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder:(context)=>ShoppingDetailPage(
                      image: NetworkImage(
                        '${Con.url}productImagesUpload/${snapshot.data![index]['Image']}',),

                      productid:snapshot.data![index]['product_id'],
                      productname: snapshot.data![index]['Product_name'],
                      rate: snapshot.data![index]['rate'],
                      description: snapshot.data![index]['Description'],
                      loginiD:lgid.toString()

                    )));
                  },
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(10))),
                    color: Colors.amber[Random().nextInt(4) * 100],
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height:200,
                              decoration:BoxDecoration(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                                image: DecorationImage(

                                  fit: BoxFit.cover,
                                    image: NetworkImage('${Con.url}productImagesUpload/${snapshot.data![index]['Image']}',),

                                ),
                              )
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text('Product Name${snapshot.data![index]['Product_Name']}'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text('Rs ${snapshot.data![index]['rate']}'),
                            ),

                          ],
                        ),
                      ),


                  ),
                );
                }
                ),
              ),
            ],
          ),
        );
      }
    )
    );
  }
}
