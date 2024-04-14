import 'package:flutter/material.dart';

import '../models/query.dart';

class ScreenQuery extends StatefulWidget {
  final List<Query>? videoQueries;

  const ScreenQuery({Key? key, this.videoQueries}) : super(key: key);

  @override
  _ScreenQueryState createState() => _ScreenQueryState();
}

class _ScreenQueryState extends State<ScreenQuery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Downloaded Video Queries'),
      ),
      body: ListView.builder(
        itemCount: widget.videoQueries?.length ?? 0,
        itemBuilder: (context, index) {
          final Query query = widget.videoQueries![index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  query.videoName,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(query.thumbnailUrl,
                        width: 100, height: 100),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Download Progress: ${query.downloadProgress}%',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 4.0),
                          LinearProgressIndicator(
                              value: query.downloadProgress / 100),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Divider(), // Add a divider between each item
            ],
          );
        },
      ),
    );
  }
}
