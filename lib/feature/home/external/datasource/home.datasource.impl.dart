import 'package:dio/dio.dart';

import '../../../../core/_core.dart';
import '../../_home.dart';

class HomeDatasourceImpl implements HomeDatasource {
  HomeDatasourceImpl({
    required Dio httpClient,
  }) : _httpClient = httpClient;

  final Dio _httpClient;

  @override
  Future<List<dynamic>> getProducts({int? productId}) async {
    try {
      String url = '${AppEndpoints.baseUrl}${AppEndpoints.products}';

      final response = await _httpClient.get(url);

      return response.data as List<dynamic>;
    } on DioException catch (e) {
      throw DioException(requestOptions: e.requestOptions, response: e.response);
    }
  }
}
