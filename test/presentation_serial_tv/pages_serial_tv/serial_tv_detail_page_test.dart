import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities_serial_tv/serial_tv.dart';
import 'package:ditonton/presentation/pages_Tv/serial_tv_detail_page.dart';
import 'package:ditonton/presentation/provider_serial_tv/serial_tv_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data_serial_tv/dummy_objects_serialtv.dart';
import 'serial_tv_detail_page_test.mocks.dart';

@GenerateMocks([SerialTvDetailNotifier])
void main() {
  late MockSerialTvDetailNotifier mockNotifier;
  setUp(() {
    mockNotifier = MockSerialTvDetailNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<SerialTvDetailNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when Serial Tv not added to watchlist',
      (WidgetTester tester) async {
    when(mockNotifier.serialTvState).thenReturn(RequestState.loaded);
    when(mockNotifier.serialTv).thenReturn(testSerialTvDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
    when(mockNotifier.serialTvRecommendations).thenReturn(<SerialTv>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester
        .pumpWidget(_makeTestableWidget(const SerialTvDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when serial tv is added to wathclist',
      (WidgetTester tester) async {
    when(mockNotifier.serialTvState).thenReturn(RequestState.loaded);
    when(mockNotifier.serialTv).thenReturn(testSerialTvDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
    when(mockNotifier.serialTvRecommendations).thenReturn(<SerialTv>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(true);

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester
        .pumpWidget(_makeTestableWidget(const SerialTvDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets('Watchlist button should cek icons', (WidgetTester tester) async {
    when(mockNotifier.serialTvState).thenReturn(RequestState.loaded);
    when(mockNotifier.serialTv).thenReturn(testSerialTvDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
    when(mockNotifier.serialTvRecommendations).thenReturn(<SerialTv>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockNotifier.watchlistMessage).thenReturn('Added to Watchlist');

    final watchlistButton = find.byType(ElevatedButton);

    await tester
        .pumpWidget(_makeTestableWidget(const SerialTvDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);

    await tester.pump();

    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(mockNotifier.serialTvState).thenReturn(RequestState.loaded);
    when(mockNotifier.serialTv).thenReturn(testSerialTvDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
    when(mockNotifier.serialTvRecommendations).thenReturn(<SerialTv>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockNotifier.watchlistMessage).thenReturn('Failed');

    final watchlistButton = find.byType(ElevatedButton);

    await tester
        .pumpWidget(_makeTestableWidget(const SerialTvDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}
