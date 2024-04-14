import 'package:youtube_explode_dart/youtube_explode_dart.dart' as yt;
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

void main() async {
  var yt = YoutubeExplode();

  Video video = await yt.videos.get(
      'https://www.youtube.com/watch?v=STJi_eQK6FI&list=RDSTJi_eQK6FI&start_radio=1'); // Returns a Video instance.

  var title = video.title; // "Scamazon Prime"
  var author = video.author; // "Jim Browning"
  var duration = video.duration; // Instance of Duration - 0:19:48.00000

  print('$title $author $duration');
}
