import 'package:fanoos_http/fanoos_http.dart';
import 'package:test/test.dart';

import 'test.dart';

void main() {
  group('httpPatch', () {
    test('simple', () async => httpPut(
      url: 'https://reqres.in/api/users/2',
      body: {
        'email': 'aligator@test.com',
        'password': 'idontusepassword',
      },
      onError: (e) => shouldThisLineBeCalled(false),
    ));
  });
}