import 'package:fanoos_http/fanoos_http.dart';

class BlogClient {
  static const host = 'https://www.blog.com/api/v1';

  Future<Post> getPost(int id) => httpGet(
        url: '$host/posts/$id',
        onOk: (json) => Post.fromJson(json),
      );

  Future<List<Post>> getPosts() => httpGet(
        url: '$host/posts',
        onOk: (json) => json['posts'].map((p) => Post.fromJson(p)).toList(),
      );

  Future<bool> postComment(int postId, Comment comment) => httpPost(
        url: '$host/posts/$postId/comment',
        body: comment.toJson(),
        onOk: (_) => true,
        onResponse: (_) => false,
      );

  Future<String> getRawMarkdown(int postId) => httpGet(
        url: '$host/posts/$postId/md',
        bodyParser: plainString,
        onOk: (md) => md,
        onResponse: (response) => response.reasonPhrase,
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
