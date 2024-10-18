// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
// import 'package:chewie/chewie.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Video Player',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const Scaffold(
//         body: SafeArea(child: VideoPlayerWidget()),
//       ),
//     );
//   }
// }

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
//   }

//   void _initializePlayer(String url) {
//     setState(() {
//       _disposePlayer();
//       _currentUrl = url;
//     });

//     if (YoutubePlayer.convertUrlToId(url) != null) {
//       final videoId = YoutubePlayer.convertUrlToId(url)!;
//       _youtubeController = YoutubePlayerController(
//         initialVideoId: videoId,
//         flags: const YoutubePlayerFlags(
//           autoPlay: true,
//           mute: false,
//         ),
//       );
//     } else if (url.startsWith('http') || url.startsWith('https')) {
//       _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(url));
//       _videoPlayerController!.initialize().then((_) {
//         setState(() {
//           _chewieController = ChewieController(
//             videoPlayerController: _videoPlayerController!,
//             autoPlay: true,
//             looping: false,
//           );
//         });
//       }).catchError((_) {
//         _initializeWebView(url);
//       });
//     }
//   }

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
//     } else if (_chewieController != null &&
//         _chewieController!.videoPlayerController.value.isInitialized) {
//       return Chewie(controller: _chewieController!);
//     } else if (_webViewController != null) {
//       return WebViewWidget(controller: _webViewController!);
//     } else {
//       return const Center(child: CircularProgressIndicator());
//     }
//   }
// }

import 'package:feedback/home_screen.dart';
import 'package:feedback/profile_screen.dart';
import 'package:feedback/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:app_links/app_links.dart';

void main() => runApp(const MyApp());
final GoRouter _router = GoRouter(
  initialLocation: '/splash',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
    ),
    GoRoute(
      path: '/profile/:id',
      builder: (BuildContext context, GoRouterState state) {
        final String profileId = state.pathParameters['id'] ?? 'Unknown';
        return ProfileScreen(profileId: profileId);
      },
    ),
    GoRoute(
      path: '/splash',
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
    ),
  ],
);

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appLinks = AppLinks();
  bool _initialUriHandled = false;
  @override
  void initState() {
    super.initState();
    _handleIncomingLinks();
    _handleInitialUri();
  }

  void _handleIncomingLinks() {
    _appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        _handleLink(uri, initial: false);
      }
    }, onError: (Object err) {
      print('Error occurred: $err');
    });
  }

  Future<void> _handleInitialUri() async {
    try {
      final uri = await _appLinks.getInitialLink();
      if (!_initialUriHandled) {
        _initialUriHandled = true;
        _handleLink(uri, initial: true);
      }
    } on FormatException catch (err) {
      print('Error parsing initial link: $err');
    }
  }

  void _handleLink(Uri? uri, {required bool initial}) {
    if (uri == null) {
      if (initial) {
        _router.go('/splash');
      }
      return;
    }
    String nextRoute = '/';
    if (uri.host == 'allevents.in' &&
        uri.pathSegments.length >= 2 &&
        uri.pathSegments[0] == 'profile') {
      final profileId = uri.pathSegments[1];
      nextRoute = '/profile/$profileId';
    }
    _router.go(nextRoute);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}
