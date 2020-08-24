import 'dart:convert';

import 'package:fanoos_http/fanoos_http.dart';
import 'package:test/test.dart';
import 'test.dart';

void main() {
  group('httpGet', () {

    test('just get', () async {
      return await httpGet(url: 'https://reqres.in/api/users');
    });

    test(
      'invalid url',
      () async => await httpGet(
          url: 'https://asdasd.com/asdas',
          onOk: (body) {
            shouldThisLineBeCalled(false);
          },
          onError: (e) {
            shouldThisLineBeCalled(true);
          }),
    );

    test('onOk', () async {
      return await httpGet(
          url: 'https://reqres.in/api/users/2',
          bodyParser: jsonDecode,
          onOk: (body) {
            shouldThisLineBeCalled(true);
          },
          onResponse: (r) {
            shouldThisLineBeCalled(false);
          });
    });
  });
}

