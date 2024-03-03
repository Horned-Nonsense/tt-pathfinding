import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/result.dart';
import '../models/tables.dart';

part 'table_client.g.dart';

@RestApi(
  baseUrl: 'https://flutter.webspark.dev/flutter/api',
)
abstract class TablesClient {
  factory TablesClient(Dio dio, {String baseUrl}) = _TablesClient;

  static isUrlValid(String url) {
    try {
      Uri.parse(url);
      return true;
    } catch (_) {
      return false;
    }
  }

  @GET('')
  Future<Tables> getTables();

  @POST('')
  Future<void> sendResults(@Body() List<Result> data);
}
