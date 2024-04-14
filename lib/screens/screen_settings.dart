import 'package:flutter/material.dart';

class ScreenSettings extends StatefulWidget {
  @override
  _ScreenSettingsState createState() => _ScreenSettingsState();
}

class _ScreenSettingsState extends State<ScreenSettings> {
  // Variables to store the selected bitrate, format, and metadata options
  String selectedBitrate = '128 kbps';
  String selectedFormat = 'MP4';
  bool useThumbnails = true;
  bool useAlbumArt = true;

  // List of available bitrates and formats
  List<String> bitrates = ['128 kbps', '256 kbps', '320 kbps'];
  List<String> formats = ['MP4', 'MP3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: Text('Bitrate'),
            trailing: DropdownButton<String>(
              value: selectedBitrate,
              onChanged: (String? newValue) {
                setState(() {
                  selectedBitrate = newValue!;
                });
              },
              items: bitrates.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          ListTile(
            title: Text('Format'),
            trailing: DropdownButton<String>(
              value: selectedFormat,
              onChanged: (String? newValue) {
                setState(() {
                  selectedFormat = newValue!;
                });
              },
              items: formats.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          CheckboxListTile(
            title: Text('Use Thumbnails'),
            value: useThumbnails,
            onChanged: (bool? newValue) {
              setState(() {
                useThumbnails = newValue!;
              });
            },
          ),
          CheckboxListTile(
            title: Text('Playlist as Album'),
            value: useAlbumArt,
            onChanged: (bool? newValue) {
              setState(() {
                useAlbumArt = newValue!;
              });
            },
          ),
        ],
      ),
    );
  }
}
