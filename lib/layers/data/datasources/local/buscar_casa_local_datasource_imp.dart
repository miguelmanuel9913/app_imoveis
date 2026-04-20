import 'package:biolo_app/layers/data/dto/casa_dto.dart';
import 'package:biolo_app/layers/domain/entities/casa_entity.dart';
import '../buscar_casa_datasource.dart';

class BuscarCasaLocalDatasourceImp implements BuscarCasaDatasource {
  static const Map<String, dynamic> jsonCasaPegarTopoo = {
    "endereco": "Nova Vida",
    "topologia": "t4",
    "preco": 250000,
    "descricao": "Casa espaçosa com 4 quartos, ideal para famílias grandes.",
    "favorito": false
  };

  @override
  CasaDto call(CasaEntity casa) {
  
    if (casa !=null) {
      return CasaDto.fromJson(jsonCasaPegarTopoo);
    }
    throw Exception('Casa não encontrada');
  }


  static BuscarCasaLocalDatasourceImp get instance =>
      BuscarCasaLocalDatasourceImp();

      
}
