import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../SharedPreference Use/sharedPrefUse.dart';
import '../../connection/connect.dart';
import '../disableddonate.dart';
import 'package:intl/intl.dart';
class ClothesDonate extends StatefulWidget {

  const ClothesDonate({super.key});

  @override
  State<ClothesDonate> createState() => _ClothesDonateState();
}

class _ClothesDonateState extends State<ClothesDonate> {
  var _description=TextEditingController();

  var _contactname=TextEditingController();
  var _contactaddress=TextEditingController();
  var _contactnumber=TextEditingController();
  final _formkey=GlobalKey<FormState>();
  var lgid;
  var req_id;
  @override
  void initState(){
    super.initState();
    mylogin();

  }
  Future<void> mylogin() async{
    lgid = await getSavedData();
    print('loginid:$lgid');
  }
  Future<void> clothesRequest() async {
   var data={
     'contact_address':_contactaddress.text,
     'description':_description.text,
     'contact_number': _contactnumber.text,
     'contact_name': _contactname.text,
     'type': 'clothes',
     'login_id':lgid.toString(),
     'date': DateFormat('yyyy-MM-dd').format(DateTime.now()),

   };
   var response = await post(
       Uri.parse('${Con.url}request.php'),
       body: data);
   print(response.body);
   print(response.statusCode);
   if (response.statusCode == 200) {
     var responseData = jsonDecode(response.body);

     if (responseData['result'] == 'success') {
       req_id=jsonDecode(response.body)['req_id'].toString();
       print(req_id);
       saveReq(req_id);
       ScaffoldMessenger.of(context).showSnackBar(
         const SnackBar(content: Text('Request send Successfully')),
       );
       Navigator.pop(context);
     } else {
       ScaffoldMessenger.of(context).showSnackBar(
         const SnackBar(content: Text('Failed to register')),
       );
       Navigator.pop(context);
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
      backgroundColor: Colors.white,
      appBar:AppBar(
        title: Center(child: Text('Request Cloth')),
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
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(

              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0,right: 20.0,top:30),
                  child: Container(

                    height:200,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(60)),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image:AssetImage('assets/Images/Rectangle 87 (1).jpg'))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('Cloth Description',style: TextStyle(fontSize:23,fontWeight: FontWeight.w800),),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 25,right: 25,bottom: 5,top:10),
                  child: TextField(
                    controller: _description,
                    keyboardType: TextInputType.text,
                    maxLines: 6,

                    decoration: InputDecoration(
                      label:Text(
                          'Add quantity of needed(in terms of clothes for number of persons) . Add Size and type of the items needed(Eg:size: M,Type:jeans pant) & Mention if any special requirements needed.. ',textAlign: TextAlign.start),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color:Color.fromARGB( 200,61,193,235,)),),
                      filled:true,
                      fillColor:Colors.white,
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:Color.fromARGB( 200,61,193,235,) )),
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 25,right: 25,bottom: 5,top:5),
                //   child: TextField(
                //     controller: dateInput,
                //     decoration: InputDecoration(
                //       disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30)),
                //         borderSide: BorderSide(color:Color.fromARGB( 200,61,193,235,)),),
                //       enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30)),
                //         borderSide: BorderSide(color:Color.fromARGB( 200,61,193,235,)),),
                //       filled:true,
                //       fillColor:Colors.white,
                //       focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:Color.fromARGB( 200,61,193,235,) )),
                //       prefixIcon: Icon(Icons.calendar_month_outlined),
                //       label: Text('Pick Up Date'),
                //     ),
                //     readOnly: true,
                //     onTap: ()async{
                //       DateTime? pickedDate =await showDatePicker(
                //           context: context,
                //           initialDate:DateTime.now(), firstDate:DateTime.now(), lastDate:DateTime(2100) );
                //
                //       if (pickedDate != null) {
                //      print(
                //     pickedDate);
                //
                //      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                //       print(formattedDate); //formatted date output using intl package =>  2021-03-16
                //             setState(() {
                //           dateInput.text =formattedDate; //set output date to TextField value.
                //        });
                //
                //     } else {}
                //     }
                //   ),
                // ), Cc
                // pickup date
                Padding(
                  padding: const EdgeInsets.only(left: 8.0,right: 8,top: 8,bottom: 12),
                  child: Text('Provide Contact details',style: TextStyle(fontSize:23,fontWeight: FontWeight.w800),),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25,right: 25,bottom: 10,top:15),
                  child: TextField(
                    controller: _contactname,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      label:Text('Contact Name',textAlign: TextAlign.start),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color:Color.fromARGB( 200,61,193,235,)),),
                      filled:true,
                      fillColor:Colors.white,
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:Color.fromARGB( 200,61,193,235,) )),
                    ),

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25,right: 25,bottom: 5,top:10),
                  child: TextField(
                    controller: _contactnumber,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      label:Text('Contact Number',textAlign: TextAlign.start),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color:Color.fromARGB( 200,61,193,235,)),),
                      filled:true,
                      fillColor:Colors.white,
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:Color.fromARGB( 200,61,193,235,) )),
                    ),

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25,right: 25,bottom: 5,top:10),
                  child: TextField(
                    maxLines:2,
                    controller: _contactaddress,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      label:Text('Address',textAlign: TextAlign.start),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color:Color.fromARGB( 200,61,193,235,)),),
                      filled:true,
                      fillColor:Colors.white,
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:Color.fromARGB( 200,61,193,235,) )),
                    ),

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:50,bottom: 20,top:20,right: 10),
                  child: InkWell(
                    onTap: (){
                      if (
                          _description.text.isNotEmpty &&
                          _contactaddress.text.isNotEmpty &&
                          _contactname.text.isNotEmpty &&
                          _contactnumber.text.isNotEmpty) {
                        if (_formkey.currentState != null && _formkey.currentState!.validate()) {
                          clothesRequest();
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('All fields Required')));
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color.fromARGB( 200,61,193,235,),
                          borderRadius:BorderRadius.all(Radius.circular(100))
                      ),
                      height: 50,
                      width: 300,
                      child: Center(child: Text('Send Request',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800,fontSize: 25),)),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),



    );
  }
}
