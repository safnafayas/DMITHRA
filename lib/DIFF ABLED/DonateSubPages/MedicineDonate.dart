import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:intl/intl.dart';


import '../../SharedPreference Use/sharedPrefUse.dart';
import '../../connection/connect.dart';

class MedicineDonate extends StatefulWidget {
  const MedicineDonate({super.key});

  @override
  State<MedicineDonate> createState() => _MedicineDonateState();
}

class _MedicineDonateState extends State<MedicineDonate> {


  File? _image;
  final picker = ImagePicker();
  var _description = TextEditingController();

  var _contactname = TextEditingController();

  var _contactnumber = TextEditingController();
  var _contactaddress = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  var req_id;
  Future<void> chooseImage() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }


  var lgid;
  @override
  void initState(){
    super.initState();
    mylogin();

  }
  Future<void> mylogin() async{
    lgid = await getSavedData();
    print('loginid:$lgid');
  }
  Future<void> upload(File imageFile) async {
    var uri = Uri.parse('${Con.url}request.php');
    var request = http.MultipartRequest('POST', uri);
    request.fields['description'] = _description.text;
    request.fields['contact_name'] = _contactname.text;
    request.fields['contact_address'] = _contactaddress.text;
    request.fields['contact_number'] = _contactnumber.text;
    request.fields['type'] = 'medicine';
    request.fields['login_id'] = lgid.toString();
    request.fields['date'] = DateFormat('yyyy-MM-dd').format(DateTime.now());

    var pic = await http.MultipartFile.fromPath('image', imageFile.path);
    request.files.add(pic);
    var response = await request.send();

    if (response.statusCode == 200) {
      var responseData = await response.stream.transform(utf8.decoder).join();
      var jsonData = jsonDecode(responseData);
      if (jsonData['result'] == 'success') {
        req_id = jsonData['req_id'].toString();
        print(req_id);
        saveReq(req_id);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Request sent Successfully')),
        );
        Navigator.pop(context);
      } else {
        print('Upload failed');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Center(child: Text('Request Medicine')),


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
                            image:AssetImage('assets/Images/Rectangle 87 (2).jpg'))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text('Upload Dr Prescription',style: TextStyle(fontSize:23,fontWeight: FontWeight.w800),),
                      ),
                      ElevatedButton(onPressed: (){
                        chooseImage();
                      }, child: Text('Upload Image'))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text('Medicine Description',style: TextStyle(fontSize:23,fontWeight: FontWeight.w800),),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 25,right: 25,bottom: 5,top:10),
                  child: TextField(
                    controller: _description,
                    keyboardType: TextInputType.text,
                    maxLines: 2,

                    decoration: InputDecoration(
                      label:Text(
                          'Add quantity of needed(in terms of medicine needed for how many days) .',textAlign: TextAlign.start),
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
                  padding: const EdgeInsets.only(left: 18.0,right: 8,top: 8,bottom: 12),
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
                      if (_image != null) {
                        upload(_image!);
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
