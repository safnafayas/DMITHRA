import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../SharedPreference Use/sharedPrefUse.dart';
import '../../connection/connect.dart';
import 'package:intl/intl.dart';
class AddTextPost extends StatefulWidget {
  const AddTextPost({Key? key}) : super(key: key);

  @override
  _AddTextPostState createState() => _AddTextPostState();
}

class _AddTextPostState extends State<AddTextPost> {
  final TextEditingController _textPost = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
  Future<void> post() async {
    final data = {
      'date': DateFormat('yyyy-MM-dd').format(DateTime.now()),
      'time' :DateFormat('hh:mm a').format(DateTime.now()),
      'login_id' :lgid.toString(),
      'text': _textPost.text
    };

    final response = await http.post(
      Uri.parse('${Con.url}add_post_user.php'),
      body: data,
    );

    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);

      if (responseData['result'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Post Published Successfully')),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to send request')),
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
      appBar: AppBar(
        title: const Center(child: Text('')),
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
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 20,
                  shadowColor: Colors.black,
                  color: Colors.grey[200],
                  child: Container(
                    height: 350,
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Create Post',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 8.0),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          textAlign: TextAlign.start,
                          controller: _textPost,
                          maxLines: 10,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(),
                            hintText: 'Write something here..',
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          children: [
                            const Spacer(),
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState?.validate() == true) {
                                  post();
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('All fields are required'),
                                    ),
                                  );
                                }
                              },
                              child: const Text('Publish'),
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
      ),
    );
  }
}
