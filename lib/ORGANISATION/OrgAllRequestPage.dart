import 'package:flutter/material.dart';

import '../SPONSER/Requests/Requestedhelps.dart';




class AllRequestsPage extends StatefulWidget {
  const AllRequestsPage({Key? key,}):super(key: key);

  @override
  State<AllRequestsPage> createState() => _AllRequestsPageState();
}

class _AllRequestsPageState extends State<AllRequestsPage> {
  String? type;
  List<String> _pages = ['Fund Requests', 'Food Requests', 'Cloth Requests', 'Accessories Requests', 'Medicine Requests', 'Other Requests'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [

          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return Card(
                  elevation: 10,
                  child: InkWell(
                    onTap: (){
                      switch (index) {
                        case 0:
                          type='money';
                          break;
                        case 1: type='food';

                        break;
                        case 2:type='clothes';

                        break;
                        case 3: type='accessories';

                        break;
                        case 4:type='medicine';

                        break;
                        case 5:   type='others';

                        break;
                      }
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AccessoriesRequested(
                        type:type,
                      )));
                    },
                    child: SizedBox(
                      height: 70,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: Colors.white,
                          child: ListTile(
                            title: Text(_pages[index]),
                            // Add more widgets or customize the list item here
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              childCount: _pages.length,
            ),
          ),
        ],
      ),
    );
  }
}
