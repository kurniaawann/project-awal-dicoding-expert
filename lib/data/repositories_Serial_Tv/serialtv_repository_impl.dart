import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/datasources_serial_tv/serial_tv_local_data_source.dart';
import 'package:ditonton/data/datasources_serial_tv/serial_tv_remote_data_source.dart';
import 'package:ditonton/data/models_serial_tv/serial_tv_table.dart';
import 'package:ditonton/domain/entities_serial_tv/serial_tv.dart';
import 'package:ditonton/domain/entities_serial_tv/serial_tv_detail.dart';
import 'package:ditonton/domain/repositories_serial_tv/serial_tv_repository.dart';

class SerialTvRepositoryImpl implements SerialTvRepository {
  final SerialTvRemoteDataSource remoteDataSource;
  final SerialTvDataSource localDataSource;

  SerialTvRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<SerialTv>>> getNowPlayingSerialTv() async {
    try {
      final result = await remoteDataSource.getNowPlayingSerialTv();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<SerialTv>>> getPopularSerialTv() async {
    try {
      final result = await remoteDataSource.getPopularSerialTv();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<SerialTv>>> getTopRatedSerialTv() async {
    try {
      final result = await remoteDataSource.getTopRatedSerialTv();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, SerialTvDetail>> getSerialTvDetail(int id) async {
    try {
      final result = await remoteDataSource.getSerialTvDetail(id);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<SerialTv>>> getSerialTvRecommendations(
      int id) async {
    try {
      final result = await remoteDataSource.getSerialTvRecomendations(id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<SerialTv>>> searchSerialTv(String query) async {
    try {
      final result = await remoteDataSource.searchSerialTv(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchlistSerialTv(
      SerialTvDetail serialTvDetail) async {
    try {
      final result = await localDataSource
          .insertWatchlistSerialTv(SerialTvTable.fromEntity(serialTvDetail));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, String>> removeWatchlistSerialTv(
      SerialTvDetail serialTvDetail) async {
    try {
      final result = await localDataSource
          .removeWatchlistSerialTv(SerialTvTable.fromEntity(serialTvDetail));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<bool> isAddedToWatchlistSerialTv(int id) async {
    final result = await localDataSource.getSerialTvById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, List<SerialTv>>> getWatchlistSerialTv() async {
    final result = await localDataSource.getWatchlistSerialTv();
    return Right(result.map((data) => data.toEntity()).toList());
  }
}
