import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider_serial_tv/popular_serial_tv_notifier.dart';
import 'package:ditonton/presentation/widgets/serial_tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PopularSerialTvPage extends StatefulWidget {
  static const routeName = '/popular-serialtv';
  const PopularSerialTvPage({Key? key}) : super(key: key);

  @override
  State<PopularSerialTvPage> createState() => _PopularSerialTvPageState();
}

class _PopularSerialTvPageState extends State<PopularSerialTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<PopularSerialTvNotifier>(context, listen: false)
            .fetchPopularSerialTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Serial Tv'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<PopularSerialTvNotifier>(
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
