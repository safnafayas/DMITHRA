import 'dart:convert';
import 'dart:io';
import 'package:dymithranew/SharedPreference%20Use/sharedPrefUse.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../../connection/connect.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AddImagePost extends StatefulWidget {
  const AddImagePost({Key? key});

  @override
  State<AddImagePost> createState() => _AddImagePostState();
}

class _AddImagePostState extends State<AddImagePost> {

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


  var _text = TextEditingController();
  File? _image;
  final picker = ImagePicker();

  Future<void> chooseImage() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  Future<void> upload(File imageFile) async {
    var uri = Uri.parse('${Con.url}add_post_user.php');
    var request = http.MultipartRequest('POST', uri);
    request.fields['text'] = _text.text;
    request.fields['date'] = DateFormat('yyyy-MM-dd').format(DateTime.now());
    request.fields['time'] = DateFormat('hh:mm a').format(DateTime.now());
    request.fields['login_id'] = lgid.toString();


    var pic = await http.MultipartFile.fromPath('image', imageFile.path);
    request.files.add(pic);
    var response = await request.send();

    if (response.statusCode == 200) {
      print('Image uploaded');
      var responseData = await response.stream.transform(utf8.decoder).join();
      var jsonData = jsonDecode(responseData);
      if (jsonData['result'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Posted Successfully')),
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
      appBar: AppBar(
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 20,
                shadowColor: Colors.black,
                surfaceTintColor: Colors.grey,
                child: Container(
                  height: 350,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Create Post',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, bottom: 8.0, left: 15, right: 15),
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    child: (_image != null) ?Image.file(_image!,fit:BoxFit.cover,):IconButton(
                                      onPressed: () {
                                        chooseImage();
                                      },

                                      icon: Icon(Icons.add_a_photo),
                                    ),
                                    height: 150,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(

                                     border: Border.all(color: Colors.black),
                                   ),

                                  ),

                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, bottom: 8.0, left: 15, right: 15),
                        child: TextField(
                          keyboardType: TextInputType.text,
                          textAlign: TextAlign.start,
                          controller: _text,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            disabledBorder: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(),
                            hintText: 'Write something here..',
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(width: 260),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () {
                                if (_image != null) {
                                  upload(_image!);
                                }
                              },
                              child: Text('Publish'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
