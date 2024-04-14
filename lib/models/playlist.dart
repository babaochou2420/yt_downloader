import 'package:youtube_explode_dart/youtube_explode_dart.dart' as yt;

class Playlist {
  final String? author;
  final String description;
  // final Engagement engagement;
  // final PlaylistId id;
  final String? thumbnails;
  final String title;
  final String url;
  final int? videoCount;

  Playlist({
    required this.description,
    // required this.engagement,
    // required this.id,
    required this.title,
    required this.url,
    this.author,
    this.thumbnails,
    this.videoCount,
  });

  factory Playlist.fromJson(yt.Playlist playlist) {
    return Playlist(
      description: playlist.description,
      title: playlist.title,
      url: playlist.url,
      author: playlist.author,
      thumbnails: playlist.thumbnails.highResUrl,
      videoCount: playlist.videoCount,
    );
  }
}
