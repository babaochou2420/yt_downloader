// import 'package:youtube_explode_dart/youtube_explode_dart.dart' as yt;
//
// Future<void> downloadVideo(String videoUrl) async {
//   var ytExplode = yt.YoutubeExplode();
//
//   try {
//     var video = await ytExplode.videos.get(videoUrl);
//
//     // Get the highest quality stream for the video
//     var streamInfo = video.audioStreams.getBest();
//
//     // Set the file path where you want to save the downloaded video
//     var filePath = 'downloaded_video.${streamInfo.container.name}';
//
//     // Open a file for writing
//     var file = File(filePath);
//
//     // Open a stream to the video's content
//     var videoStream = await ytExplode.videos.streamsClient.get(streamInfo);
//
//     // Write the video stream to the file
//     await file.writeAsBytes(await videoStream.bytes.toList());
//
//     print('Video downloaded successfully.');
//   } catch (e) {
//     print('Error downloading video: $e');
//   } finally {
//     ytExplode.close();
//   }
// }
//
// void main() {
//   var videoUrl = 'https://youtu.be/YMqYcoc-TDU?si=mEgeKkPHt8e0PV8n';
//   downloadVideo(videoUrl);
// }
