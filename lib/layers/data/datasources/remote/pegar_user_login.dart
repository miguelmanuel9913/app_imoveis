// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:biolo_app/layers/data/datasources/remote/dio.dart';
import 'package:dio/dio.dart';
import '../../dto/user_dto.dart';

class PegarUserLogin {
    DioUrls dioUrls;
  PegarUserLogin({
    required this.dioUrls,
  });

      Future<Map<String, dynamic>> apiLoginUser(String login , String senha, {String? authorizationToken}) async{
try{
final options = Options(
  headers: {
    if (authorizationToken != null && authorizationToken.isNotEmpty)
      'Authorization': 'Bearer $authorizationToken',
  },
  contentType: Headers.jsonContentType,
);
final  response = await dioUrls.dio.post(
  'Api/auth',
  data: {
    'loginUser':login,
    'password':senha
  },
  options: options,
);
  if(response.statusCode == 200){
    final data = response.data as Map<String, dynamic>;
    final tokenObj = data['token'] as Map<String, dynamic>?;
    final token = tokenObj != null ? tokenObj['token'] as String? : null;
    final userMap = (data['user'] as Map<String, dynamic>? ) ?? {};
    final userDto = UserDto(
      id: userMap['idUser'] is int ? userMap['idUser'] as int : int.tryParse('${userMap['idUser'] ?? ''}'),
      nome: '${userMap['nome'] ?? ''}',
      number: '${userMap['number'] ?? ''}',
      email: '${userMap['email'] ?? ''}',
      senha: '',
      tipoUsuario: '${userMap['tipoUser'] ?? ''}',
    );
    return {'token': token ?? '', 'user': userDto};
  }else{
    throw Exception("Erro ao fazer login ${response.statusCode}");
  }
}catch(e){

  throw Exception("Erro ao fazer login $e");
}

}
}
