import 'package:biolo_app/layers/domain/entities/usuario_entity.dart';

import '../../entities/cliente_entity.dart';

abstract class SalvarUsuarioNovo {

  Future<bool> call(UserEntity userEntity);
}     