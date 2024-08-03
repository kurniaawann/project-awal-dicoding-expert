import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider_serial_tv/top_rated_serial_tv_notifier.dart';
import 'package:ditonton/presentation/widgets/serial_tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopRatedSerialTv extends StatefulWidget {
  static const routeName = '/top-rated-serialtv';

  const TopRatedSerialTv({super.key});

  @override
  State<TopRatedSerialTv> createState() => _TopRatedSerialTvState();
}

class _TopRatedSerialTvState extends State<TopRatedSerialTv> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TopRatedSerialTvNotifier>(context, listen: false)
            .fetchTopRatedSerialTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Top Rated Serial Tv"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TopRatedSerialTvNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final serialtv = data.serialtv[index];
                  return SerialTvCard(serialtv);
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
