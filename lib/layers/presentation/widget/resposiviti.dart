
import 'package:flutter/material.dart';

class Resposividade {


  bool isMobile(context) {
    return MediaQuery.of(context).size.width < 600;
  }
  
  isTablet(context) {
    return MediaQuery.of(context).size.width >= 600 &&
        MediaQuery.of(context).size.width < 1200;
  }
  //  isDesktop(context) {
  //   return MediaQuery.of(context).size.width >= 1200;

  //    } 
}



// 13 e 15 elitebook

// 14 16 17 probook