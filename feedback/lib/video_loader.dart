// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
// import 'package:chewie/chewie.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
// import 'package:url_launcher/url_launcher.dart';

// class VideoPlayerWidget extends StatefulWidget {
//   const VideoPlayerWidget({Key? key}) : super(key: key);

//   @override
//   _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
// }

// class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
//   late TextEditingController _urlController;
//   VideoPlayerController? _videoPlayerController;
//   ChewieController? _chewieController;
//   YoutubePlayerController? _youtubeController;
//   String? _currentUrl;

//   @override
//   void initState() {
//     super.initState();
//     _urlController = TextEditingController();
//   }

//   @override
//   void dispose() {
//     _urlController.dispose();
//     _disposePlayer();
//     super.dispose();
//   }

//   void _disposePlayer() {
//     _videoPlayerController?.dispose();
//     _chewieController?.dispose();
//     _youtubeController?.dispose();
//   }

//   void _initializePlayer(String url) {
//     setState(() {
//       _disposePlayer(); // Dispose of previous controllers
//       _currentUrl = url;
//     });

//     if (YoutubePlayer.convertUrlToId(url) != null) {
//       // Initialize YouTube player
//       final videoId = YoutubePlayer.convertUrlToId(url)!;
//       _youtubeController = YoutubePlayerController(
//         initialVideoId: videoId,
//         flags: const YoutubePlayerFlags(
//           autoPlay: true,
//           mute: false,
//         ),
//       );
//     } else if (url.startsWith('http') || url.startsWith('https')) {
//       // Initialize other video sources
//       _videoPlayerController = VideoPlayerController.network(url);
//       _videoPlayerController!.initialize().then((_) {
//         setState(() {
//           _chewieController = ChewieController(
//             videoPlayerController: _videoPlayerController!,
//             autoPlay: true,
//             looping: false,
//           );
//         });
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: TextField(
//             controller: _urlController,
//             decoration: InputDecoration(
//               labelText: 'Enter video URL',
//               suffixIcon: IconButton(
//                 icon: const Icon(Icons.clear),
//                 onPressed: () => _urlController.clear(),
//               ),
//             ),
//           ),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             if (_urlController.text.isNotEmpty) {
//               _initializePlayer(_urlController.text);
//             }
//           },
//           child: const Text('Load Video'),
//         ),
//         const SizedBox(height: 20),
//         Expanded(
//           child: _buildVideoPlayer(),
//         ),
//       ],
//     );
//   }

//   Widget _buildVideoPlayer() {
//     if (_currentUrl == null) {
//       return const Center(child: Text('Enter a URL and press "Load Video"'));
//     }

//     if (_youtubeController != null) {
//       return YoutubePlayer(controller: _youtubeController!);
//     } else if (_chewieController != null) {
//       return Chewie(controller: _chewieController!);
//     } else if (_currentUrl!.startsWith('http') ||
//         _currentUrl!.startsWith('https')) {
//       // For unsupported video sources, provide a button to open in an external app
//       return Center(
//         child: ElevatedButton(
//           onPressed: () => _launchURL(_currentUrl!),
//           child: const Text('Open video in external app'),
//         ),
//       );
//     } else {
//       return const Center(child: CircularProgressIndicator());
//     }
//   }

//   void _launchURL(String url) async {
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }
// }
