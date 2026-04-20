import 'package:biolo_app/layers/data/dto/casa_dto.dart';
import 'package:biolo_app/layers/domain/entities/casa_entity.dart';

abstract class BuscarCasaDatasource {

 CasaDto call(CasaEntity casa);




}