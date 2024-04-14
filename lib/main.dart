import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:yt_downloader/views/view_navigation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import './screens/screen_search.dart';
import './screens/screen_query.dart';
import 'models/query.dart'; // Import your ScreenQuery widget

void main() async {
  await Hive.initFlutter();

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
