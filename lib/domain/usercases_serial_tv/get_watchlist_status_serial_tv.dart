import 'package:ditonton/domain/repositories_serial_tv/serial_tv_repository.dart';

class GetWatchListStatusSerialTv {
  final SerialTvRepository repository;

  GetWatchListStatusSerialTv(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlistSerialTv(id);
  }
}
