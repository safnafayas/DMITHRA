import 'dart:math';
import 'dart:convert';
import 'package:dymithranew/ORGANISATION/ViewOrders.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../connection/connect.dart';
import 'OrganisationAddItems.dart';
class OrgAddShoppingItems extends StatefulWidget {
  const OrgAddShoppingItems({super.key});

  @override
  State<OrgAddShoppingItems> createState() => _OrgAddShoppingItemsState();
}

class _OrgAddShoppingItemsState extends State<OrgAddShoppingItems> {
  var pid;
  var flag;
  var rate=TextEditingController();
  Future<List<dynamic>> getdata() async {
    var flag;
    var response = await get(Uri.parse('${Con.url}/views/view_product.php'));
    print(response.body);
    var res2 = jsonDecode(response.body)[0]['result'];
    print('result is: $res2');
    res2 == "success" ? flag = 1 : flag = 0;
    return jsonDecode(response.body);
  }
  Future<dynamic> editData() async{
    var data= {
      'pid':pid.toString(),
      'rate':rate.text,
    };
    print(data);
    var response =
    await post(Uri.parse('${Con.url}/views/editproduct.php'), body: data);
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['result'] == 'success') {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'Edited Successfully...',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          backgroundColor: Color(0xfa8f7805),
        ));

        print(flag);
        // return json.decode(response.body);
      } else {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'Failed to edit...',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          backgroundColor: Color(0xfa8f7805),
        ));
        print(flag);
      }
    } else
      throw Exception('Error returned');
  }

      void deleteProduct() async {
        var data = {
          'product_id': pid.toString()
        };
        var response = await post(
            Uri.parse('${Con.url}views/deleteproduct.php'),
            body: data);
        print(response.body);
        print(response.statusCode);
        if (response.statusCode == 200) {
          var responseData = jsonDecode(response.body);

          if (responseData['result'] == 'success') {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('deleted Successfully')),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Failed to register')),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to connect to the server')),
          );
        }

    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Center(child: Text('Shop')),

        backgroundColor: Colors.white,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>ViewOrders()));
              },

              icon: const Icon(Icons.notifications_none),
            ),
          ),


        ],


      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
          child:const Icon(Icons.add,),

          onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddShoppingItems()));
      }
      ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Hi Steve..',style:TextStyle(fontWeight: FontWeight.w800,fontSize: 20)),
              ),  Padding(
                padding: const EdgeInsets.only(top:0,left: 8,bottom: 10),
                child: Text('Shop with us..,',style:TextStyle(fontWeight: FontWeight.w400,fontSize: 18)),
              ),
              Expanded(
                child: FutureBuilder(
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

                    return GridView.builder(

                        itemCount:snapshot.data!.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

                          mainAxisSpacing: 8,
                          crossAxisSpacing: 4,
                          childAspectRatio: 0.55,
                          crossAxisCount: 2,
                        ), itemBuilder:(context,index){
                      return InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder:(context)=>AddShoppingItems(



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
                                        image: NetworkImage(  '${Con.url}productImagesUpload/${snapshot.data![index]['Image']}'),
                                      ),
                                  ) ,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text('Product Name${snapshot.data![index]['Product_name']}'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child:

                                      Text('Rs ${snapshot.data![index]['rate']}'),

                                  ),
                                Text('Rs ${snapshot.data![index]['product_id']}'),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(

                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ElevatedButton(


                                         style: ButtonStyle(
                                           backgroundColor: MaterialStatePropertyAll(Colors.green)
                                         ) ,onPressed: (){
                                        rate.text=snapshot.data![index]['rate'];

                                        showDialog(context: context, builder:(context){
                                             return AlertDialog(

                                                 title: Text('Edit Details'),
                                               content: Container(
                                                 height: 100,
                                                 child: TextFormField(
                                                   keyboardType: TextInputType.text,
                                                   controller: rate,
                                                   decoration: InputDecoration(
                                                     label: Text('New Rate'),

                                                   ),
                                                 ),
                                               ),
                                               actions: [
                                                 TextButton(onPressed: (){

                                                   pid=snapshot.data![index]['product_id'];
                                                   editData();

                                                 }, child:Text('Edit')),
                                                 TextButton(
                                                     onPressed: () {
                                                       Navigator.pop(context);
                                                     },
                                                     child: const Text(
                                                         'Cancel')),
                                               ],
                                             );
                                           });

                                      }, child:Text(
                                        'Edit'
                                      )),

                                      ElevatedButton(

                                         style: ButtonStyle(
                                           backgroundColor: MaterialStatePropertyAll(Colors.red)
                                         ) ,onPressed: (){
                                       showDialog(context: context, builder:(context){
                                         return AlertDialog(
                                           title: Text('Delete Product'),
                                           content: Text('Are you sure?'),
                                           actions: [
                                             TextButton(onPressed:(){
                                               pid=snapshot.data![index]['product_id'];
                                               Navigator.pop(context);
                                               setState(() {
                                                 deleteProduct();

                                               });

                                             }, child:Text('Yes')),
                                             TextButton(
                                                 onPressed: () {

                                                   Navigator.pop(context);
                                                 },
                                                 child:
                                                 const Text('No')),

                                           ],
                                         );

                                        });
                                      }, child:Text(
                                        'Delete'
                                      )),
                                    ],
                                  ),
                                )

                              ],
                            ),
                          ),


                        ),
                      );
                    }
                    );
                  }
                ),
              ),
            ],
          ),
        )


    );
  }
}
