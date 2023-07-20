import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Import http from the http package
import 'package:image_picker/image_picker.dart';
import '../DIFF ABLED/SHOPPING/DisabledShopping.dart';
import '../connection/connect.dart';
import 'package:intl/intl.dart';

class AddShoppingItems extends StatefulWidget {
  const AddShoppingItems({Key? key}) : super(key: key);

  @override
  State<AddShoppingItems> createState() => _AddShoppingItemsState();
}

class _AddShoppingItemsState extends State<AddShoppingItems> {
  var _productname = TextEditingController();
  var _description = TextEditingController();
  var _rate = TextEditingController();
  final _formkey = GlobalKey<FormState>();
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
    var uri = Uri.parse('${Con.url}product_tb.php');
    var request = http.MultipartRequest('POST', uri);
    request.fields['description'] = _description.text;
    request.fields['product_name'] = _productname.text;
    request.fields['rate'] = _rate.text;
    request.fields['status'] = 'available';
    request.fields['created_at'] = DateFormat('yyyy-MM-dd').format(DateTime.now());
    request.fields['modified_at'] = DateFormat('yyyy-MM-dd').format(DateTime.now());

    var pic = await http.MultipartFile.fromPath('image', imageFile.path);
    request.files.add(pic);
    var response = await request.send();

    // Handle the response as needed
    if (response.statusCode == 200) {
      // The request was successful
      var responseData = await response.stream.transform(utf8.decoder).join();
      var jsonData = jsonDecode(responseData);
      if (jsonData['result'] == 'success') {
        // Insertion successful
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Added Successfully')),
        );
        Navigator.pop(context);
      } else {
        // Insertion failed
        print('Upload failed');
      }
    } else {
      // Handle the error case
      print('Error: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Add Items')),
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
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Add Items..',
                    style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.w800),
                  ),
                  TextField(
                    controller: _productname,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      disabledBorder: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Enter Product Name',
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _description,
                    keyboardType: TextInputType.text,
                    maxLines: 4,
                    decoration: InputDecoration(
                      disabledBorder: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Add descriptions',
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Center(
                      child: (_image != null)
                          ? Image.file(_image!, fit: BoxFit.cover)
                          : IconButton(
                        onPressed: chooseImage,
                        icon: Icon(Icons.add_a_photo),
                        iconSize: 50,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _rate,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      disabledBorder: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Add Rate',
                    ),
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      if (_formkey.currentState!.validate()) {
                        upload(_image!); // Assuming _image is required and not null
                      }
                    },
                    child: Container(
                      color: Colors.tealAccent,
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: const Center(
                        child: Text(
                          'Add',
                          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
