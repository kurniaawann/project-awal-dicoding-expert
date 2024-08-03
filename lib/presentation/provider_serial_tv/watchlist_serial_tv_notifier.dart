import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities_serial_tv/serial_tv.dart';
import 'package:ditonton/domain/usercases_serial_tv/get_watchlist_serial_tv.dart';
import 'package:flutter/material.dart';

class WatchlistSerialTvNotifier extends ChangeNotifier {
  var _watchlistSerialTv = <SerialTv>[];
  List<SerialTv> get watchlistSerialTv => _watchlistSerialTv;

  var _watchlistState = RequestState.empty;
  RequestState get watchlistState => _watchlistState;

  String _message = '';
  String get message => _message;

  WatchlistSerialTvNotifier({required this.getWatchlistSerialTv});

  final GetWatchlistSerialTv getWatchlistSerialTv;

  Future<void> fetchWatchlistSerialTv() async {
    _watchlistState = RequestState.loading;
    notifyListeners();

    final result = await getWatchlistSerialTv.execute();
    result.fold(
      (failure) {
        _watchlistState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (serialTvData) {
        _watchlistState = RequestState.loaded;
        _watchlistSerialTv = serialTvData;
        notifyListeners();
      },
    );
  }
}
