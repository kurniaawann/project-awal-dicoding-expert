import 'dart:convert';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/models_serial_tv/model_serial_tv.dart';
import 'package:ditonton/data/models_serial_tv/serial_tv_detail.dart';
import 'package:ditonton/data/models_serial_tv/serial_tv_response.dart';

import 'package:http/http.dart' as http;

abstract class SerialTvRemoteDataSource {
  Future<List<SerialTvModel>> getNowPlayingSerialTv();
  Future<List<SerialTvModel>> getPopularSerialTv();
  Future<List<SerialTvModel>> getTopRatedSerialTv();
  Future<SerialTvDetailResponse> getSerialTvDetail(int id);
  Future<List<SerialTvModel>> getSerialTvRecomendations(int id);
  Future<List<SerialTvModel>> searchSerialTv(String query);
}

class SerialTvRemoteDataSourceImpl implements SerialTvRemoteDataSource {
  static const apiKey = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const baseUrl = 'https://api.themoviedb.org/3';

  final http.Client client;

  SerialTvRemoteDataSourceImpl({required this.client});

  @override
  Future<List<SerialTvModel>> getNowPlayingSerialTv() async {
    final response =
        await client.get(Uri.parse('$baseUrl/tv/airing_today?$apiKey'));

    if (response.statusCode == 200) {
      return SerialTvResponse.fromJson(json.decode(response.body)).serialTvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<SerialTvDetailResponse> getSerialTvDetail(int id) async {
    final response = await client.get(Uri.parse('$baseUrl/tv/$id?$apiKey'));
    if (response.statusCode == 200) {
      return SerialTvDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<SerialTvModel>> getPopularSerialTv() async {
    final response = await client.get(Uri.parse('$baseUrl/tv/popular?$apiKey'));
    if (response.statusCode == 200) {
      return SerialTvResponse.fromJson(json.decode(response.body)).serialTvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<SerialTvModel>> getTopRatedSerialTv() async {
    final response =
        await client.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey'));

    if (response.statusCode == 200) {
      return SerialTvResponse.fromJson(json.decode(response.body)).serialTvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<SerialTvModel>> getSerialTvRecomendations(int id) async {
    final response =
        await client.get(Uri.parse('$baseUrl/tv/$id/recommendations?$apiKey'));

    if (response.statusCode == 200) {
      return SerialTvResponse.fromJson(json.decode(response.body)).serialTvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<SerialTvModel>> searchSerialTv(String query) async {
    final response =
        await client.get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$query'));

    if (response.statusCode == 200) {
      return SerialTvResponse.fromJson(json.decode(response.body)).serialTvList;
    } else {
      throw ServerException();
    }
  }
}
