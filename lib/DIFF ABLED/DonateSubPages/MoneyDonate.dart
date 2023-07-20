import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../../SharedPreference Use/sharedPrefUse.dart';
import '../../connection/connect.dart';
import 'package:intl/intl.dart';
class MoneyDonate extends StatefulWidget {
  const MoneyDonate({super.key});

  @override
  State<MoneyDonate> createState() => _MoneyDonateState();
}

class _MoneyDonateState extends State<MoneyDonate> {
  var _description=TextEditingController();

  var _amount=TextEditingController();

  final _formkey = GlobalKey<FormState>();
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

  Future<void> fundRequest() async {
    var data = {
      'description': _description.text,
      'amount': _amount.text,
      'type': 'money',
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
        title: Center(child: Text('Request Money')),

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
      body: Form(
        key: _formkey,
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
          child: SingleChildScrollView(
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
                            image:AssetImage('assets/Images/donation-charity.jpg'))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Enter Amount',style: TextStyle(fontSize:23,fontWeight: FontWeight.w800),),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 25,right: 25,bottom: 5,top:10),
                  child: TextField(
                    controller: _amount,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      label:Text('Enter Amount in numbers',textAlign: TextAlign.start),
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
                  padding: const EdgeInsets.only(left: 8.0,right: 8,top: 8,bottom: 12),
                  child: Text('Describe your reasons',style: TextStyle(fontSize:23,fontWeight: FontWeight.w800),),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25,right: 25,bottom: 10,top:15),
                  child: TextField(
                    controller: _description,
                    keyboardType: TextInputType.text,maxLines: 4,
                    decoration: InputDecoration(

                      label:Text('Please explain your reasons or requirements for seeking financial resources.',textAlign: TextAlign.start),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color:Color.fromARGB( 200,61,193,235,)),),
                      filled:true,
                      fillColor:Colors.white,
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:Color.fromARGB( 200,61,193,235,) )),
                    ),

                  ),
                ),
              SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left:50,bottom: 25,top:20,right: 10),
                  child: InkWell(
                    onTap: (){
                      if (
                          _description.text.isNotEmpty &&

                          _amount.text.isNotEmpty) {
                        if (_formkey.currentState != null && _formkey.currentState!.validate()) {
                          fundRequest();
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
