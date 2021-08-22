import 'package:echo/src/pages/post_details_page.dart';
import 'package:flutter/material.dart';

import '../data/post.dart';
import '../services/posts_service.dart';

class PostsPage extends StatefulWidget {
  PostsPage({Key? key}) : super(key: key);

  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final PostsService _postsService = PostsService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Posts"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: FutureBuilder(
          future: _postsService.getPosts(), // async work
          builder: (BuildContext context,
              AsyncSnapshot<List<PostResponseModel>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );
              default:
                if (snapshot.hasError)
                  return Text('Error: ${snapshot.error}');
                else
                  return ListView(
                    children: makeListWidget(snapshot.data!),
                  );
                ;
            }
          },
        ),
      ),
    );
  }

  makeListWidget(List<PostResponseModel> data) {
    return data.map<Widget>((PostResponseModel post) {
      return Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Card(
          elevation: 2.0,
          child: ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PostDetailsPage(postId: post.id),
                  ));
            },
            title: Text(
              post.title,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              maxLines: 1,
            ),
            subtitle: Text(
              post.title,
              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
              maxLines: 2,
            ),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.remove_circle,
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
        ),
      );
    }).toList();
  }
}
