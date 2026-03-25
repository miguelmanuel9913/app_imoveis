  
import 'package:biolo_app/layers/domain/entities/casa_entity.dart';

import '../../../../data/dto/casa_dto.dart';

import '../../../../domain/usecases/buscar_casa/buscar_casa_usecase.dart';


class CadCasaController {

  final BuscarCasaUsecase buscarCasaUsecase;


   CadCasaController(this.buscarCasaUsecase, 
   
   )

{
    buscarcasaMethod(CasaEntity() );
  }
  
  

late CasaDto buscarCasa;

 

  buscarcasaMethod (CasaEntity casa) {

    
 buscarCasa=  buscarCasaUsecase(casa);
  }
  // salvarCasa (CasaDto casa) async{
  //   var salvarcasa= await salvarCasaFavoritoUsecase(casa);
  //   salvarcasa;
  // }

}