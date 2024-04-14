import 'dart:async';
import 'dart:io';

import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import '../utils/logger.dart';

// Initialize the YoutubeExplode instance.
final yt = YoutubeExplode();

Future<void> main() async {
  stdout.writeln('Type the video id or url: ');

  final url = stdin.readLineSync()!.trim();

  // Check if the URL is a playlist URL.
  if (url.contains('playlist')) {
    final playlistId = extractPlaylistId(url);
    if (playlistId != null) {
      await downloadPlaylist(playlistId);
    } else {
      stderr.writeln('Invalid playlist URL.');
    }
  } else {
    // Save the video to the download directory.
    Directory('downloads').createSync();

    // Download the single video.
    await download(url);
  }

  yt.close();
  exit(0);
}

String? extractPlaylistId(String url) {
  final regex = RegExp(r'list=([a-zA-Z0-9_-]+)');
  final match = regex.firstMatch(url);
  return match?.group(1);
}

Future<void> downloadPlaylist(String playlistId) async {
  // Get the playlist videos using PlaylistClient.
  final videos = await yt.playlists.getVideos(playlistId).toList();

  logger.w(videos);

  // Loop through each video in the playlist and download.
  for (var video in videos) {
    await download(video.id.value);
  }
}

Future<void> download(String id) async {
  // Get video metadata.
  final video = await yt.videos.get(id);

  // Get the video manifest.
  final manifest = await yt.videos.streamsClient.getManifest(id);
  final streams = manifest.audioOnly;

  // Get the audio track with the highest bitrate.
  final audio = streams.withHighestBitrate();
  final audioStream = yt.videos.streamsClient.get(audio);

  // Compose the file name removing the unallowed characters in windows.
  final fileName = '${video.title}.${audio.container.name}'
      .replaceAll(r'\', '')
      .replaceAll('/', '')
      .replaceAll('*', '')
      .replaceAll('?', '')
      .replaceAll('"', '')
      .replaceAll('<', '')
      .replaceAll('>', '')
      .replaceAll(':', '')
      .replaceAll('|', '');
  final file = File('downloads/$fileName');

  // Delete the file if exists.
  if (file.existsSync()) {
    file.deleteSync();
  }

  // Open the file in writeAppend.
  final output = file.openWrite(mode: FileMode.writeOnlyAppend);

  // Track the file download status.
  final len = audio.size.totalBytes;
  var count = 0;

  // Create the message and set the cursor position.
  final msg = 'Downloading ${video.title}.${audio.container.name}';
  stdout.writeln(msg);

  // Listen for data received.
  await for (final data in audioStream) {
    // Keep track of the current downloaded data.
    count += data.length;

    // Calculate the current progress.
    final progress = ((count / len) * 100).toStringAsFixed(2);

    print(progress);

    // Write to file.
    output.add(data);
  }
  await output.close();
}
