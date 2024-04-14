import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/query.dart';

class ScreenQuery extends StatefulWidget {
  @override
  _ScreenQueryState createState() => _ScreenQueryState();
}

class _ScreenQueryState extends State<ScreenQuery> {
  late Future<List<dynamic>> _loadQueriesFuture;

  @override
  void initState() {
    super.initState();
    _loadQueriesFuture = _openBoxAndLoadQueries();
  }

  Future<List<dynamic>> _openBoxAndLoadQueries() async {
    var queryBox = await Hive.openBox<dynamic>('queries');
    return queryBox.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Downloaded Video Queries'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _loadQueriesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading data ${snapshot.error}'));
          } else if (snapshot.hasData) {
            List<dynamic> queries = snapshot.data!;
            return ListView.builder(
              itemCount: queries.length,
              itemBuilder: (context, index) {
                final dynamic query = queries[index];
                final String videoName = query['videoName'] ?? '';
                final String thumbnailUrl = query['thumbnailUrl'] ?? '';
                final double downloadProgress =
                    query['downloadProgress'] ?? 0.0;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        videoName,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                        thumbnailUrl,
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 100,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Download Progress: $downloadProgress%',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LinearProgressIndicator(
                        value: downloadProgress / 100,
                      ),
                    ),
                    Divider(), // Add a divider between each item
                  ],
                );
              },
            );
          } else {
            return Center(child: Text('No downloaded video queries'));
          }
        },
      ),
    );
  }
}
