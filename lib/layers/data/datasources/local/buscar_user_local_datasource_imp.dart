import 'dart:convert';

import 'package:biolo_app/layers/data/datasources/buscar_user_datasource.dart';
import 'package:biolo_app/layers/data/datasources/remote/dio.dart';
import 'package:biolo_app/layers/data/dto/user_dto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/entities/usuario_entity.dart';
import 'salvar_usuario_local_datasource_imp.dart';

class BuscarUserLocalDatasourceImp implements BuscarUserDatasource {

  @override
  Future<List<UserDto>> call() async {
    return await carregarUser();
  }

  static Future<List<UserDto>> carregarUser() async {
    final prefrs = await SharedPreferences.getInstance();
    final users = prefrs.getStringList('users') ?? [];
    if (users != null) {
      final decode = jsonDecode(users.toString()) as List;
      return decode.map((e) => UserDto.fromJson(e)).toList();
    }
    return [];
  }

  Future<UserDto> logiUser(String login, String senha) async {
    final users = await carregarUser();
    try {
      final usuario = users.firstWhere(
          (u) => (u.email == login || u.number == login) && u.senha == senha);

      return usuario;
    } catch (erro) {
      throw Exception('Usuário não encontrado');
    }
  }



 }
