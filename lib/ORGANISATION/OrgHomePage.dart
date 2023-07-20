import 'package:dymithranew/ORGANISATION/ViewOrders.dart';
import 'package:flutter/material.dart';
import '../DIFF ABLED/DisabledEntertainment.dart';
import '../DIFF ABLED/DisabledOnlineClass.dart';
import '../DIFF ABLED/DisabledOrganisation.dart';
import '../DYMITHRI/ModelsDymithri/FigmaIcons.dart';
import '../SPONSER/ViewPosts.dart';
import 'OrgAddShopping.dart';
import 'OrgAllRequests.dart';
import 'OrgEntertainment.dart';
import 'OrgOnlineClass.dart';
class OrgHomePage extends StatelessWidget {
  const OrgHomePage({super.key});

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
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewOrders()));
                  },
                  icon: const Icon(Icons.notifications_none),
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(height: 20,),
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  // color: const Color.fromRGBO(56, 129, 139, 100),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 150,
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
                            height: MediaQuery.of(context).size.height - 270,
                            child: GridView.builder(

                                itemCount: figmaiconsorg.length,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                ),
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      switch (index) {
                                        case 0:
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>OrgAllRequests()));
                                          break;
                                        case 1:
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>OrgAddShoppingItems()));
                                          break;
                                        case 2:
                                          showDialog(
                                              context: context,
                                              builder: (context) =>AlertDialog(
                                                title: Text('Choose from:'),
                                                content: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    ListTile(
                                                      title: Text('Add Class'),
                                                      onTap: () {
                                                        Navigator.of(context).pop();
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(builder: (context) => OrgOnlineClass()),
                                                        );
                                                      },
                                                    ),
                                                    ListTile(
                                                      title: Text('View Class'),
                                                      onTap: () {
                                                        Navigator.of(context).pop();
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(builder: (context) => DisabledOnlineClass()),
                                                        );
                                                      },
                                                    ),

                                                    // Add more options as needed
                                                  ],
                                                ),
                                              )
                                          );
                                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>DisabledAppPost()));
                                          break;
                                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>OrgOnlineClass()));
                                          break;
                                        case 3:
                                          showDialog(
                                              context: context,
                                              builder: (context) =>AlertDialog(
                                                title: Text('Choose from:'),
                                                content: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    ListTile(
                                                      title: Text('Add Videos'),
                                                      onTap: () {
                                                        Navigator.of(context).pop();
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(builder: (context) => OrgEntertainment()),
                                                        );
                                                      },
                                                    ),
                                                    ListTile(
                                                      title: Text('View Videos'),
                                                      onTap: () {
                                                        Navigator.of(context).pop();
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(builder: (context) => DisabledEntertainment()),
                                                        );
                                                      },
                                                    ),

                                                    // Add more options as needed
                                                  ],
                                                ),
                                              )
                                          );
                                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>OrgEntertainment()));
                                          break;
                                          case 4:
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewPost()));
                                          break;
                                          case 5:
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>DisabledOrganisation()));
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

                                              children:[ Image(
                                                  height: 50,
                                                  width: 50,
                                                  image: figmaiconsorg[index]['icons']),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(figmaiconsorg[index]['name'],selectionColor: Colors.cyan,),
                                                ),

                                              ]
                                          )
                                      ),
                                    ),
                                  );



                                }
                            ),
                          ),

                        ),
                      ),
                      // SizedBox(
                      //   height:100,
                      // )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

    );
  }
}
