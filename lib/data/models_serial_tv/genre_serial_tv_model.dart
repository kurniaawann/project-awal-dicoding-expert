import 'package:ditonton/domain/entities_serial_tv/genre_serial_tv.dart';
import 'package:equatable/equatable.dart';

class GenreModelSerialTv extends Equatable {
  const GenreModelSerialTv({
    required this.id,
    required this.name,
  });
  final int id;
  final String name;

  factory GenreModelSerialTv.fromJson(Map<String, dynamic> json) =>
      GenreModelSerialTv(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

  GenreSerialTv toEntity() {
    return GenreSerialTv(id: id, name: name);
  }

  @override
  List<Object?> get props => [id, name];
}
