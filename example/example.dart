import 'package:fanoos_http/fanoos_http.dart';

class BlogClient {
  static const host = 'https://www.blog.com/api/v1';

  Future<Post> getPost(int id) => httpGet(
        url: '$host/posts/$id',
        onOk: (json) => Post.fromJson(json),
      );

  Future<List<Post>> getPosts() {
    return httpGet<List<Post>>(
      url: '$host/posts',
      onOk: (json) {
        return json['posts'].map((p) => Post.fromJson(p)).toList();
      },
      onResponse: (response) {
        throw response.reasonPhrase;
      },
    );
  }

  Future<bool> postComment(
    int postId,
    String name,
    String comment,
  ) {
    return httpPost(
      url: '$host/posts/$postId/comments',
      body: {
        'name': name,
        'comment': comment,
      },
      onOk: (_) => true,
      // any other response other than 200
      onResponse: (_) => false,
    );
  }

  Future<String> getRawMarkdown(int postId) => httpGet(
        url: '$host/posts/$postId/md',
        bodyParser: plainString,
        onOk: (md) => md,
        onResponse: (response) => throw response.reasonPhrase,
      );
}

class Post {
  final String id, title;

  Post(this.id, this.title);

  factory Post.fromJson(Map json) {
    return Post(json['id'], json['title']);
  }
}

class Comment {
  final String name, body;

  Comment(this.name, this.body);

  Map toJson() => {
        'name': name,
        'body': body,
      };
}
