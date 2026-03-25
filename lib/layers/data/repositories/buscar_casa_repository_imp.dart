

import 'package:biolo_app/layers/data/datasources/buscar_casa_datasource.dart';
import 'package:biolo_app/layers/domain/entities/casa_entity.dart';

import '../../domain/repositories/buscar_casa_repository.dart';

import '../dto/casa_dto.dart';

  class BuscarCasaRepositoryImp implements BuscarCasaRepository{
   final BuscarCasaDatasource _buscarCasaDatasource;
BuscarCasaRepositoryImp(this._buscarCasaDatasource);
    @override
    CasaDto call(CasaEntity casa) {
      return _buscarCasaDatasource(casa);
    }

  }