import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities_serial_tv/serial_tv_detail.dart';
import 'package:ditonton/domain/repositories_serial_tv/serial_tv_repository.dart';

class SaveWatchlistSerialTv {
  final SerialTvRepository repository;

  SaveWatchlistSerialTv(this.repository);

  Future<Either<Failure, String>> execute(SerialTvDetail serialTvDetail) {
    return repository.saveWatchlistSerialTv(serialTvDetail);
  }
}
