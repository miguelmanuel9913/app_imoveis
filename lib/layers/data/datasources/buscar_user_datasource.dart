import 'package:biolo_app/layers/data/datasources/local/buscar_user_local_datasource_imp.dart';
import 'package:biolo_app/layers/data/dto/user_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dto/user_dto.dart';
import 'salvar_usuario_datasource.dart';

abstract class BuscarUserDatasource {
BuscarUserLocalDatasourceImp _buscarDataSourceImp = BuscarUserLocalDatasourceImp();
    Future<List<UserDto>> call() async {


 
final user= await BuscarUserLocalDatasourceImp().call();
return user;

  }


}