import 'package:echo/src/data/post.dart';
import 'package:flutter/material.dart';

import '../services/posts_service.dart';

class PostDetailsPage extends StatefulWidget {
  final postId;
  PostDetailsPage({Key? key, required this.postId}) : super(key: key);

  @override
  _PostDetailsPageState createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage> {

  final PostsService _postsService = PostsService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Post ${widget.postId}")),body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: FutureBuilder(
          future: _postsService.getPost(widget.postId), // async work
          builder: (BuildContext context,
              AsyncSnapshot<PostResponseModel> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );
              default:
                if (snapshot.hasError)
                  return Text('Error: ${snapshot.error}');
                else
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(snapshot.data!.title.toString(),style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),),
                      Text(snapshot.data!.body.toString()),
                      Text(snapshot.data!.id.toString()),
                    ],
                  );
    
            }
          },
        ),)

  );
  }

}
