import 'package:equatable/equatable.dart';
import 'package:ditonton/data/models_serial_tv/model_serial_tv.dart';

class SerialTvResponse extends Equatable {
  final List<SerialTvModel> serialTvList;
  const SerialTvResponse({required this.serialTvList});

  factory SerialTvResponse.fromJson(Map<String, dynamic> json) =>
      SerialTvResponse(
        serialTvList: List<SerialTvModel>.from((json["results"] as List)
            .map((x) => SerialTvModel.fromJson(x))
            .where((element) => element.posterPath != null)),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(serialTvList.map((x) => x.toJson())),
      };

  @override
  List<Object> get props => [serialTvList];
}
