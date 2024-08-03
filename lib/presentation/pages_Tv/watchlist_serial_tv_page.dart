import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/provider_serial_tv/watchlist_serial_tv_notifier.dart';
import 'package:ditonton/presentation/widgets/serial_tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchlistSerialTvPage extends StatefulWidget {
  static const routeName = '/watchlist-serial-tv';

  const WatchlistSerialTvPage({super.key});

  @override
  State<WatchlistSerialTvPage> createState() => _WatchlistSerialTvPageState();
}

class _WatchlistSerialTvPageState extends State<WatchlistSerialTvPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<WatchlistSerialTvNotifier>(context, listen: false)
            .fetchWatchlistSerialTv());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    Provider.of<WatchlistSerialTvNotifier>(context, listen: false)
        .fetchWatchlistSerialTv();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<WatchlistSerialTvNotifier>(
          builder: (context, data, child) {
            if (data.watchlistState == RequestState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.watchlistState == RequestState.loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final serialtv = data.watchlistSerialTv[index];
                  return SerialTvCard(serialtv);
                },
                itemCount: data.watchlistSerialTv.length,
              );
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
