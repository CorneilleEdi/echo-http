
import 'package:flutter/material.dart';

import 'pages/posts_page.dart';

class EchoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Echo',
      theme: ThemeData(
      
        primarySwatch: Colors.indigo,
      ),
      home: PostsPage()
    );
  }
}