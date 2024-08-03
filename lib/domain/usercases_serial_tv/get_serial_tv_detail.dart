import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities_serial_tv/serial_tv_detail.dart';
import 'package:ditonton/domain/repositories_serial_tv/serial_tv_repository.dart';

class GetSerialTvDetail {
  final SerialTvRepository repository;

  GetSerialTvDetail(this.repository);

  Future<Either<Failure, SerialTvDetail>> excute(int id) {
    return repository.getSerialTvDetail(id);
  }
}
