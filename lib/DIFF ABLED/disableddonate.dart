import 'package:flutter/material.dart';


import '../DYMITHRI/ModelsDymithri/FigmaIcons.dart';
import 'DonateSubPages/AccessoriesDonate.dart';
import 'DonateSubPages/ClothesDonate.dart';
import 'DonateSubPages/MedicineDonate.dart';
import 'DonateSubPages/MoneyDonate.dart';
import 'DonateSubPages/OthersInDonate.dart';
import 'DonateSubPages/foodDonatePage.dart';
class DisableDonate extends StatefulWidget {
  const DisableDonate({super.key});

  @override
  State<DisableDonate> createState() => _DisableDonateState();
}

class _DisableDonateState extends State<DisableDonate> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:AppBar(
        title: Center(child: Text('Help Requests')),
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
      body:
      Padding(
        padding: const EdgeInsets.only(top: 60,left:8,right: 8),
        child: Center(
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
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>MoneyDonate()));
                        break;
                      case 1:
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>FoodDonate()));
                        break;
                      case 2:
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ClothesDonate()));
                        break;
                      case 3:
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>AccessoriesDonate()));
                        break;
                      case 4:
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>MedicineDonate()));
                        break;
                      case 5:
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Others()));
                        break;

                    }
                  },


                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                        color: Colors.white,
                        height: 120,
                        width: 120,

                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,

                            children:[ Image(image: figmaIcons2[index]['icons']),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(figmaIcons2[index]['name'],selectionColor: Colors.cyan,style: TextStyle(fontSize: 25),),
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


    );
  }
}
