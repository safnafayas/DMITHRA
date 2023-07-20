import 'package:flutter/material.dart';

import '../DIFF ABLED/DisabledOrganisation.dart';
import '../DIFF ABLED/SHOPPING/DisabledShopping.dart';
import '../DYMITHRI/Firstpage.dart';
import '../DYMITHRI/ModelsDymithri/FigmaIcons.dart';
import 'Requests/Typesof Request.dart';
import 'ViewPosts.dart';

class SponsorHome extends StatelessWidget {
  const SponsorHome({Key? key}) : super(key: key);

  void handleMenuSelection(BuildContext context, String value) {
    switch (value) {
      case 'Logout':
         Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>FirstPage()));
         break;
    }
  }

  void handleGridItemTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AllRequests()),
        );
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
          MaterialPageRoute(builder: (context) => ViewPost()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DisabledOrganisation()),
        );
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
            backgroundColor: Colors.white,
            title: Center(child: Text('Home')),
            actions: <Widget>[
              PopupMenuButton<String>(
                onSelected: (value) => handleMenuSelection(context, value),
                itemBuilder: (BuildContext context) {
                  return ['Logout'].map((choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
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
                            height: MediaQuery.of(context).size.height,
                            child: GridView.builder(
                              itemCount: figmaiconssponsor.length,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                              ),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    handleGridItemTap(context, index);
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
                                          Image(
                                            height: 50,
                                            width: 50,
                                            image: figmaiconssponsor[index]['icons'],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              figmaiconssponsor[index]['name'],
                                              style: TextStyle(color: Colors.cyan),
                                            ),
                                          ),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
