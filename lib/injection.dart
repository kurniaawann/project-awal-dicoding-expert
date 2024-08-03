import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/data/datasources_serial_tv/db_serial_tv/database_helper_serial_tv.dart';
import 'package:ditonton/data/datasources_serial_tv/serial_tv_local_data_source.dart';
import 'package:ditonton/data/datasources_serial_tv/serial_tv_remote_data_source.dart';
import 'package:ditonton/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/data/repositories_Serial_Tv/serialtv_repository_impl.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories_serial_tv/serial_tv_repository.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/domain/usercases_serial_tv/get_popular_serial_tv.dart';
import 'package:ditonton/domain/usercases_serial_tv/get_recommendations_serial_tv.dart';
import 'package:ditonton/domain/usercases_serial_tv/get_serial_tv.dart';
import 'package:ditonton/domain/usercases_serial_tv/get_serial_tv_detail.dart';
import 'package:ditonton/domain/usercases_serial_tv/get_top_rated_serial_tv.dart';
import 'package:ditonton/domain/usercases_serial_tv/get_watchlist_serial_tv.dart';
import 'package:ditonton/domain/usercases_serial_tv/get_watchlist_status_serial_tv.dart';
import 'package:ditonton/domain/usercases_serial_tv/remove_watchlist_serial_tv.dart';
import 'package:ditonton/domain/usercases_serial_tv/save_watchlist_serial_tv.dart';
import 'package:ditonton/domain/usercases_serial_tv/search_serial_tv.dart';
import 'package:ditonton/presentation/provider_serial_tv/now_playing_serial_tv_notifier.dart';
import 'package:ditonton/presentation/provider_serial_tv/popular_serial_tv_notifier.dart';
import 'package:ditonton/presentation/provider_serial_tv/serial_tv_detail.dart';
import 'package:ditonton/presentation/provider_serial_tv/serial_tv_list_notifier.dart';
import 'package:ditonton/presentation/provider_serial_tv/serial_tv_search_notifier.dart';
import 'package:ditonton/presentation/provider_serial_tv/top_rated_serial_tv_notifier.dart';
import 'package:ditonton/presentation/provider/movie_detail_notifier.dart';
import 'package:ditonton/presentation/provider/movie_list_notifier.dart';
import 'package:ditonton/presentation/provider/movie_search_notifier.dart';
import 'package:ditonton/presentation/provider/popular_movies_notifier.dart';
import 'package:ditonton/presentation/provider/top_rated_movies_notifier.dart';
import 'package:ditonton/presentation/provider/watchlist_movie_notifier.dart';
import 'package:ditonton/presentation/provider_serial_tv/watchlist_serial_tv_notifier.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieSearchNotifier(
      searchMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieNotifier(
      getWatchlistMovies: locator(),
    ),
  );

  //Serial tv provider
  locator.registerFactory(
    () => SerialTvListNotifier(
      getNowPlayingSerialTv: locator(),
      getPopularSerialTv: locator(),
      getTopRatedSerialTv: locator(),
    ),
  );

  locator.registerFactory(
    () => TopRatedSerialTvNotifier(
      getTopRatedSerialTv: locator(),
    ),
  );

  locator.registerFactory(
    () => PopularSerialTvNotifier(
      locator(),
    ),
  );

  locator.registerFactory(
    () => SerialTvDetailNotifier(
      saveWatchlistSerialTv: locator(),
      removeWatchlistSerialTv: locator(),
      getWatchListStatusSerialTv: locator(),
      getSerialTvDetail: locator(),
      getSerialTvRecommendations: locator(),
    ),
  );

  locator.registerFactory(
    () => WatchlistSerialTvNotifier(
      getWatchlistSerialTv: locator(),
    ),
  );

  locator.registerFactory(
    () => SerialTvLocalDataSourceImpl(
      databaseHelperST: locator(),
    ),
  );

  locator.registerFactory(
    () => SerialTvSearchNotifier(
      searchSerialTv: locator(),
    ),
  );

  locator.registerFactory(
    () => NowPlayingSerialTvNotifier(
      getNowPlayingSerialTv: locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));
  //use case serial tv
  locator.registerLazySingleton(() => GetNowPlayingSerialTv(locator()));
  locator.registerLazySingleton(() => GetPopularSerialTv(locator()));
  locator.registerLazySingleton(() => GetTopRatedSerialTv(locator()));
  locator.registerLazySingleton(() => GetSerialTvDetail(locator()));
  locator.registerLazySingleton(() => GetSerialTvRecommendations(locator()));
  locator.registerLazySingleton(() => SaveWatchlistSerialTv(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistSerialTv(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusSerialTv(locator()));
  locator.registerLazySingleton(() => GetWatchlistSerialTv(locator()));
  locator.registerLazySingleton(() => SearchSerialTv(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  //repository serial tv
  locator.registerLazySingleton<SerialTvRepository>(
    () => SerialTvRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  // data source serial tv
  locator.registerLazySingleton<SerialTvRemoteDataSource>(
      () => SerialTvRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<SerialTvDataSource>(
      () => SerialTvLocalDataSourceImpl(databaseHelperST: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  //helper SerialTv
  locator.registerLazySingleton<DatabaseHelperSerialTv>(
      () => DatabaseHelperSerialTv());

  // external
  locator.registerLazySingleton(() => http.Client());
}
