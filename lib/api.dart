import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class AppApi {
  final Dio _dio = Dio();

  AppApi() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        var connectivityResult = await (Connectivity().checkConnectivity());
        if (connectivityResult == ConnectivityResult.none) {
          throw Exception('No internet connection');
        } else {
          handler.next(options);
        }
      },
    ));
  }

  Future<dynamic> get(String path) async {
    try {
      var response = await _dio.get(path);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to load data');
      }
    } on DioError catch (e) {
      throw Exception('Failed to load data');
    }
  }

  // Future<dynamic> post(String path, dynamic data) async {
  //   try {
  //     var response = await _dio.post(path, data: data);
  //     if (response.statusCode == 200) {
  //       return response.data;
  //     } else {
  //       throw Exception('Failed to post data');
  //     }
  //   } on DioError catch (e) {
  //     throw Exception('Failed to post data');
  //   }
  // }

  // Future<dynamic> put(String path, dynamic data) async {
  //   try {
  //     var response = await _dio.put(path, data: data);
  //     if (response.statusCode == 200) {
  //       return response.data;
  //     } else {
  //       throw Exception('Failed to update data');
  //     }
  //   } on DioError catch (e) {
  //     throw Exception('Failed to update data');
  //   }
  // }

  // Future<dynamic> delete(String path) async {
  //   try {
  //     var response = await _dio.delete(path);
  //     if (response.statusCode == 200) {
  //       return response.data;
  //     } else {
  //       throw Exception('Failed to delete data');
  //     }
  //   } on DioError catch (e) {
  //     throw Exception('Failed to delete data');
  //   }
  // }
}
