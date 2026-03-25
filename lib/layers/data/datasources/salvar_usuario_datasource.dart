import 'package:biolo_app/layers/data/dto/user_dto.dart';
import 'package:biolo_app/layers/domain/entities/cliente_entity.dart';

abstract class SalvarUsuarioDatasource {

  Future<bool> call(UserDto UserDto);
}