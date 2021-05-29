import 'dart:convert';

import 'package:flutter_shopify/base/config.dart';
import 'package:flutter_shopify/services/network/util/nothing.dart';
import 'package:flutter_shopify/services/network/util/request_type.dart';
import 'package:flutter_shopify/services/network/util/request_type_exception.dart';
import 'package:http/http.dart';

class AppClient {
  final Client _client;

  Map<String, String> loadHeaders({bool authRequired = true}) {
    Map<String, String> headers = {"Content-Type": "application/json"};
    if (authRequired) {
      headers['X-Shopify-Access-Token'] = RESTAPIConfig.accessToken;
    }
    return headers;
  }

  AppClient(this._client);

  Future<Response> request(
      {required RequestType requestType,
      required String path,
      dynamic parameter = Nothing,
      bool authRequired = true}) async {
    final uri = Uri.https('${RESTAPIConfig.baseURL}', '$path');
    final headers = loadHeaders(authRequired: authRequired);
    switch (requestType) {
      //
      case RequestType.GET:
        return _client.get(uri, headers: headers);
      case RequestType.POST:
        return _client.post(uri,
            headers: headers, body: json.encode(parameter));
      case RequestType.DELETE:
        return _client.delete(uri, headers: headers);
      case RequestType.PUT:
        return _client.put(uri, headers: headers);
      default:
        return throw RequestTypeNotFoundException(
            "The HTTP request mentioned is not found");
    }
  }
}
