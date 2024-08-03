import 'package:ditonton/data/models_serial_tv/serial_tv_table.dart';
import 'package:ditonton/domain/entities_serial_tv/genre_serial_tv.dart';
import 'package:ditonton/domain/entities_serial_tv/serial_tv.dart';
import 'package:ditonton/domain/entities_serial_tv/serial_tv_detail.dart';

const testSerialTv = SerialTv(
  adult: false,
  backdropPath: "/jWXrQstj7p3Wl5MfYWY6IHqRpDb.jpg",
  genreIds: [10763],
  id: 94722,
  originCountry: ["De"],
  originalName: "de",
  overview:
      "German daily news program, the oldest still existing program on German television.",
  popularity: 3538.017,
  posterPath: "/7dFZJ2ZJJdcmkp05B9NWlqTJ5tq.jpg",
  firstAirDate: "1952-12-26",
  name: "Tagesschau",
  voteAverage: 6.898,
  voteCount: 191,
);

final testSerialTvList = [testSerialTv];

const testSerialTvDetail = SerialTvDetail(
  adult: false,
  backdropPath: "backdropPath",
  genres: [GenreSerialTv(id: 1, name: "News")],
  id: 1,
  originalName: "originalName",
  overview: "overview",
  posterPath: "posterPath",
  firstAirDate: "firstAirDate",
  runtime: 0,
  name: "name",
  voteAverage: 1,
  voteCount: 1,
);

const testWatchlistSerialTv = SerialTv.watchlist(
  id: 1,
  overview: "overview",
  posterPath: "posterPath",
  name: "name",
);

const testSerialTvTable = SerialTvTable(
  id: 1,
  name: "name",
  overview: "overview",
  posterPath: "posterPath",
);

final testSerialTvMap = {
  "id": 1,
  "name": "name",
  "overview": "overview",
  "posterPath": "posterPath",
};
