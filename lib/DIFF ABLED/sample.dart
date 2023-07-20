// import 'dart:convert';
// import 'dart:math' as math;
//
// import 'package:autoprohub/PROVIDER/Services/Cab/addCabDetails.dart';
// import 'package:autoprohub/SP/sp.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart';
//
// import '../../../connection/connect.dart';
//
// class ViewCabs extends StatefulWidget {
//   ViewCabs({Key? key, required this.type}) : super(key: key);
//
//   var type;
//   @override
//   State<ViewCabs> createState() => _ViewCabsState();
// }
//
// class _ViewCabsState extends State<ViewCabs> {
//   var pro_id;
//   @override
//   void initState() {
//     super.initState();
//     myLogin();
//   }
//
//   Future<void> myLogin() async {
//     pro_id = await getLogin();
//   }
//
//   var flag;
//   var cab_id;
//   var rate = TextEditingController();
//   Future<dynamic> getData() async {
//     var data = {
//       'pro_id': pro_id.toString(),
//       'type': widget.type,
//     };
//
//     var response = await post(Uri.parse('${Con.url}viewCabs.php'), body: data);
//     print(response.body);
//     print(response.statusCode);
//     if (response.statusCode == 200) {
//       jsonDecode(response.body)[0]['result'] == 'success' ? flag = 1 : flag = 0;
//       print(flag);
//       return json.decode(response.body);
//     } else
//       throw Exception('Error returned');
//   }
//
//   Future<dynamic> deleteData() async {
//     var data = {
//       'cab_id': cab_id,
//     };
//
//     var response = await post(Uri.parse('${Con.url}deleteCab.php'), body: data);
//     print(response.body);
//     print(response.statusCode);
//     if (response.statusCode == 200) {
//       if (jsonDecode(response.body)['result'] == 'success') {
//         setState(() {});
//         Navigator.pop(context);
//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text(
//             'Deleted Successfully...',
//             style: TextStyle(fontSize: 20, color: Colors.white),
//           ),
//           backgroundColor: Color(0xfa8f7805),
//         ));
//
//         print(flag);
//         // return json.decode(response.body);
//       } else {
//         Navigator.pop(context);
//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text(
//             'Failed to delete...',
//             style: TextStyle(fontSize: 20, color: Colors.white),
//           ),
//           backgroundColor: Color(0xfa8f7805),
//         ));
//
//         print(flag);
//       }
//     } else
//       throw Exception('Error returned');
//   }
//
//   Future<dynamic> editData() async {
//     var data = {
//       'cab_id': cab_id,
//       'rate': rate.text,
//     };
//
//     var response =
//     await post(Uri.parse('${Con.url}editCabDetails.php'), body: data);
//     print(response.body);
//     print(response.statusCode);
//     if (response.statusCode == 200) {
//       if (jsonDecode(response.body)['result'] == 'success') {
//         setState(() {});
//         Navigator.pop(context);
//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text(
//             'Edited Successfully...',
//             style: TextStyle(fontSize: 20, color: Colors.white),
//           ),
//           backgroundColor: Color(0xfa8f7805),
//         ));
//
//         print(flag);
//         // return json.decode(response.body);
//       } else {
//         Navigator.pop(context);
//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text(
//             'Failed to edit...',
//             style: TextStyle(fontSize: 20, color: Colors.white),
//           ),
//           backgroundColor: Color(0xfa8f7805),
//         ));
//
//         print(flag);
//       }
//     } else
//       throw Exception('Error returned');
//   }
//
//   void nav(String type) {
//     Navigator.push(
//         context,
//         MaterialPageRoute(
//             builder: (context) => AddCabDetails(
//               type: type,
//             )));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         isExtended: true,
//         onPressed: () {
//           nav(widget.type);
//         },
//         child: const Icon(Icons.add),
//       ),
//       appBar: AppBar(
//         title: const Text(
//           'Cabs',
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         actions: [
//           IconButton(
//             onPressed: () {},
//             icon: const Icon(Icons.home),
//           )
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: FutureBuilder(
//             future: getData(),
//             builder: (context, snapshot) {
//               if (snapshot.hasError) print('Error ::${snapshot.error}');
//               print('Inside builder ::${snapshot.hasData}');
//               if (!snapshot.hasData) {
//                 return const Center(
//                   child: Center(child: Text('No Data')),
//                 );
//               }
//               //  return flag==0?lottieNothing():
//               return flag == 0
//                   ? const Center(
//                 child: Text("No Data to show.."),
//               )
//                   : ListView.separated(
//                 separatorBuilder: (context, index) {
//                   return const Divider();
//                 },
//                 itemCount: snapshot.data.length,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: const EdgeInsets.all(15.0),
//                     child: Card(
//                       elevation: 20,
//                       child: Container(
//                         height: 640,
//                         width: MediaQuery.of(context).size.width,
//                         child: SingleChildScrollView(
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Container(
//                                     height: 350,
//                                     width:
//                                     MediaQuery.of(context).size.width,
//                                     color: const Color(0xffa2e7ef),
//                                     child: Image.network(
//                                       '${Con.url}cabs/${snapshot.data[index]['image']}',
//                                       fit: BoxFit.fill,
//                                     )),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Text(
//                                   'Name: ${snapshot.data[index]['name']}',
//                                   // style: heading1,
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Visibility(
//                                   visible: snapshot.data[index]['type'] !=
//                                       'Goods'
//                                       ? true
//                                       : false,
//                                   child: Text(
//                                     'No. of Person: ${snapshot.data[index]['person']}',
//                                     // style: heading1,
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Visibility(
//                                   visible: snapshot.data[index]['type'] ==
//                                       'Goods'
//                                       ? true
//                                       : false,
//                                   child: Text(
//                                     'Vehicle Size: ${snapshot.data[index]['size']}',
//                                     // style: heading1,
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Text(
//                                   'Rs ${snapshot.data[index]['rate']}',
//                                   // style: heading1,
//                                 ),
//                               ),
//                               const Padding(
//                                 padding: EdgeInsets.all(8.0),
//                                 child: Text(
//                                   'Description',
//                                   style: TextStyle(
//                                       color: Colors.blue,
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Text(
//                                   '${snapshot.data[index]['description']}',
//                                   //  style: descStyle,
//                                 ),
//                               ),
//                               //  Spacer(),
//                               ButtonBar(
//                                 children: [
//                                   // ElevatedButton(
//                                   //     onPressed: () {
//                                   //       print(widget.type);
//                                   //       setState(() {
//                                   //     //    addToCart();
//                                   //       });
//                                   //     },
//                                   //     child: Text('Add to Cart')),
//                                   ButtonBar(
//                                     children: [
//                                       ElevatedButton(
//                                           onPressed: () {
//                                             rate.text = snapshot
//                                                 .data[index]['rate'];
//                                             showDialog(
//                                                 context: context,
//                                                 builder: (context) {
//                                                   return AlertDialog(
//                                                     title: const Text(
//                                                         'Edit Details'),
//                                                     content: Container(
//                                                       height: 100,
//                                                       child:
//                                                       TextFormField(
//                                                         keyboardType:
//                                                         TextInputType
//                                                             .text,
//                                                         controller: rate,
//                                                         decoration:
//                                                         const InputDecoration(
//                                                             label: Text(
//                                                                 'New Rate')),
//                                                       ),
//                                                     ),
//                                                     actions: [
//                                                       TextButton(
//                                                           onPressed: () {
//                                                             cab_id = snapshot
//                                                                 .data[
//                                                             index]
//                                                             [
//                                                             'cab_id'];
//                                                             editData();
//                                                           },
//                                                           child:
//                                                           const Text(
//                                                               'Edit')),
//                                                       TextButton(
//                                                           onPressed: () {
//                                                             Navigator.pop(
//                                                                 context);
//                                                           },
//                                                           child: const Text(
//                                                               'Cancel')),
//                                                     ],
//                                                   );
//                                                 });
//                                           },
//                                           child: const Text('Edit')),
//                                       ElevatedButton(
//                                           onPressed: () {
//                                             showDialog(
//                                                 context: context,
//                                                 builder: (context) {
//                                                   return AlertDialog(
//                                                     title: const Text(
//                                                         'Delete Product'),
//                                                     content: const Text(
//                                                         'Are you sure?'),
//                                                     actions: [
//                                                       TextButton(
//                                                           onPressed: () {
//                                                             cab_id = snapshot
//                                                                 .data[
//                                                             index]
//                                                             [
//                                                             'cab_id'];
//                                                             deleteData();
//                                                           },
//                                                           child:
//                                                           const Text(
//                                                               'Yes')),
//                                                       TextButton(
//                                                           onPressed: () {
//                                                             Navigator.pop(
//                                                                 context);
//                                                           },
//                                                           child:
//                                                           const Text(
//                                                               'No')),
//                                                     ],
//                                                   );
//                                                 });
//                                           },
//                                           child: const Text('Delete')),
//                                     ],
//                                   ),
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               );
//             }),
//       ),
//     );
//   }
// }
