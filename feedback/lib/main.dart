import 'package:feedback/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Player',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: SafeArea(child: HomeScreen()),
      ),
    );
  }
}

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
//   WebViewController? _webViewController;
//   String? _currentUrl;
//   String? _videoDuration; // To store video duration

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
//     _youtubeController?.dispose();
//     _videoPlayerController?.dispose();
//     _chewieController?.dispose();
//     _webViewController = null;
//     _videoDuration = null; // Reset video duration
//   }

//   void _initializePlayer(String url) {
//     setState(() {
//       _disposePlayer();
//       _currentUrl = url;
//       _videoDuration = null; // Reset duration when a new video is loaded
//     });

//     // If it's a YouTube URL
//     if (YoutubePlayer.convertUrlToId(url) != null) {
//       final videoId = YoutubePlayer.convertUrlToId(url)!;
//       _youtubeController = YoutubePlayerController(
//         initialVideoId: videoId,
//         flags: const YoutubePlayerFlags(
//           autoPlay: true,
//           mute: false,
//         ),
//       );

//       // Fetch video duration when the YouTube player is ready
//       _youtubeController!.addListener(() {
//         if (_youtubeController!.value.isReady) {
//           final duration = _youtubeController!.metadata.duration;
//           setState(() {
//             _videoDuration = '${duration.inSeconds} seconds';
//           });
//         }
//       });
//     }
//     // If it's a network video
//     else if (url.startsWith('http') || url.startsWith('https')) {
//       _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(url));
//       _videoPlayerController!.initialize().then((_) {
//         setState(() {
//           _chewieController = ChewieController(
//             videoPlayerController: _videoPlayerController!,
//             autoPlay: true,
//             looping: false,
//           );

//           // Get duration from the VideoPlayerController
//           final duration = _videoPlayerController!.value.duration;
//           _videoDuration = '${duration.inSeconds} seconds';
//         });
//       }).catchError((_) {
//         _initializeWebView(url);
//       });
//     }
//   }

//   // WebView for unsupported URLs
//   void _initializeWebView(String url) {
//     _webViewController = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..loadRequest(Uri.parse(url));
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
//         // Display the video player
//         Expanded(
//           child: _buildVideoPlayer(),
//         ),
//         // Display the video duration in a Container
//         if (_videoDuration != null)
//           Container(
//             padding: const EdgeInsets.all(16.0),
//             color: Colors.grey[300],
//             child: Text(
//               'Video Duration: $_videoDuration',
//               style: const TextStyle(fontSize: 18),
//             ),
//           ),
//       ],
//     );
//   }

//   Widget _buildVideoPlayer() {
//     if (_currentUrl == null) {
//       return const Center(child: Text('Enter a URL and press "Load Video"'));
//     }

//     // YouTube player
//     if (_youtubeController != null) {
//       return YoutubePlayer(controller: _youtubeController!);
//     }
//     // Video player with Chewie
//     else if (_chewieController != null &&
//         _chewieController!.videoPlayerController.value.isInitialized) {
//       return Chewie(controller: _chewieController!);
//     }
//     // WebView for unsupported URLs
//     else if (_webViewController != null) {
//       return WebViewWidget(controller: _webViewController!);
//     }
//     // Loading indicator while the video is initializing
//     else {
//       return const Center(child: CircularProgressIndicator());
//     }
//   }
// }

// import 'package:feedback/checkvibe_link_screen.dart/check_vibes_view_screen.dart';
// import 'package:feedback/checkvibe_link_screen.dart/vibe_check.dart';
// import 'package:feedback/checkvibe_link_screen.dart/ytvideo_length_screen.dart';
// import 'package:feedback/contact/flutter_contact.dart';
// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// void main() {
//   runApp(const ProviderScope(child: MyApp()));
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Check Vibes App',
//       theme: ThemeData.light(),
//       // home: const HomeScreen(),
//       home: ContactListScreen(),
//     );
//   }
// }

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final vibeCheckList = [
//       VibeCheck(
//           type: "video",
//           url: 'https://youtube.com/shorts/Aw7JckLSUC8?si=RwnVic2iPj_mz5Eg'),
//       VibeCheck(
//           type: "video",
//           url: 'https://youtube.com/shorts/GkmIjfaBh78?si=ueYd-gI5mfWrYwNg'),
//       VibeCheck(
//           type: "video",
//           url: 'https://youtube.com/shorts/vgcxQU4nXUs?si=bIxmrAzi75k5eLi7'),
//       VibeCheck(
//           type: "video",
//           url: 'https://youtube.com/shorts/qD5lJr82ldc?si=vf0f2GXB-_UKMsU8'),
//     ];

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home'),
//       ),
//       body: GridView.builder(
//         padding: const EdgeInsets.all(16.0),
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 4,
//           childAspectRatio: 1,
//           crossAxisSpacing: 16.0,
//           mainAxisSpacing: 16.0,
//         ),
//         itemCount: vibeCheckList.length,
//         itemBuilder: (context, index) {
//           final videoUrl = vibeCheckList[index].url;
//           final videoId = YoutubePlayer.convertUrlToId(videoUrl!);

//           // Construct the thumbnail URL
//           final thumbnailUrl = videoId != null
//               ? 'https://img.youtube.com/vi/$videoId/0.jpg'
//               : '';

//           return GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => CheckVibesViewScreen(
//                     vibeCheckList: vibeCheckList,
//                     initialIndex: index,
//                     avatar: "https://www.example.com/avatar.jpg",
//                     title: "Check Vibes",
//                   ),
//                 ),
//               );
//             },
//             child: ClipOval(
//               child: Container(
//                 color: Colors.grey, // Placeholder color
//                 child: thumbnailUrl.isNotEmpty
//                     ? Image.network(
//                         thumbnailUrl,
//                         fit: BoxFit.cover,
//                         width: 100, // Specify width for the circular avatar
//                         height: 100, // Specify height for the circular avatar
//                       )
//                     : const Center(
//                         child: CircularProgressIndicator(),
//                       ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
