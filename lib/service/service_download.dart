import 'dart:async';
import 'package:dio/dio.dart'; // Add Dio package for HTTP requests
import 'package:hive/hive.dart';
import '../models/query.dart';
import '../utils/logger.dart';

class DownloadService {
  final Dio _dio = Dio(); // Create Dio instance for HTTP requests

  Future<void> downloadVideo(Query query) async {
    final Box<dynamic> queryBox = Hive.box<dynamic>('queries');

    // Download video logic (replace with your actual download logic)
    int totalSize = 100; // Total file size in bytes (example value)
    int downloaded = 0; // Amount of data downloaded

    while (downloaded < totalSize) {
      await Future.delayed(Duration(seconds: 1)); // Simulate download delay

      // Update the downloaded amount with a random chunk size
      downloaded += 10; // Simulate downloading 10 bytes per second

      // Calculate download progress as a percentage
      double progress = (downloaded / totalSize) * 100;

      // Update Hive with download progress
      Query newQuery = Query(
        videoUrl: query.videoUrl,
        downloadProgress: progress,
        thumbnailUrl: query.thumbnailUrl, queryId: query.queryId,
        videoName: query.videoName, // You can set thumbnail URL if needed
      );

      queryBox.put(
          query.queryId, newQuery.toJson()); // Update or add the query to Hive

      logger.w(
          '${query.queryId} Download Progress: ${progress.toStringAsFixed(2)}%');
    }

    print('Download Complete!');
  }
}
