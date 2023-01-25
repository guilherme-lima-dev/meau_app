import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:meau/interfaces/http_client_interface.dart';

class DioClient implements IHttpClient{
  final dio = Dio();

  @override
  Future get(String url, [String? token]) async{
    try{
      if(token != null) dio.options.headers['Authorization'] = "Bearer $token";
      dio.options.headers['Accept'] = 'application/json';

      final response = await dio.get(url);
      return response.data;
    }on DioError catch(error){
      return jsonDecode(error.response.toString());
    }
  }

  @override
  Future post(String url, dynamic params, [String? token]) async{
    try{
      if(token != null) dio.options.headers['Authorization'] = "Bearer $token";
      dio.options.headers['Accept'] = 'application/json';

      final response = await dio.post(url, data: params);
      print("response::::");
      print(response);
      return response.data;
    }on DioError catch(error){
      return jsonDecode(error.response.toString());
    }
  }

}