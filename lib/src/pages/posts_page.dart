import 'package:echo/src/data/post.dart';
import 'package:echo/src/services/posts_service.dart';
import 'package:flutter/material.dart';

class PostsPage extends StatefulWidget {
  PostsPage({Key? key}) : super(key: key);

  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {

  final PostsService _postsService = PostsService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Posts"),),body: Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: FutureBuilder(
          future: _postsService.getPosts(), // async work
          builder: (BuildContext context, AsyncSnapshot<List<PostResponseModel>> snapshot) {
             switch (snapshot.connectionState) {
               case ConnectionState.waiting: return Center(child: CircularProgressIndicator(),);
               default:
                 if (snapshot.hasError)
                    return Text('Error: ${snapshot.error}');
                 else
                return ListView(
                  children: makeListWidget(snapshot.data!),
                );;
              }
           },
          ),
    ),
);
  }

  makeListWidget(List<PostResponseModel> data) {
   return  data.map<Widget>((PostResponseModel post) {
      return Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Card(
          elevation: 2.0,
          child: ListTile(
            onLongPress: (){
              
            },
              title: Text(
                post.title,
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
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
                onPressed: ()  {
                 
                },
                icon: Icon(
                  Icons.remove_circle,
                  color: Theme.of(context).accentColor,
                ),
              ),),
        ),
      );
    }).toList();
  }
  }
