import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider_serial_tv/serial_tv_search_notifier.dart';
import 'package:ditonton/presentation/widgets/serial_tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchSerialTvPage extends StatelessWidget {
  static const routeName = '/search-serial-tv';

  const SearchSerialTvPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("search Serial Tv"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) {
                Provider.of<SerialTvSearchNotifier>(context, listen: false)
                    .fetchSerialTvSearch(query);
              },
              decoration: const InputDecoration(
                hintText: 'search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 15),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            Consumer<SerialTvSearchNotifier>(
              builder: (context, data, child) {
                if (data.state == RequestState.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (data.state == RequestState.loaded) {
                  final result = data.searchResultSerialTv;
                  return Expanded(
                      child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemBuilder: (context, index) {
                      final serialTv = data.searchResultSerialTv[index];
                      return SerialTvCard(serialTv);
                    },
                    itemCount: result.length,
                  ));
                } else {
                  return Expanded(child: Container());
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
