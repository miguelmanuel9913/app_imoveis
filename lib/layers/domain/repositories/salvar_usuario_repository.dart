import 'package:biolo_app/layers/domain/entities/cliente_entity.dart';

import '../entities/usuario_entity.dart';

abstract class SalvarUsuarioRepository {

  Future<bool> call(UserEntity clienteEntity);
}