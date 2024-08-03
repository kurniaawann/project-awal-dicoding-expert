import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities_serial_tv/serial_tv.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/presentation/pages_Tv/now_playing_serial_tv_page.dart';
import 'package:ditonton/presentation/pages_Tv/popular_serial_tv_page.dart';
import 'package:ditonton/presentation/pages_Tv/search_serial_tv_page.dart';
import 'package:ditonton/presentation/pages_Tv/serial_tv_detail_page.dart';
import 'package:ditonton/presentation/pages_Tv/top_rated_serial_tv_page.dart';
import 'package:ditonton/presentation/pages_Tv/watchlist_serial_tv_page.dart';
import 'package:ditonton/presentation/provider_serial_tv/serial_tv_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTvPage extends StatefulWidget {
  static const routeName = '/hometv';
  const HomeTvPage({Key? key}) : super(key: key);

  @override
  State<HomeTvPage> createState() => _HomeTvPageState();
}

class _HomeTvPageState extends State<HomeTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => Provider.of<SerialTvListNotifier>(context, listen: false)
          ..fetchNowPlayingSerialTv()
          ..fetchNowPopularSerialTv()
          ..fetchTopRatedSerialTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: const Icon(Icons.movie),
              title: const Text('Movies'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
            ),
            ListTile(
              leading: const Icon(Icons.save_alt),
              title: const Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistMoviesPage.routeName);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, HomeTvPage.routeName);
              },
              leading: const Icon(Icons.tv),
              title: const Text('Serial Tv'),
            ),
            ListTile(
              leading: const Icon(Icons.save_rounded),
              title: const Text('Watchlist Serial Tv'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistSerialTvPage.routeName);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.routeName);
              },
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Serial Tv'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchSerialTvPage.routeName);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubHeadingSerialTv(
                  title: 'Now Playing',
                  onTap: () => Navigator.pushNamed(
                      context, NowPlayingSerialTvPage.routeName)),
              Consumer<SerialTvListNotifier>(builder: (context, data, child) {
                final state = data.nowPlayingState;
                if (state == RequestState.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.loaded) {
                  return SerialTvList(data.nowPlayingSerialTv);
                } else {
                  return const Text('Failed');
                }
              }),
              _buildSubHeadingSerialTv(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, PopularSerialTvPage.routeName),
              ),
              Consumer<SerialTvListNotifier>(builder: (context, data, child) {
                final state = data.popularSerialTvState;
                if (state == RequestState.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.loaded) {
                  return SerialTvList(data.popularSerialTv);
                } else {
                  return const Text('Failed');
                }
              }),
              _buildSubHeadingSerialTv(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedSerialTv.routeName),
              ),
              Consumer<SerialTvListNotifier>(builder: (context, data, child) {
                final state = data.topRatedSerialTvState;
                if (state == RequestState.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.loaded) {
                  return SerialTvList(data.topRatedSerialTv);
                } else {
                  return const Text('Failed');
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeadingSerialTv(
      {required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class SerialTvList extends StatelessWidget {
  final List<SerialTv> serialTv;
  const SerialTvList(this.serialTv, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final serialTvNowplaying = serialTv[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, SerialTvDetailPage.routeName,
                    arguments: serialTvNowplaying.id);
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageUrl${serialTvNowplaying.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: serialTv.length,
      ),
    );
  }
}
