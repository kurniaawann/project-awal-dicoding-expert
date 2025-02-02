import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider_serial_tv/now_playing_serial_tv_notifier.dart';
import 'package:ditonton/presentation/widgets/serial_tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NowPlayingSerialTvPage extends StatefulWidget {
  static const routeName = 'nowplaying-serialtv';
  const NowPlayingSerialTvPage({super.key});

  @override
  State<NowPlayingSerialTvPage> createState() => _NowPlayingSerialTvPageState();
}

class _NowPlayingSerialTvPageState extends State<NowPlayingSerialTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<NowPlayingSerialTvNotifier>(context, listen: false)
            .fetchNowPlayingSerialTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('now playing serial tv'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<NowPlayingSerialTvNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final serialTvv = data.serialtv[index];
                  return SerialTvCard(serialTvv);
                },
                itemCount: data.serialtv.length,
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
}
