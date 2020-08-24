import 'dart:convert';

import 'package:fanoos_http/fanoos_http.dart';
import 'package:test/test.dart';
import 'test.dart';

void main() {
  group('httpPost', () {
    test(
      'simple',
      () async => await httpPost(
        url: 'https://reqres.in/api/users',
        bodyParser: jsonDecode,
        body: {
          'name': 'aligator',
          'job': 'programmer',
        },
      ),
    );

    test(
      'successful request',
      () async => await httpPost(
        url: 'https://reqres.in/api/register',
        bodyParser: jsonDecode,
        body: {
          'email': 'aligator@test.com',
          'password': 'idontusepassword',
        },
        onOk: (json) => shouldThisLineBeCalled(true),
      ),
    );

    test(
      'unsuccessful login',
      () async => await httpPost(
        url: 'https://reqres.in/api/login',
        body: {'email': 'aligator@test.com'},
        onOk: (json) => shouldThisLineBeCalled(false),
        onResponse: (r) {
          expect(r.statusCode, 400);
          shouldThisLineBeCalled(true);
        },
      ),
    );
  });
}
