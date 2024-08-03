import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/presentation/pages_Tv/home_tv_page.dart';
import 'package:ditonton/presentation/pages_Tv/now_playing_serial_tv_page.dart';
import 'package:ditonton/presentation/pages_Tv/popular_serial_tv_page.dart';
import 'package:ditonton/presentation/pages_Tv/search_serial_tv_page.dart';
import 'package:ditonton/presentation/pages_Tv/serial_tv_detail_page.dart';
import 'package:ditonton/presentation/pages_Tv/top_rated_serial_tv_page.dart';
import 'package:ditonton/presentation/pages_Tv/watchlist_serial_tv_page.dart';
import 'package:ditonton/presentation/provider_serial_tv/now_playing_serial_tv_notifier.dart';
import 'package:ditonton/presentation/provider_serial_tv/popular_serial_tv_notifier.dart';
import 'package:ditonton/presentation/provider_serial_tv/serial_tv_detail.dart';
import 'package:ditonton/presentation/provider_serial_tv/serial_tv_list_notifier.dart';
import 'package:ditonton/presentation/provider_serial_tv/serial_tv_search_notifier.dart';
import 'package:ditonton/presentation/provider_serial_tv/top_rated_serial_tv_notifier.dart';
import 'package:ditonton/presentation/provider_serial_tv/watchlist_serial_tv_notifier.dart';
import 'package:ditonton/presentation/provider/movie_detail_notifier.dart';
import 'package:ditonton/presentation/provider/movie_list_notifier.dart';
import 'package:ditonton/presentation/provider/movie_search_notifier.dart';
import 'package:ditonton/presentation/provider/popular_movies_notifier.dart';
import 'package:ditonton/presentation/provider/top_rated_movies_notifier.dart';
import 'package:ditonton/presentation/provider/watchlist_movie_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistMovieNotifier>(),
        ),

        //mendaftarkan provider serial Tv
        ChangeNotifierProvider(
          create: (_) => di.locator<SerialTvListNotifier>(),
        ),

        ChangeNotifierProvider(
          create: (_) => di.locator<PopularSerialTvNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedSerialTvNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<SerialTvDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistSerialTvNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<SerialTvSearchNotifier>(),
        ),
        ChangeNotifierProvider(
            create: (_) => di.locator<NowPlayingSerialTvNotifier>()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: const HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => const HomeMoviePage());
            case PopularMoviesPage.routeName:
              return CupertinoPageRoute(
                  builder: (_) => const PopularMoviesPage());
            case TopRatedMoviesPage.routeName:
              return CupertinoPageRoute(
                  builder: (_) => const TopRatedMoviesPage());
            case MovieDetailPage.routeName:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.routeName:
              return CupertinoPageRoute(builder: (_) => const SearchPage());
            case WatchlistMoviesPage.routeName:
              return MaterialPageRoute(
                  builder: (_) => const WatchlistMoviesPage());
            case AboutPage.routeName:
              return MaterialPageRoute(builder: (_) => const AboutPage());
            case HomeTvPage.routeName:
              return MaterialPageRoute(builder: (_) => const HomeTvPage());
            case PopularSerialTvPage.routeName:
              return MaterialPageRoute(
                  builder: (_) => const PopularSerialTvPage());
            case SerialTvDetailPage.routeName:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => SerialTvDetailPage(id: id),
                settings: settings,
              );
            case WatchlistSerialTvPage.routeName:
              return MaterialPageRoute(
                  builder: (_) => const WatchlistSerialTvPage());
            case SearchSerialTvPage.routeName:
              return MaterialPageRoute(
                  builder: (_) => const SearchSerialTvPage());

            case TopRatedSerialTv.routeName:
              return MaterialPageRoute(
                  builder: (_) => const TopRatedSerialTv());
            case NowPlayingSerialTvPage.routeName:
              return MaterialPageRoute(
                  builder: (_) => const NowPlayingSerialTvPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return const Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
