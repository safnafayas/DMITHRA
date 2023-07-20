import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/material.dart';

import '../connection/connect.dart';
class OrgEntertainment extends StatefulWidget {
  const OrgEntertainment({super.key});

  @override
  State<OrgEntertainment> createState() => _OrgEntertainmentState();
}

class _OrgEntertainmentState extends State<OrgEntertainment> {
  var _subject=TextEditingController();
  var _link =TextEditingController();
  final _formkey = GlobalKey<FormState>();
  Future<void> AddEntertainment() async {
    var data = {
      'caption': _subject.text,
      'link': _link.text
    };
    var response = await post(
        Uri.parse('${Con.url}entr_add.php'),
        body: data);
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);

      if (responseData['result'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Video Added Successfully')),
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
      appBar:AppBar(
          title:Center(child: Text('Add Entertainment Videos')),
          backgroundColor: Colors.white,
          actions:<Widget>[IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none),
          ),
          ]
      ) ,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              SizedBox(height:10,),
              Text('Add Caption For the Video',style: TextStyle(color:Colors.white,fontSize:20,fontWeight: FontWeight.w800),),
              SizedBox(height: 10,),
              TextField(
                controller: _subject,
                keyboardType:TextInputType.text,
                maxLines: 2,
                decoration: InputDecoration(
                  disabledBorder: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Add Video Description',
                ),
              ),
              SizedBox(height: 10,),
              Text('Add Link of the Video',style: TextStyle(color:Colors.white,fontSize:20,fontWeight: FontWeight.w800),),
              SizedBox(height: 10,),

              TextField(
                controller: _link,
                keyboardType:TextInputType.text,
                maxLines: 2,
                decoration: InputDecoration(
                  disabledBorder: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Add Link',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.red),
                        fixedSize: MaterialStateProperty.all<Size>(Size(370, 50)),
                        elevation: MaterialStatePropertyAll(10)

                    ),
                    onPressed: (){

                      if (
                      _link.text.isNotEmpty &&

                          _subject.text.isNotEmpty) {
                        if (_formkey.currentState != null && _formkey.currentState!.validate()) {
                          AddEntertainment();
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('All fields Required')));
                      }






                    }, child: Text('Submit',style: TextStyle(fontWeight: FontWeight.w800,fontSize: 20),)

                ),
              )


            ],
          ),
        ),
      ),

    );
  }
}
