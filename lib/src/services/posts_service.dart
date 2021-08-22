import 'dart:convert';

import 'package:echo/src/services/posts_service_interceptor.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http/http.dart';

import '../data/post.dart';

class PostsService {
  final String baseApiUrl = "https://jsonplaceholder.typicode.com/posts";

  final Client client = InterceptedClient.build(interceptors: [
    PostsServiceInterceptor(),
  ]);

  Future<List<PostResponseModel>> getPosts() async {
    Uri url = Uri.parse(baseApiUrl);
    final Response response = await client.get(url);

    final rawData = response.body;

    final decoded = jsonDecode(rawData).cast<Map<String, dynamic>>();

    final posts = decoded
        .map<PostResponseModel>((json) => PostResponseModel.fromJson(json))
        .toList();

    return posts;
  }

  Future<PostResponseModel> getPost(int postId) async {
    Uri url = Uri.parse(baseApiUrl + "/$postId");
    final Response response = await client.get(url);

    final rawData = response.body;

    final decoded = jsonDecode(rawData);

    return PostResponseModel.fromJson(decoded);
  }
}
