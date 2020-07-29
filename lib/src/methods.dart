import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

///
/// Sends a [get] http request to the provided [url].
///
/// The response from the request is parsed by the [bodyParser] function,
/// by default this function is set to [jsonDecode]
///
/// if the response status code is 200(ok) the [onOk] is called
/// with the parsed body using the [bodyParser] function.
///
/// if [onOk] is not provided or another status code accrues
/// then the [onResponse] is called with the unParsed body and the status code.
///
Future<T> httpGet<T>({
  String url,
  Map<String, String> headers,
  Function(String body) bodyParser = jsonDecode,
  T Function(dynamic parsedBody) onOk,
  T Function(http.Response response) onResponse,
  Duration timeout = const Duration(minutes: 2),
  FutureOr<T> Function() onTimeout,
}) {
  assert(url != null);
  return http.get(url, headers: headers).then((response) {
    return _handleResponse(
      response: response,
      bodyParser: bodyParser,
      onOk: onOk,
      onResponse: onResponse,
    );
  }).timeout(
    timeout,
    onTimeout: onTimeout,
  );
}


///
/// Sends a [post] http request to the provided [url].
///
/// The [body] is the request body and can be a [String], [List<int>] or [Map<String, String>]
///
/// The response from the request is parsed by the [bodyParser] function,
/// by default this function is set to [jsonDecode]
///
/// if the response status code is 200(ok) the [onOk] is called
/// with the parsed body using the [bodyParser] function.
///
/// if [onOk] is not provided or another status code accrues
/// then the [onResponse] is called with the unParsed body and the status code.
///
Future<T> httpPost<T>({
  String url,
  Map<String, String> headers,
  body,
  Function(String body) bodyParser = jsonDecode,
  T Function(dynamic parsedBody) onOk,
  T Function(http.Response response) onResponse,
  Duration timeout = const Duration(minutes: 2),
  FutureOr<T> Function() onTimeout,
}) {
  assert(url != null);
  return http.post(url, headers: headers, body: body).then((response) {
    return _handleResponse(
      response: response,
      bodyParser: bodyParser,
      onOk: onOk,
      onResponse: onResponse,
    );
  }).timeout(
    timeout,
    onTimeout: onTimeout,
  );
}


///
/// Sends a [put] http request to the provided [url].
///
/// The [body] is the request body and can be a [String], [List<int>] or [Map<String, String>]
///
/// The response from the request is parsed by the [bodyParser] function,
/// by default this function is set to [jsonDecode]
///
/// if the response status code is 200(ok) the [onOk] is called
/// with the parsed body using the [bodyParser] function.
///
/// if [onOk] is not provided or another status code accrues
/// then the [onResponse] is called with the unParsed body and the status code.
///
Future<T> httpPut<T>({
  String url,
  Map<String, String> headers,
  body,
  Function(String body) bodyParser = jsonDecode,
  T Function(dynamic parsedBody) onOk,
  T Function(http.Response response) onResponse,
  Duration timeout = const Duration(minutes: 2),
  FutureOr<T> Function() onTimeout,
}){
  assert(url != null);
  return http.put(url, headers: headers, body: body).then((response) {
    return _handleResponse(
      response: response,
      bodyParser: bodyParser,
      onOk: onOk,
      onResponse: onResponse,
    );
  }).timeout(
    timeout,
    onTimeout: onTimeout,
  );
}


///
/// Sends a [delete] http request to the provided [url].
///
/// The response from the request is parsed by the [bodyParser] function,
/// by default this function is set to [jsonDecode]
///
/// if the response status code is 200(ok) the [onOk] is called
/// with the parsed body using the [bodyParser] function.
///
/// if [onOk] is not provided or another status code accrues
/// then the [onResponse] is called with the unParsed body and the status code.
///
Future<T> httpDelete<T>({
  String url,
  Map<String, String> headers,
  Function(String body) bodyParser = jsonDecode,
  T Function(dynamic parsedBody) onOk,
  T Function(http.Response response) onResponse,
  Duration timeout = const Duration(minutes: 2),
  FutureOr<T> Function() onTimeout,
}){
  assert(url != null);
  return http.delete(url, headers: headers).then((response) {
    return _handleResponse(
      response: response,
      bodyParser: bodyParser,
      onOk: onOk,
      onResponse: onResponse,
    );
  }).timeout(
    timeout,
    onTimeout: onTimeout,
  );
}

///
/// Sends a [patch] http request to the provided [url].
///
/// The [body] is the request body and can be a [String], [List<int>] or [Map<String, String>]
///
/// The response from the request is parsed by the [bodyParser] function,
/// by default this function is set to [jsonDecode]
///
/// if the response status code is 200(ok) the [onOk] is called
/// with the parsed body using the [bodyParser] function.
///
/// if [onOk] is not provided or another status code accrues
/// then the [onResponse] is called with the unParsed body and the status code.
///
Future<T> httpPatch<T>({
  String url,
  Map<String, String> headers,
  body,
  Function(String body) bodyParser = jsonDecode,
  T Function(dynamic parsedBody) onOk,
  T Function(http.Response response) onResponse,
  Duration timeout = const Duration(minutes: 2),
  FutureOr<T> onTimeout(),
}){
  assert(url != null);
  return http.patch(url, headers: headers, body: body).then((response) {
    return _handleResponse(
      response: response,
      bodyParser: bodyParser,
      onOk: onOk,
      onResponse: onResponse,
    );
  }).timeout(
    timeout,
    onTimeout: onTimeout,
  );
}

///
/// The Backbone for the methods to work
/// 
T _handleResponse<T>({
  http.Response response,
  Function(String body) bodyParser,
  T Function(dynamic parsedBody) onOk,
  T Function(http.Response response) onResponse,
}) {
  if (response.statusCode == HttpStatus.ok) {
    return onOk != null
        ? onOk(bodyParser(response.body))
        : onResponse(response);
  } else {
    return onResponse(response);
  }
}
