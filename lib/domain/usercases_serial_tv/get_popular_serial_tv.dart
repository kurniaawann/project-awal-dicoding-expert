import 'package:dartz/dartz.dart';

import 'package:ditonton/domain/entities_serial_tv/serial_tv.dart';

import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/repositories_serial_tv/serial_tv_repository.dart';

class GetPopularSerialTv {
  final SerialTvRepository repository;
  GetPopularSerialTv(this.repository);

  Future<Either<Failure, List<SerialTv>>> execute() {
    return repository.getPopularSerialTv();
  }
}
