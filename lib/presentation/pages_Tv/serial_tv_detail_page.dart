import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities_serial_tv/genre_serial_tv.dart';
import 'package:ditonton/domain/entities_serial_tv/serial_tv.dart';
import 'package:ditonton/domain/entities_serial_tv/serial_tv_detail.dart';
import 'package:ditonton/presentation/provider_serial_tv/serial_tv_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class SerialTvDetailPage extends StatefulWidget {
  static const routeName = '/serialtvdetail';
  final int id;
  const SerialTvDetailPage({super.key, required this.id});

  @override
  State<SerialTvDetailPage> createState() => _SerialTvDetailPageState();
}

class _SerialTvDetailPageState extends State<SerialTvDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<SerialTvDetailNotifier>(context, listen: false)
          .fetchSerialTvDetail(widget.id);

      Provider.of<SerialTvDetailNotifier>(context, listen: false)
          .loadWatchlistStatusSerialTv(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<SerialTvDetailNotifier>(
        builder: (context, provider, child) {
          if (provider.serialTvState == RequestState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.serialTvState == RequestState.loaded) {
            final serialtv = provider.serialTv;
            return SafeArea(
              child: DetailContent(
                serialtv,
                provider.serialTvRecommendations,
                provider.isAddedToWatchlist,
              ),
            );
          } else {
            return Text(provider.message);
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final SerialTvDetail serialtv;
  final List<SerialTv> recommendations;
  final bool isAddedToWatchlistSerialTv;

  const DetailContent(
      this.serialtv, this.recommendations, this.isAddedToWatchlistSerialTv,
      {super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${serialtv.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              serialtv.name,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!isAddedToWatchlistSerialTv) {
                                  await Provider.of<SerialTvDetailNotifier>(
                                          context,
                                          listen: false)
                                      .addWatchlistSerialTv(serialtv);
                                } else {
                                  await Provider.of<SerialTvDetailNotifier>(
                                          context,
                                          listen: false)
                                      .removeFromWatchlistSerialTv(serialtv);
                                }

                                final message =
                                    Provider.of<SerialTvDetailNotifier>(context,
                                            listen: false)
                                        .watchlistMessage;

                                if (message ==
                                        SerialTvDetailNotifier
                                            .watchlistAddSuccessMessage ||
                                    message ==
                                        SerialTvDetailNotifier
                                            .watchlistRemoveSuccessMessage) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(message)));
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Text(message),
                                      );
                                    },
                                  );
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isAddedToWatchlistSerialTv
                                      ? const Icon(Icons.check)
                                      : const Icon(Icons.add),
                                  const Text("Watchlist serial tv"),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(serialtv.genres),
                            ),
                            Text(
                              _showDuration(serialtv.runtime),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: serialtv.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${serialtv.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 15),
                            Text(
                              'Over View',
                              style: kHeading6,
                            ),
                            Text(
                              serialtv.overview,
                            ),
                            const SizedBox(height: 15),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            Consumer<SerialTvDetailNotifier>(
                              builder: (context, data, child) {
                                if (data.recommendationState ==
                                    RequestState.loading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (data.recommendationState ==
                                    RequestState.error) {
                                  return Text(data.message);
                                } else if (data.recommendationState ==
                                    RequestState.loaded) {
                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final serialtv = recommendations[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                SerialTvDetailPage.routeName,
                                                arguments: serialtv.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${serialtv.posterPath}',
                                                placeholder: (context, url) =>
                                                    const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: recommendations.length,
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            minChildSize: 0.25,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<GenreSerialTv> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ',';
    }
    if (result.isEmpty) {
      return result;
    }
    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
