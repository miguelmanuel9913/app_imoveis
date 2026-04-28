import 'dart:convert';

import 'package:biolo_app/layers/data/datasources/remote/dio.dart';
import 'package:biolo_app/layers/data/dto/casa_dto.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class HouseDatasourceApi {
  final Dio _casa = Dio();
  final String url = "/api/registrar/casa";
  late final DioUrls urlsDio;

  Future<String> criarCasaApi(CasaDto casa) async {
    try {
      final jsonData = await casa.toJson();

      final response = await _casa.post(
        url,
        data: jsonData,
        options: Options(headers: {
          'Content-type': 'application/json',
        }),
      );

      print ('response status code: ${response.statusCode}');
      print (urlsDio.dio.options.baseUrl + url);
      if (response.statusCode == 200) {
        print('casa registrada com sucesso');

        return response.data;
      } else {
        print('Erro ao cadastrar');
        print('resposta ${response.statusCode} -  ${response.data} ');
        throw Exception('Falha ao registrar a casa...');
      }
    }catch(e){
      print('falha ao inserir casa');
      throw Exception(e);
    } 
  }
}
