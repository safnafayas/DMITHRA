import 'package:flutter/material.dart';

import 'OrganisationLogin.dart';
import 'SponsorLogin.dart';
import 'UserloginPage.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Stack(
                    // alignment: Alignment(200,200),
                    children:[ Center(
                      child: Container(

                        height:400,
                        width: 400,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          image: DecorationImage(

                              fit: BoxFit.fill,
                              image:

                          AssetImage('assets/Images/Rectangle 44.png')),

                        ),
                      ),
                    ),
                      Positioned(
                        top: 260,
                        left:115,
                        child: Container(
                          height: 40,
                          width: 200,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image:

                                  AssetImage('assets/Images/DMITHRA.png'))
                          ),

                        ),
                      )
                     ],
                  ),
                  SizedBox(height:10),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>UserLoginPage()));
                    },
                    child: Container(

                      decoration: BoxDecoration(
                        color: Color.fromARGB( 200,61,193,235,),
                        borderRadius:BorderRadius.all(Radius.circular(100))
                      ),
                      height: 50,
                      width: 200,
                      child: Center(child: Text('User',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800,fontSize: 25),)),
                    ),
                  ),
                  SizedBox(height: 30,),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SponsorLoginPage()));

                    },
                    child: Container(

                      decoration: BoxDecoration(
                        color: Color.fromARGB( 200,61,193,235,),
                        borderRadius:BorderRadius.all(Radius.circular(100))
                      ),
                      height: 50,
                      width: 200,
                      child: Center(child: Text('Sponser',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800,fontSize: 25),)),
                    ),
                  ),
                  SizedBox(height: 30,),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>OrgLoginPage()));

                    },
                    child: Container(

                      decoration: BoxDecoration(
                        color: Color.fromARGB( 200,61,193,235,),
                        borderRadius:BorderRadius.all(Radius.circular(100))
                      ),
                      height: 50,
                      width: 200,
                      child: Center(child: Text('Organisation',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800,fontSize: 25),)),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
          ),
    );
  }
}
