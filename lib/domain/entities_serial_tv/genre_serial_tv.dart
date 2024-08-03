import 'package:equatable/equatable.dart';

class GenreSerialTv extends Equatable {
  const GenreSerialTv({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  @override
  List<Object?> get props => [id, name];
}
