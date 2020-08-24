# fanoos_http

A concise and robust Http client for Dart.

Using `fanoos_http` you can write concise client code without the need for using reflection or code generation.

## Usage

A simple usage example:

```dart
import 'package:fanoos_http/fanoos_http.dart';

const host = 'https://www.blog.com/api/v1';

Future<Post> getPost(int id) => httpGet(
      url: '$host/posts/$id',
      bodyParser: jsonDecode,
      onOk: (json) => Post.fromJson(json),
    );


Future<List<Post>> getPosts() => httpGet(
      url: '$host/posts',
      bodyParser: jsonDecode,
      onOk: (json) => json['posts'].map((p) => Post.fromJson(p)).toList(),
    );

```

For the full example, please check the example tab.