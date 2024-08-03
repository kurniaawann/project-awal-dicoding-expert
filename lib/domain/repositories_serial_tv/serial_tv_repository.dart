import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities_serial_tv/serial_tv.dart';
import 'package:ditonton/domain/entities_serial_tv/serial_tv_detail.dart';

abstract class SerialTvRepository {
  Future<Either<Failure, List<SerialTv>>> getNowPlayingSerialTv();
  Future<Either<Failure, List<SerialTv>>> getPopularSerialTv();
  Future<Either<Failure, List<SerialTv>>> getTopRatedSerialTv();
  Future<Either<Failure, SerialTvDetail>> getSerialTvDetail(int id);
  Future<Either<Failure, List<SerialTv>>> getSerialTvRecommendations(int id);
  Future<Either<Failure, String>> saveWatchlistSerialTv(
      SerialTvDetail serialTvDetail);
  Future<Either<Failure, String>> removeWatchlistSerialTv(
      SerialTvDetail serialTvDetail);
  Future<bool> isAddedToWatchlistSerialTv(int id);
  Future<Either<Failure, List<SerialTv>>> getWatchlistSerialTv();
  Future<Either<Failure, List<SerialTv>>> searchSerialTv(String query);
}
