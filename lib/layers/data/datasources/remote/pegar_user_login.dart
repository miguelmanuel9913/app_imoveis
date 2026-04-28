// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:biolo_app/layers/data/datasources/remote/dio.dart';
import 'package:dio/dio.dart';
import '../../dto/user_dto.dart';

class PegarUserLogin {
  final DioUrls dioUrls;
  PegarUserLogin({
    required this.dioUrls,
  });

  Future<Map<String, dynamic>> apiLoginUser(
    String login,
    String senha, {
    String? authorizationToken,
  }) async {
    try {
      print('[LOGIN] Iniciando requisição');
      print('[LOGIN] URL base: ${dioUrls.dio.options.baseUrl}');
      print('[LOGIN] login="$login" senha.length=${senha.length}');

      final options = Options(
        headers: {
          if (authorizationToken != null && authorizationToken.isNotEmpty)
            'Authorization': 'Bearer $authorizationToken',
        },
        contentType: Headers.jsonContentType,
      );

      final response = await dioUrls.dio.post(
        'Api/auth',
        data: {
          'loginUser': login,
          'password': senha,
        },
        options: options,
      );

      print('[LOGIN] Status: ${response.statusCode}');
      print('[LOGIN] Response type: ${response.data.runtimeType}');
      print('[LOGIN] Response body: ${response.data}');
      print('[LOGIN] URL chamada: ${dioUrls.dio.options.baseUrl}Api/auth');

      final statusCode = response.statusCode ?? 0;

      if (statusCode < 200 || statusCode >= 300) {
        print('[LOGIN][ERRO] Status inválido: $statusCode');
        throw Exception("Erro ao fazer login $statusCode");
      }

      final rawData = response.data;
      final Map<String, dynamic> data = rawData is Map
          ? Map<String, dynamic>.from(rawData as Map)
          : <String, dynamic>{};

      final tokenValue = data['token'];
      final token = tokenValue is Map
          ? '${tokenValue['token'] ?? ''}'
          : '${tokenValue ?? ''}';

      final rawUser = data['user'] ?? data['usuario'] ?? data['userData'];
      final Map<String, dynamic> userMap = rawUser is Map
          ? Map<String, dynamic>.from(rawUser as Map)
          : <String, dynamic>{};

      final userDto = UserDto(
        id: userMap['idUser'] is int
            ? userMap['idUser'] as int
            : int.tryParse('${userMap['idUser'] ?? userMap['id'] ?? ''}'),
        nome: '${userMap['nomeUser'] ?? userMap['nome'] ?? ''}',
        number: '${userMap['numberUser'] ?? userMap['number'] ?? ''}',
        email: '${userMap['emailUser'] ?? userMap['email'] ?? ''}',
        senha: '',
        tipoUsuario: '${userMap['tipoUser'] ?? userMap['tipoUsuario'] ?? ''}',
      );

      print('[LOGIN] Token extraído: $token');
      print('[LOGIN] User extraído: $userDto');

      return {'token': token, 'user': userDto};
    } catch (e, s) {
      print('[LOGIN][ERRO] $e');
      print('[LOGIN][STACK] $s');
      throw Exception("Erro ao fazer login $e");
    }
  }
}
