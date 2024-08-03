import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities_serial_tv/serial_tv.dart';
import 'package:ditonton/domain/usercases_serial_tv/get_serial_tv.dart';
import 'package:flutter/material.dart';

class NowPlayingSerialTvNotifier extends ChangeNotifier {
  final GetNowPlayingSerialTv getNowPlayingSerialTv;

  NowPlayingSerialTvNotifier({required this.getNowPlayingSerialTv});

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<SerialTv> _serialTv = [];
  List<SerialTv> get serialtv => _serialTv;

  String _message = '';
  String get message => _message;

  Future<void> fetchNowPlayingSerialTv() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getNowPlayingSerialTv.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
      },
      (serialTvData) {
        _serialTv = serialTvData;
        _state = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}
