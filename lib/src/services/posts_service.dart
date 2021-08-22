
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../data/post.dart';

class PostsService {
  final String baseApiUrl = "https://jsonplaceholder.typicode.com/posts";

 Future<List<PostResponseModel>> getPosts() async {
    Uri url = Uri.parse(baseApiUrl);
    final http.Response response =  await http.get(url);

    final rawData  = response.body;

    final decoded =  jsonDecode(rawData).cast<Map<String, dynamic>>();

    final posts =  decoded.map<PostResponseModel>((json) => PostResponseModel.fromJson(json)).toList();

    return posts;
  }

  Future<PostResponseModel> getPost(int postId) async {
     Uri url = Uri.parse(baseApiUrl+"/$postId");
    final http.Response response =  await http.get(url);

     final rawData  = response.body;

    final decoded =  jsonDecode(rawData);

    return PostResponseModel.fromJson(decoded);
  }
  
}