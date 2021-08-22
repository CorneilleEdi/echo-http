
import 'package:dio/dio.dart';

import '../data/post.dart';
import 'posts_service_interceptor.dart';

class PostsService {
  final String baseApiUrl = "https://jsonplaceholder.typicode.com/posts";

  Dio client = Dio();

  PostsService() {
    client.options.baseUrl = baseApiUrl;
    client.interceptors.add(PostsServiceInterceptor());
  }

  Future<List<PostResponseModel>> getPosts() async {
    final Response response = await client.get("/");

    final posts = response.data
        .map<PostResponseModel>((json) => PostResponseModel.fromJson(json))
        .toList();

    return posts;
  }

  Future<PostResponseModel> getPost(int postId) async {
    final Response response = await client.get("/$postId");
    return PostResponseModel.fromJson(response.data);
  }
}
