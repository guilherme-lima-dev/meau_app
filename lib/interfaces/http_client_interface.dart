abstract class IHttpClient{
  Future<dynamic> get(String url, [String token]);
  Future<dynamic> post(String url, dynamic params, [String token]);
}