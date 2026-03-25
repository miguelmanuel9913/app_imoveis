import 'package:flutter/material.dart';

class OneIndicator extends StatelessWidget {
  const OneIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return 
      Stack(
      children:  [
        
  
           Container(
            margin:const EdgeInsets.only(top: 180 , right: 50) ,
            height: 625,
            alignment: Alignment.bottomRight,
             child: Image(
               image: AssetImage(
                 
                 "assets/img/img_splash/fundo.png",
                 
               ),fit: BoxFit.cover,
               
                          
               
             ),
           ),
         Column(
        children: [
          // imagem da casa entrada
          

// Texto

SizedBox(height: 40,),
             Padding(
               padding: EdgeInsets.all(8.0),
               child: Text(
                           "Sua nova casa te espera! Conforto, segurança e qualidade de vida em um só lugar. Venha conhecer",
                           style: TextStyle( fontSize: 14,fontWeight: FontWeight.bold, ),
                           textAlign:TextAlign.start,
                         ),
             ),
             
// SizedBox(height: 445,),
            
//               Container(
//         decoration: BoxDecoration(
//            color: const Color.fromARGB(255, 172, 165, 141),
//         ),
//                 alignment: Alignment.topRight,
//                 width: 100,
//                 height: 100,
               
//                 )
        ],
      ),
   ] );
  }
}
   