import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UserEntity {
  final int? id;
  final String number; 
  final String nome;
  final String email;
  final String senha;
  final String tipoUsuario; // "cliente" ou "proprietario"

  UserEntity({
    this.id,
    required this.number,
    required this.nome,
    required this.email,
    required this.senha,
    required this.tipoUsuario,
  });
  factory UserEntity.fromJson(Map<String , dynamic> json){

    return  UserEntity(
      id: json['idUser'],
      number: json['numberUser'],
      nome:json['nomeUser'] , 
      email:json ['emailuser'], 
      senha: json['senhaUser'], 
      tipoUsuario: json['tipoUser']
      ,
      )
;  }

 Map<String, dynamic> toJson() {

  return{
'idUser':id,
'numberUser':number,
'nomeUser':nome,
'emailuser':email,
'senhaUser':senha,
'tipoUser':tipoUsuario
  };
 }
}
