import 'package:flutter/material.dart';

class ScreenSettings extends StatefulWidget {
  @override
  _ScreenSettingsState createState() => _ScreenSettingsState();
}

class _ScreenSettingsState extends State<ScreenSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: Text(
          'Settings Page Content',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
