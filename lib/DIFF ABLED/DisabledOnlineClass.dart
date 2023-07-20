import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart';
import '../connection/connect.dart';


class DisabledOnlineClass extends StatefulWidget {
  const DisabledOnlineClass({Key? key}) : super(key: key);

  @override
  State<DisabledOnlineClass> createState() => _DisabledOnlineClassState();
}

class _DisabledOnlineClassState extends State<DisabledOnlineClass> {






  Future<void> launchYouTubeVideo(String videoUrl) async {
    if (await canLaunchUrl(Uri.parse(videoUrl))) {
      await launchUrl(Uri.parse(videoUrl));
    } else {
      throw 'Could not launch $videoUrl';
    }
  }

  Future<List<dynamic>> getdata() async {
    var flag;
    var response =
    await get(Uri.parse('${Con.url}/views/view_online_class.php'));
    print(response.body);
    var res2 = jsonDecode(response.body)[0]['result'];
    print('result is: $res2');
    res2 == "success" ? flag = 1 : flag = 0;
    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            stretch: true,
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
          FutureBuilder(
            future: getdata(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (snapshot.hasError) {
                return SliverFillRemaining(
                  child: Center(
                    child: Text('Error: ${snapshot.error}'),
                  ),
                );
              } else {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.white70,
                        child: ListTile(
                          leading: Icon(Icons.video_collection),
                          title: Text(snapshot.data![index]['Caption']),
                          subtitle: InkWell(
                            onTap: () {
                              String youtubeVideoUrl =
                              snapshot.data![index]['Link'].toString();
                              launchYouTubeVideo('https://www.youtube.com/watch?v=sSiA25XlG_A');
                            },
                            child: Text('Click here to watch'),
                          ),
                        ),
                      ),
                    ),
                    childCount: snapshot.data!.length,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
