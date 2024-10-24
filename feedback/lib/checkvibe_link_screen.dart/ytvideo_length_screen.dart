import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YouTubeVideoLengthScreen extends StatefulWidget {
  @override
  _YouTubeVideoLengthScreenState createState() =>
      _YouTubeVideoLengthScreenState();
}

class _YouTubeVideoLengthScreenState extends State<YouTubeVideoLengthScreen> {
  final TextEditingController _urlController = TextEditingController();
  YoutubePlayerController? _youtubeController;
  String? _videoDuration;

  void _loadVideo() {
    final videoId = YoutubePlayer.convertUrlToId(_urlController.text);

    if (videoId != null) {
      _youtubeController = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
        ),
      );

      // Listen for when the video player is ready and fetch video duration
      _youtubeController!.addListener(() {
        if (_youtubeController!.value.isReady) {
          final duration = _youtubeController!.metadata.duration;
          setState(() {
            _videoDuration = '${duration.inSeconds} seconds';
          });
        }
      });
    } else {
      setState(() {
        _videoDuration = "Invalid YouTube URL";
      });
    }
  }

  @override
  void dispose() {
    _youtubeController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('YouTube Video Length Finder'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Enter YouTube Video URL:'),
            TextField(
              controller: _urlController,
              decoration: const InputDecoration(
                hintText: 'YouTube video URL',
              ),
              keyboardType: TextInputType.url,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loadVideo,
              child: const Text('Get Video Length'),
            ),
            const SizedBox(height: 20),
            if (_videoDuration != null)
              Text(
                'Video Duration: $_videoDuration',
                style: const TextStyle(fontSize: 18),
              ),
            const SizedBox(height: 20),
            // Display YouTube player if the video is loaded
            if (_youtubeController != null)
              YoutubePlayer(
                controller: _youtubeController!,
                showVideoProgressIndicator: true, // Show progress bar
              ),
          ],
        ),
      ),
    );
  }
}
