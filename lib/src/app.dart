
import 'package:flutter/material.dart';

class EchoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Echo',
      theme: ThemeData(
      
        primarySwatch: Colors.indigo,
      ),
      home: Scaffold(appBar: AppBar(title: Text("Echo"),),),
    );
  }
}