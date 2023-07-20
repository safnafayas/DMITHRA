// import 'package:dymithranew/DYMITHRI/profile.dart';
// import 'package:flutter/material.dart';
//
// import '../DIFF ABLED/DonateSubPages/AccessoriesRequest.dart';
// import '../DIFF ABLED/DonateSubPages/FoodRequestPage.dart';
// import '../DIFF ABLED/DonateSubPages/FundRequest.dart';
// import '../DIFF ABLED/DonateSubPages/MedicineRequest.dart';
// import 'disabled.dart';
// import 'entertainment.dart';
//
// class IndexPageDym extends StatefulWidget {
//   const IndexPageDym({Key? key}) : super(key: key);
//
//   @override
//   _IndexPageDymState createState() => _IndexPageDymState();
// }
//
// class _IndexPageDymState extends State<IndexPageDym> {
//   var _selectedindex = 0;
//
//   final List<Widget> _pages = [
//     DisabledPage(),
//     Container(), // Placeholder for dialog content
//     EntertainmentPage(),
//     ProfilePage(),
//   ];
//
//   Future<void> _openDialog() async {
//     await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Choose from requests'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ListTile(
//                 title: Text('Money Requests'),
//                 onTap: () {
//                   Navigator.of(context).pop();
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => FundRequest()),
//                   );
//                 },
//               ),
//
//               ListTile(
//                 title: Text('Food Requests'),
//                 onTap: () {
//                   Navigator.of(context).pop();
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => RequestPage()),
//                   );
//                 },
//               ),
//               ListTile(
//                 title: Text('Cloth Requests'),
//                 onTap: () {
//                   Navigator.of(context).pop();
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) =>ClothRequest()),
//                   );
//                 },
//               ),
//               ListTile(
//                 title: Text('Accessories Requests'),
//                 onTap: () {
//                   Navigator.of(context).pop();
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => AccessoriesRequest()),
//                   );
//                 },
//               ),
//               ListTile(
//                 title: Text('Other Requests'),
//                 onTap: () {
//                   Navigator.of(context).pop();
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) =>MedicineRequest()),
//                   );
//                 },
//               ),
//
//               // Add more options as needed
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages.elementAt(_selectedindex),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedindex,
//         selectedItemColor: Colors.black,
//         unselectedItemColor: Colors.grey,
//         onTap: (index) {
//           if (index == 1) {
//             _openDialog(); // Show dialog for index 1 (Requests)
//           } else {
//             setState(() {
//               _selectedindex = index;
//             });
//           }
//         },
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.request_page),
//             label: 'Requests',
//           ),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.movie_outlined), label: 'Entertainment'),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
//         ],
//       ),
//     );
//   }
// }
