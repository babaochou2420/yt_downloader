import 'package:youtube_explode_dart/youtube_explode_dart.dart' as yt;
import 'package:uuid/uuid.dart'; // Import the uuid package

class Query {
  final String queryId; // Add queryId property
  final String thumbnailUrl;
  final String videoName;
  final String videoUrl;
  double downloadProgress; // Add downloadProgress property

  Query({
    required this.queryId, // Initialize queryId in the constructor
    required this.thumbnailUrl,
    required this.videoName,
    required this.videoUrl,
    this.downloadProgress = 0.0, // Set default value for downloadProgress
  });

  factory Query.fromVideo(yt.Video video) {
    final uuid = Uuid(); // Create an instance of Uuid
    final queryId = uuid.v4(); // Generate UUID v4
    return Query(
      queryId: queryId, // Assign generated UUID to queryId
      thumbnailUrl: video.thumbnails.highResUrl,
      videoName: video.title,
      videoUrl: video.url,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'queryId': queryId, // Include queryId in JSON output
      'thumbnailUrl': thumbnailUrl,
      'videoName': videoName,
      'videoUrl': videoUrl,
      'downloadProgress': downloadProgress,
    };
  }
}
