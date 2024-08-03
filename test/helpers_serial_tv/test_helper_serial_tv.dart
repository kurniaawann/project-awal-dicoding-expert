import 'package:ditonton/data/datasources_serial_tv/db_serial_tv/database_helper_serial_tv.dart';
import 'package:ditonton/data/datasources_serial_tv/serial_tv_local_data_source.dart';
import 'package:ditonton/data/datasources_serial_tv/serial_tv_remote_data_source.dart';
import 'package:ditonton/domain/repositories_serial_tv/serial_tv_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  SerialTvRepository,
  SerialTvRemoteDataSource,
  SerialTvDataSource,
  DatabaseHelperSerialTv,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
