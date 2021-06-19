import 'dart:convert';
import 'dart:io';

import 'package:flutter_shopify/base/config.dart';
import 'package:http/http.dart' as http;

import 'network_exceptions.dart';

class HttpMethod {
  static const GET = 'GET';
  static const POST = 'POST';
  static const PUT = 'PUT';
}

class NetworkService {
  final client = http.Client();
  var version = '/admin/api/2021-04';
  var path = '';
  var method = HttpMethod.GET;
  String? customUrl;

  Map<String, String> headers = {};
  Map<String, dynamic>? parameters;
  Map<String, dynamic> body = {};

  Future<dynamic> request({bool needToken = false}) async {
    Uri uri = customUrl != null
        ? Uri.https(customUrl!, '')
        : Uri.https(RESTAPIConfig.baseURL, '$version$path', parameters);
    if (needToken) {
      headers['X-Shopify-Access-Token'] = RESTAPIConfig.accessToken;
    }
    headers['Content-Type'] = 'application/json';
    print('Uri: $uri');
    print('Headers: $headers');
    print('Body: $body');
    late http.Response response;
    switch (method) {
      case HttpMethod.GET:
        response = await client.get(uri, headers: headers);
        break;
      case HttpMethod.POST:
        response =
            await client.post(uri, headers: headers, body: json.encode(body));
        break;
      case HttpMethod.PUT:
        response =
            await client.put(uri, headers: headers, body: json.encode(body));
        break;
    }
    try {
      return _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No internet connection');
    }
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Unknown Error\nCode: ${response.statusCode}\nMessage: ${response.body.toString()}');
    }
  }
}
