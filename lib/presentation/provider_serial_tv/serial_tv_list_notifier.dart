import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities_serial_tv/serial_tv.dart';
import 'package:ditonton/domain/usercases_serial_tv/get_popular_serial_tv.dart';
import 'package:ditonton/domain/usercases_serial_tv/get_serial_tv.dart';
import 'package:ditonton/domain/usercases_serial_tv/get_top_rated_serial_tv.dart';
import 'package:flutter/material.dart';

class SerialTvListNotifier extends ChangeNotifier {
  //list serial tv
  var _nowPlayingSerialTv = <SerialTv>[];
  List<SerialTv> get nowPlayingSerialTv => _nowPlayingSerialTv;

  RequestState _nowPlayingState = RequestState.empty;
  RequestState get nowPlayingState => _nowPlayingState;

  String _message = '';
  String get message => _message;

  //Popular Serial Tv
  var _popularSerialTv = <SerialTv>[];
  List<SerialTv> get popularSerialTv => _popularSerialTv;

  RequestState _popularSerialTvState = RequestState.empty;
  RequestState get popularSerialTvState => _popularSerialTvState;

  //Top Rated Serial Tv
  var _topRatedSerialTv = <SerialTv>[];
  List<SerialTv> get topRatedSerialTv => _topRatedSerialTv;

  RequestState _topRatedSerialTvState = RequestState.empty;
  RequestState get topRatedSerialTvState => _topRatedSerialTvState;

  SerialTvListNotifier({
    required this.getNowPlayingSerialTv,
    required this.getPopularSerialTv,
    required this.getTopRatedSerialTv,
  }) : super();

  final GetNowPlayingSerialTv getNowPlayingSerialTv;
  final GetPopularSerialTv getPopularSerialTv;
  final GetTopRatedSerialTv getTopRatedSerialTv;

  //Fuction untuk yang di putar saat ini
  Future<void> fetchNowPlayingSerialTv() async {
    _nowPlayingState = RequestState.loading;
    notifyListeners();

    final result = await getNowPlayingSerialTv.execute();
    result.fold((failure) {
      _nowPlayingState = RequestState.error;
      _message = failure.message;
      notifyListeners();
    }, (serialtvdata) {
      _nowPlayingState = RequestState.loaded;
      _nowPlayingSerialTv = serialtvdata;
      notifyListeners();
    });
  }

  //Function untuk popular Serial Tv
  Future<void> fetchNowPopularSerialTv() async {
    _popularSerialTvState = RequestState.loading;
    notifyListeners();

    final result = await getPopularSerialTv.execute();
    result.fold((failure) {
      _popularSerialTvState = RequestState.error;
      _message = failure.message;
      notifyListeners();
    }, (serialTvData) {
      _popularSerialTvState = RequestState.loaded;
      _popularSerialTv = serialTvData;
      notifyListeners();
    });
  }

  //function untuk Top Rated
  Future<void> fetchTopRatedSerialTv() async {
    _topRatedSerialTvState = RequestState.loading;
    notifyListeners();

    final result = await getTopRatedSerialTv.execute();
    result.fold((failure) {
      _topRatedSerialTvState = RequestState.error;
      _message = failure.message;
      notifyListeners();
    }, (serialTvData) {
      _topRatedSerialTvState = RequestState.loaded;
      _topRatedSerialTv = serialTvData;
      notifyListeners();
    });
  }
}
