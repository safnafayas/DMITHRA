import 'package:flutter/material.dart';

List<Map<String,dynamic>>foodReq=[{
  'image':AssetImage('assets/Images/download (1).jpeg'),
  'Description':'Your added description here',
  'Type': 'Veg',
  'PendingButton':TextButton(onPressed: (){},child: Text('Pending',style: TextStyle(color: Colors.blue
  ),),),
  'Accept Button':ElevatedButton(onPressed: (){}, child:Text('Accept')),
  'Contact Details':'Name,number,Address',

},{
  'image':AssetImage('assets/Images/download (1).jpeg'),
  'Description':'Your added description here',
  'Type': 'Veg',
  'Pending Button':TextButton(onPressed: (){},child: Text('Pending',style:TextStyle(color:Colors.blue),),),
   'Accept Button':ElevatedButton(onPressed: (){}, child:Text('Accept')),
   'Reject Button':ElevatedButton(onPressed: (){}, child:Text('Reject')),
  'Contact Details':'Name,number,Address',

},
];
List<Map<String,dynamic>>fundReq=[
  {
  'image': AssetImage('assets/Images/donation-charity.jpg'),
    'Amount':'5000',
    'Description':'For medicinal purchase',
    'Note':'Contact Organisation'
   },
  {
  'image': AssetImage('assets/Images/donation-charity.jpg'),
    'Amount':'5000',
    'Description':'For medicinal purchase',
    'Note':'Contact Organisation ',
   },

];