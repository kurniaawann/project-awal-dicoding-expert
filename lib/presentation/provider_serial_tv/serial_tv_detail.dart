import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities_serial_tv/serial_tv.dart';
import 'package:ditonton/domain/entities_serial_tv/serial_tv_detail.dart';
import 'package:ditonton/domain/usercases_serial_tv/get_recommendations_serial_tv.dart';
import 'package:ditonton/domain/usercases_serial_tv/get_serial_tv_detail.dart';
import 'package:ditonton/domain/usercases_serial_tv/get_watchlist_status_serial_tv.dart';
import 'package:ditonton/domain/usercases_serial_tv/remove_watchlist_serial_tv.dart';
import 'package:ditonton/domain/usercases_serial_tv/save_watchlist_serial_tv.dart';
import 'package:flutter/material.dart';

class SerialTvDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist Serial Tv';
  static const watchlistRemoveSuccessMessage =
      'Removed from Watchlist Serial Tv';

  final GetSerialTvDetail getSerialTvDetail;
  final GetSerialTvRecommendations getSerialTvRecommendations;
  final GetWatchListStatusSerialTv getWatchListStatusSerialTv;
  final SaveWatchlistSerialTv saveWatchlistSerialTv;
  final RemoveWatchlistSerialTv removeWatchlistSerialTv;

  SerialTvDetailNotifier({
    required this.getSerialTvDetail,
    required this.getSerialTvRecommendations,
    required this.getWatchListStatusSerialTv,
    required this.saveWatchlistSerialTv,
    required this.removeWatchlistSerialTv,
  });

  //untuk serial tv detail
  late SerialTvDetail _serialTv;
  SerialTvDetail get serialTv => _serialTv;

  RequestState _serialTvState = RequestState.empty;
  RequestState get serialTvState => _serialTvState;
  //untuk serial tv recomendations
  List<SerialTv> _serialTvRecommendations = [];
  List<SerialTv> get serialTvRecommendations => _serialTvRecommendations;

  RequestState _recommendationState = RequestState.empty;
  RequestState get recommendationState => _recommendationState;

  String _message = '';
  String get message => _message;

  bool _isAddedtoWatchlist = false;
  bool get isAddedToWatchlist => _isAddedtoWatchlist;

  Future<void> fetchSerialTvDetail(int id) async {
    _serialTvState = RequestState.loading;
    notifyListeners();
    final detailResult = await getSerialTvDetail.excute(id);
    final recommendationResult = await getSerialTvRecommendations.execute(id);
    detailResult.fold(
      (failure) {
        _serialTvState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (serialtv) {
        _recommendationState = RequestState.loading;
        _serialTv = serialtv;
        notifyListeners();
        recommendationResult.fold(
          (failure) {
            _recommendationState = RequestState.error;
            _message = failure.message;
          },
          (serialtvs) {
            _recommendationState = RequestState.loaded;
            _serialTvRecommendations = serialtvs;
          },
        );
        _serialTvState = RequestState.loaded;
        notifyListeners();
      },
    );
  }

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> addWatchlistSerialTv(SerialTvDetail serialTvDetail) async {
    final result = await saveWatchlistSerialTv.execute(serialTvDetail);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );
    await loadWatchlistStatusSerialTv(serialTvDetail.id);
  }

  Future<void> removeFromWatchlistSerialTv(
      SerialTvDetail serialTvDetail) async {
    final result = await removeWatchlistSerialTv.execute(serialTvDetail);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatusSerialTv(serialTvDetail.id);
  }

  Future<void> loadWatchlistStatusSerialTv(int id) async {
    final result = await getWatchListStatusSerialTv.execute(id);
    _isAddedtoWatchlist = result;
    notifyListeners();
  }
}
