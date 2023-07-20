import 'package:flutter/material.dart';

import 'ModelsDymithri/FigmaIcons.dart';
class DisabledPage extends StatefulWidget {
  const DisabledPage({super.key});

  @override
  State<DisabledPage> createState() => _DisabledPageState();
}

class _DisabledPageState extends State<DisabledPage> {
  var _nameContoller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            stretch: true,
            backgroundColor: Colors.white,

            actions:<Widget>[
              // IconButton(
              //   onPressed:(){},
              //   icon:Icon(Icons.search),
              //
              // ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(onPressed: (){}, icon:const Icon(Icons.notifications_none)),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Container(
              height:MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color:const Color.fromRGBO(56,129,139, 100),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextField(
                      controller:_nameContoller,
                      keyboardType: TextInputType.text,

                      decoration: const InputDecoration(
                        enabledBorder:OutlineInputBorder(borderSide:BorderSide(color: Colors.white),borderRadius: BorderRadius.all(Radius.circular(30))),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30)),borderSide:BorderSide(color: Colors.white)),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon:Icon( Icons.search),
                        label: Text('Search Here'),
                      ),

                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(

                      height:150,

                      width:MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(60)),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image:AssetImage('assets/Images/Rectangle 11.png'))
                      ),
                    ),
                  ),

                  Expanded(
                    child: GridView.builder(

                        itemCount: figmaicons.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), itemBuilder:(context,index)

                    {
                      return Padding(
                        padding: const EdgeInsets.only(left: 20,bottom: 20,right: 20,top:20),
                        child: Container(
                          color: Colors.white,

                          height: 80,
                          width: 80,
                          child:Image(image:figmaicons[index]['icons']),


                        ),
                      );
                    }),
                  ),

                ],
              ),
            ),
          )

        ],


      ),
    );


  }
}
