import 'package:flutter/material.dart';
import 'package:yt_downloader/views/view_navigation.dart';
import './screens/screen_search.dart';
import './screens/screen_query.dart'; // Import your ScreenQuery widget

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ViewNavigation(), // Set ScreenQuery as the homepage
    );
  }
}
