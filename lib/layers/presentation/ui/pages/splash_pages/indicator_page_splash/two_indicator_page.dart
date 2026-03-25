import 'package:flutter/material.dart';

class TwoIndicator extends StatelessWidget {
  const TwoIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return
    
     Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          // imagem da casa entrada
             Container(

                alignment: Alignment.centerLeft,
           
              child: const Column(
                children: [

                               // Texto 
 Padding(
   padding: EdgeInsets.all(10.0),
   child: Text(
              "Nós entregamos a chave do seu futuro! Sua casa dos sonhos, sem complicação, pronta para você. Entre em contato e comece uma nova história.",
              
              textAlign: TextAlign.start,
              style: TextStyle(  
                letterSpacing: 1, fontSize: 12,fontWeight: FontWeight.bold),
            ),
 ),
                   Padding(
                     padding: EdgeInsets.only(left:31),
                     child: Image(
                      image: AssetImage(
                        "assets/img/casa04.png",
                      ), 
                     
                      height: 370,
                                
                      alignment: Alignment.centerLeft,
                      fit: BoxFit.fitHeight,
                      
                                       ),
                   ),

          
                ],
              )),



    
        ],
      ),
    );
  }
}
    
   