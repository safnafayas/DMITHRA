import 'dart:convert';
import 'package:dymithranew/UserNotifications/RequestHelpNotification.dart';
import 'package:dymithranew/UserNotifications/ShoppingUserNotifi.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';
import '../DIFF ABLED/ADDPOSTSUBPAGES/AddImagePOST.dart';
import '../DIFF ABLED/ADDPOSTSUBPAGES/AddTEXTpost.dart';
import 'package:http/http.dart' as http;
import '../DIFF ABLED/DisabledEntertainment.dart';
import '../DIFF ABLED/DisabledOnlineClass.dart';
import '../DIFF ABLED/DisabledOrganisation.dart';
import '../DIFF ABLED/SHOPPING/DisabledShopping.dart';
import '../DIFF ABLED/disableddonate.dart';
import '../SharedPreference Use/sharedPrefUse.dart';
import '../connection/connect.dart';
import 'Firstpage.dart';
import 'ModelsDymithri/FigmaIcons.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class DisabledPage extends StatefulWidget {
  const DisabledPage({Key? key});

  @override
  State<DisabledPage> createState() => _DisabledPageState();
}

class _DisabledPageState extends State<DisabledPage> {
  File? _image;
  final picker = ImagePicker();
  var _nameController = TextEditingController();
  var _selectedindex = 0;
  var flag = 0;
  var lgid;

  @override
  void initState() {
    super.initState();
    myLogin();
  }


  Future<Map<String, dynamic>?> getData() async {
    var response = await post(
      Uri.parse('${Con.url}checkudidupload.php'),
      body: {'login_id': lgid.toString()},
    );

    var responseData = response.body;
    print(response.body);
    var decodedData = jsonDecode(responseData);
    print(response.body);
    return decodedData;
  }

  Future<void> myLogin() async {
    lgid = await getSavedData();
    print('loginid: $lgid');
  }

  Future<bool> checkImageField() async {
    var responseData = await getData();
    if (responseData != null) {
      var image = responseData['image'].toString();
      if (image != null && image.isNotEmpty) {
        // UDID card has been uploaded
        return true;
      } else {
        // UDID card is missing
        return false;
      }
    } else {
      // Handle the case when responseData is null
      return false;
    }

  }
  Future<void> chooseImage() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }
  Future<void> upload(File imageFile) async {
    var uri = Uri.parse('${Con.url}uploadUDID.php');
    var request = http.MultipartRequest('POST', uri);
    request.fields['login_id'] = lgid.toString();

    var pic = await http.MultipartFile.fromPath('image',imageFile.path);
    request.files.add(pic);
    var response = await request.send();

    if (response.statusCode == 200) {
      var responseData = await response.stream.transform(utf8.decoder).join();
      var jsonData = jsonDecode(responseData);
      if (jsonData['result'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('UDID uploaded Successfully')),
        );
        Navigator.pop(context);
      } else {
        print('Upload failed');
      }
    }
  }

  void navigateToPage(String value) async {
    switch (value) {
      case 'option1':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RequestHelpNotifi()),
        );
        break;
      case 'option2':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ShoppingNotification()),
        );
        break;
      case 'option3':
        SharedPreferences.getInstance().then((prefs) {
          prefs.remove('lgid');
        });

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => FirstPage()),
        );

        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            stretch: true,
            title: Center(child: Text('Home Page')),
            backgroundColor: Colors.white,
            actions: <Widget>[
              PopupMenuButton<String>(
                onSelected: (value) {
                  // Handle menu item selection
                  print('Selected: $value');
                  navigateToPage(value);
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: 'option1',
                    child: Text('Accepted Requests'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'option2',
                    child: Text('Confirmed Product Orders'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'option3',
                    child: Text('Log Out'),
                  ),
                ],
                icon: const Icon(Icons.more_vert),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 180,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(60)),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/Images/Rectangle 11.png'),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height - 380,
                        child: GridView.builder(
                          itemCount: figmaicons.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                switch (index) {
                                  case 0:
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => DisableDonate()),
                                    );
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('Check Dialogue'),
                                        content: const Text('Have you uploaded your UDID Card?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Check'),
                                          ),
                                        ],
                                      ),
                                    ).then((_) {
                                      // After the dialog is closed, check if the UDID card is uploaded
                                      checkImageField().then((isUploaded) {
                                        if (isUploaded) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text('UDID card has already uploaded'),
                                            ),
                                          );
                                        } else {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: const Text('Check Dialogue'),
                                              content: const Text('Ulpoad Your UDID Card!'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    chooseImage();
                                                  },
                                                  child: const Text('Check'),
                                                ),
                                              ],
                                            ),

                                          );
                                        }
                                      });
                                    });
                                    break;
                                  case 1:
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => ShoppingCart()),
                                    );
                                    break;
                                  case 2:
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => DisabledOnlineClass()),
                                    );
                                    break;
                                  case 3:
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => DisabledEntertainment()),
                                    );
                                    break;
                                  case 4:
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => DisabledOrganisation()),
                                    );
                                    break;
                                  case 5:
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('Which type of post are you planning?'),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            ListTile(
                                              title: const Text('Text Post'),
                                              onTap: () {
                                                Navigator.of(context).pop();
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(builder: (context) => AddTextPost()),
                                                );
                                              },
                                            ),
                                            ListTile(
                                              title: const Text('Text/Image Post'),
                                              onTap: () {
                                                Navigator.of(context).pop();
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(builder: (context) => AddImagePost()),
                                                );
                                              },
                                            ),
                                            // Add more options as needed
                                          ],
                                        ),
                                      ),
                                    );
                                    break;
                                  default:
                                    break;
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Container(
                                  color: Colors.white,
                                  height: 80,
                                  width: 80,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Image(image: figmaicons[index]['icons']),
                                      Text(figmaicons[index]['name'], selectionColor: Colors.cyan),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
