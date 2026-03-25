import 'dart:convert';

import 'package:biolo_app/layers/data/datasources/local/buscar_casa_local_datasource_imp.dart';
import 'package:biolo_app/layers/data/datasources/salvar_usuario_datasource.dart';
import 'package:biolo_app/layers/data/dto/user_dto.dart';
import 'package:biolo_app/layers/domain/entities/cliente_entity.dart';
import 'package:biolo_app/layers/domain/entities/usuario_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'buscar_user_local_datasource_imp.dart';

class SalvarUsuarioLocalDatasourceImp implements SalvarUsuarioDatasource {
  @override
  Future<bool> call(UserEntity userEntity) async {
    try {
      final prefrs = await SharedPreferences.getInstance();

      final listsUser = await BuscarUserLocalDatasourceImp.carregarUser();

      final existeId = listsUser.any((ul) => ul.id == userEntity.id);

      if (!existeId) {
        listsUser.add(UserDto.fromEntity(userEntity));
      }

      final jsonList = listsUser.map((e) => e.toJson()).toList();
      await prefrs.setString('usuario', jsonEncode(jsonList));

      return true;
    } catch (e) {
      print("erro ao salvar usuario");
      return false;
    }
  }
}
