import 'package:biolo_app/layers/domain/entities/usuario_entity.dart';

class UserDto extends UserEntity {
  UserDto({
    int? id,
    required String nome,
    required String number,
    required String email,
    required String senha,
    required String tipoUsuario,
  }) : super(
          id: id,
          number: number,
          nome: nome,
          email: email,
          senha: senha,
          tipoUsuario: tipoUsuario,
        );


  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      id: json["id"],
      number: json["number"],
      nome: json["nome"],
      email: json["email"],
      senha: json["senha"],
      tipoUsuario: json["tipoUsuario"],
    );
  }

  factory UserDto.fromEntity(UserEntity entity) {
    return UserDto(
      id: entity.id,
      number: entity.number,
      nome: entity.nome,
      email: entity.email,
      senha: entity.senha,
      tipoUsuario: entity.tipoUsuario,
    );
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "number": number,
      "nome": nome,
      "email": email,
      "senha": senha,
      "tipoUsuario": tipoUsuario,
    };
  }

  @override
  String toString() {
    return 'UserDto{id: $id, nome: $nome, email: $email, senha: $senha, tipoUsuario: $tipoUsuario}';
  }

  void login() {
    if (nome.isEmpty || senha.isEmpty) {
      throw Exception('Nome e senha não podem estar vazios');
    }
    print('User $nome login sucesso ');
  }
}
