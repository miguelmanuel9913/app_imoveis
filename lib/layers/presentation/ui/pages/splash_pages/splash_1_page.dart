import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

import 'next_splash_2.dart';

class Splash1Page extends StatefulWidget {
  const Splash1Page({super.key});

  @override
  State<Splash1Page> createState() => _Splash1PageState();
}


class _Splash1PageState extends State<Splash1Page> {


  @override
  void initState() {
    
    super.initState();

//   Future.delayed(Duration(seconds: 2)).then((value){
// Navigator.of(context).pushReplacementNamed((""));

//   });
  }
  @override
  Widget build(BuildContext context) {
   return  AnimatedSplashScreen(
   
    animationDuration: const Duration(seconds: 5),
  splash: Expanded(
    child: SizedBox(
           height: double.infinity,
           width: double.infinity,
           
             child: Image(
               image: AssetImage(
                 
                 "assets/img/logo.png",
                 
               ),fit: BoxFit.cover,
               
            
               
             )),
  ),

   nextScreen:
   
  const   SplasHouseTheme(),
     curve: Curves.bounceIn,
   splashIconSize: 400,
    );
  }
}