import 'package:youtube_explode_dart/youtube_explode_dart.dart' as yt;

class Media {
  final String author;
  final yt.ChannelId channelId;
  final String description;
  final Duration? duration;
  final yt.Engagement engagement;
  final String id;
  final bool hasWatchPage;
  final bool isLive;
  final List<String> keywords;
  final DateTime? publishDate;
  final String thumbnail;
  final String title;
  final DateTime? uploadDate;
  final String? uploadDateRaw;
  final String url;

  Media({
    required this.author,
    required this.channelId,
    required this.description,
    required this.duration,
    required this.engagement,
    required this.id,
    required this.hasWatchPage,
    required this.isLive,
    required this.keywords,
    required this.publishDate,
    required this.thumbnail,
    required this.title,
    required this.uploadDate,
    required this.uploadDateRaw,
    required this.url,
  });

  factory Media.fromVideo(yt.Video video) {
    return Media(
      author: video.author,
      channelId: video.channelId,
      description: video.description,
      duration: video.duration,
      engagement: video.engagement,
      id: video.id.value,
      hasWatchPage: video.hasWatchPage,
      isLive: video.isLive,
      keywords: video.keywords.toList(),
      publishDate: video.publishDate,
      thumbnail: video.thumbnails.highResUrl,
      title: video.title,
      uploadDate: video.uploadDate,
      uploadDateRaw: video.uploadDateRaw,
      url: video.url,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'author': author,
      'channelId': channelId.value,
      'description': description,
      'duration': duration?.inSeconds,
      'engagement': {
        'viewCount': engagement.viewCount,
        'likeCount': engagement.likeCount,
        'dislikeCount': engagement.dislikeCount,
      },
      'id': id,
      'hasWatchPage': hasWatchPage,
      'isLive': isLive,
      'keywords': keywords,
      'publishDate': publishDate?.toIso8601String(),
      'thumbnail': thumbnail,
      'title': title,
      'uploadDate': uploadDate?.toIso8601String(),
      'uploadDateRaw': uploadDateRaw,
      'url': url,
    };
  }
}
