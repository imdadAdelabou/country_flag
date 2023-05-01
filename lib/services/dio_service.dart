import 'package:dio/dio.dart';
import 'package:pokemon/helpers/constant.dart';
import 'package:pokemon/models/response_request.dart';

class DioService {
  final _dio = Dio();

  Future<ResponseRequest> get({required String path}) async {
    print("$baseApiUrl$path");
    try {
      var response = await _dio.get(
        "$baseApiUrl$path",
        options: optionsApi,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return ResponseRequest(
          data: response.data,
          statusCode: response.statusCode!,
        );
      }
      throw "An error occur";
    } on DioError catch (e) {
      print(e);
      return ResponseRequest(
        statusCode: e.response!.statusCode!,
        data: null,
      );
    }
  }
}
