import 'dart:convert';
import 'dart:io';

class NetworkClient {
  final _client = HttpClient();
  Uri _makeUri(String path, [Map<String, dynamic>? params]) {
    final uri = Uri.parse(path);
    if (params != null) {
      return uri.replace(queryParameters: params);
    }
    return uri;
  }

  Future<T> get<T>(
      String path,
      T Function(dynamic json) parser, [
        Map<String, dynamic>? parameters,
      ]) async {
    final url = _makeUri(path, parameters); // full url with parameters
    try {
      final request = await _client.getUrl(url);
      final response = await request.close();
      // print(response.length);
      final dynamic json = await response.jsonDecode();
      // _validateResponse(response, json);
      final result = parser(json);
      print(result);
      return result;
    } on SocketException {
      throw 'e';
      // throw ApiClientException(ApiClientExceptionType.network);
      // } on ApiClientException {
      //   rethrow; // пробрасывает ошибку выше. больше ничего
    } catch (e) {
      throw e;
      // throw ApiClientException(ApiClientExceptionType.other);
    }
  }

}

extension HttpClientResponseJsonDecode on HttpClientResponse {
  Future<dynamic> jsonDecode() async {
    return transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        .then<dynamic>((v) => json.decode(v));
  }
}
