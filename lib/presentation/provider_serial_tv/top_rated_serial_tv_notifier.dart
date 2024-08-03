import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities_serial_tv/serial_tv.dart';
import 'package:ditonton/domain/usercases_serial_tv/get_top_rated_serial_tv.dart';
import 'package:flutter/material.dart';

class TopRatedSerialTvNotifier extends ChangeNotifier {
  final GetTopRatedSerialTv getTopRatedSerialTv;
  TopRatedSerialTvNotifier({required this.getTopRatedSerialTv});

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<SerialTv> _serialtv = [];
  List<SerialTv> get serialtv => _serialtv;

  String _message = '';
  String get message => _message;

  Future<void> fetchTopRatedSerialTv() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getTopRatedSerialTv.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
      },
      (serialTvData) {
        _serialtv = serialTvData;
        _state = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}
