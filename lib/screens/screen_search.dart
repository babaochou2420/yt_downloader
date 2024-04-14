import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:yt_downloader/screens/screen_query.dart';

import '../models/query.dart';
import '../utils/logger.dart';

//
//
//
//
//
// Widget searchResult
// - show the info of youtube media searched
//
// Widget

class ScreenSearch extends StatefulWidget {
  @override
  _ScreenSearchState createState() => _ScreenSearchState();
}

class _ScreenSearchState extends State<ScreenSearch> {
  var yt = YoutubeExplode();
  TextEditingController _urlController = TextEditingController();
  String _searchResult = '';
  Video? video;
  String? globalVideoUrl;
  Function(int)? updateBadgeCount;
  int downloadCount = 0;

  void _searchVideo() async {
    var videoUrl = _urlController.text.trim();

    if (videoUrl.isEmpty) {
      setState(() {
        _searchResult = 'Please enter a valid URL';
        video = null;
      });
      return;
    }

    try {
      video = await yt.videos.get(videoUrl);

      logger.i(
          'Search Result\nTitle: ${video!.title}\nAuthor: ${video!.author}\nDuration ${video!.duration}\nThumbnail: ${video!.thumbnails.highResUrl}');

      setState(() {
        _searchResult = '''
          Title: ${video!.title}
          Author: ${video!.author}
          Duration: ${_formatDuration(video!.duration)}
        ''';
      });
    } catch (e) {
      setState(() {
        _searchResult = 'Error: $e';
        video = null;
      });
    }
  }

  String _formatDuration(Duration? duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration!.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '${duration.inHours}:$twoDigitMinutes:$twoDigitSeconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _urlController,
              decoration: InputDecoration(
                labelText: 'Enter YouTube URL',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: _searchVideo,
              child: Text('Search'),
            ),
            SizedBox(height: 20.0),
            searchResult(),
            SizedBox(height: 20.0),
            if (_searchResult.isNotEmpty) downloadButton(),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  Widget downloadButton() {
    var mediaQuery = Query.fromVideo(video!);

    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ScreenQuery(videoQueries: [Query.fromVideo(video!)]),
          ),
        );
      },
      child: Text('Download Video'),
    );
  }

  Widget searchResult() {
    if (kIsWeb) {
      return Expanded(
        child: _searchResult.isNotEmpty
            ? Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Thumbnail on the left
                      Image.network(
                        video != null
                            ? video!.thumbnails.highResUrl
                            : '', // Use actual thumbnail URL from video
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(width: 20.0),
                      // Title, author, and duration on the right in a column
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              video != null ? video!.title : '',
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              video != null ? video!.author : '',
                              style: TextStyle(fontSize: 16.0),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              video != null
                                  ? _formatDuration(video!.duration)
                                  : '',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Container(), // Placeholder container when search result is empty
      );
    }
    // Mobile
    else {
      return Expanded(
        child: _searchResult.isNotEmpty
            ? Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Thumbnail on the left
                      Image.network(
                        video != null
                            ? video!.thumbnails.highResUrl
                            : '', // Use actual thumbnail URL from video
                        fit: BoxFit.cover,
                        height: 160,
                      ),
                      SizedBox(width: 20.0),
                      Row(children: [
                        // Title, author, and duration on the right in a column
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                video != null ? video!.title : '',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                video != null ? video!.author : '',
                                style: TextStyle(fontSize: 16.0),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                video != null
                                    ? _formatDuration(video!.duration)
                                    : '',
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ],
                  ),
                ),
              )
            : Container(),
      );
    }
  }
}
