import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities_serial_tv/serial_tv.dart';
import 'package:ditonton/domain/repositories_serial_tv/serial_tv_repository.dart';

class GetWatchlistSerialTv {
  final SerialTvRepository _repository;

  GetWatchlistSerialTv(this._repository);

  Future<Either<Failure, List<SerialTv>>> execute() {
    return _repository.getWatchlistSerialTv();
  }
}
