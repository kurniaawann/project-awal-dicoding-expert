import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities_serial_tv/serial_tv.dart';
import 'package:ditonton/domain/usercases_serial_tv/search_serial_tv.dart';
import 'package:flutter/foundation.dart';

class SerialTvSearchNotifier extends ChangeNotifier {
  final SearchSerialTv searchSerialTv;
  SerialTvSearchNotifier({required this.searchSerialTv});

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<SerialTv> _searchResultSerialTv = [];
  List<SerialTv> get searchResultSerialTv => _searchResultSerialTv;

  String _message = '';
  String get message => _message;

  Future<void> fetchSerialTvSearch(String query) async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await searchSerialTv.execute(query);
    result.fold((failure) {
      _message = failure.message;
      _state = RequestState.error;
      notifyListeners();
    }, (data) {
      _searchResultSerialTv = data;
      _state = RequestState.loaded;
      notifyListeners();
    });
  }
}
