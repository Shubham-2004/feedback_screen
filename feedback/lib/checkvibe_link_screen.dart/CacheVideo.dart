// import 'package:feedback/checkvibe_link_screen.dart/vibe_check.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
// import 'package:cached_video_player_plus/cached_video_player_plus.dart';
// import 'package:flutter/material.dart';
// import 'dart:developer';

// class CacheVideo extends StatefulWidget {
//   final VibeCheck videoUrl;
//   final BoxFit? fit;
//   final bool? isFromAvatar;
//   final void Function(CachedVideoPlayerPlusController)? onVideoReady;

//   const CacheVideo({
//     super.key,
//     this.isFromAvatar,
//     required this.videoUrl,
//     this.fit,
//     this.onVideoReady,
//   });

//   @override
//   State<CacheVideo> createState() => _CacheVideoState();
// }

// class _CacheVideoState extends State<CacheVideo> {
//   CachedVideoPlayerPlusController? _controller;
//   YoutubePlayerController? _ytController;
//   bool _isVideoReady = false;
//   bool _isYouTubeVideo = false;

//   @override
//   void initState() {
//     super.initState();
//     _initializeController();
//   }

//   Future<void> _initializeController() async {
//     if (widget.videoUrl.url == null) {
//       log('Video URL is null');
//       return;
//     }

//     // Check if the URL is a YouTube video
//     final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl.url!);
//     if (videoId != null) {
//       // Initialize YouTube player
//       _ytController = YoutubePlayerController(
//         initialVideoId: videoId,
//         flags: const YoutubePlayerFlags(autoPlay: false),
//       );
//       setState(() {
//         _isYouTubeVideo = true;
//         _isVideoReady = true;
//       });
//     } else {
//       // Initialize regular video player for non-YouTube videos
//       final controller = CachedVideoPlayerPlusController.networkUrl(
//         Uri.parse(widget.videoUrl.url!),
//       );

//       try {
//         await controller.initialize();
//         if (mounted) {
//           setState(() {
//             _controller = controller;
//             _isVideoReady = true;
//           });
//           if (widget.isFromAvatar != true) {
//             controller.play();
//           } else {
//             controller.pause();
//           }
//           widget.onVideoReady?.call(controller);
//         } else {
//           await controller.dispose();
//         }
//       } catch (e) {
//         log('Error initializing video: $e');
//         rethrow;
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (!_isVideoReady) {
//       if (widget.isFromAvatar == true) {
//         return ClipOval(
//           child: Image.asset(
//             'assets/loading.gif',
//             fit: BoxFit.cover,
//           ),
//         );
//       } else {
//         return const Center(child: CircularProgressIndicator());
//       }
//     }

//     if (_isYouTubeVideo) {
//       return YoutubePlayer(
//         controller: _ytController!,
//         showVideoProgressIndicator: true,
//         onReady: () {
//           if (widget.isFromAvatar != true) {
//             _ytController!.play();
//           }
//         },
//       );
//     } else {
//       Widget videoWidget = CachedVideoPlayerPlus(_controller!);

//       if (widget.isFromAvatar == true) {
//         _controller?.pause();
//         return ClipOval(
//           child: SizedBox(
//             width: _controller!.value.size.width,
//             height: _controller!.value.size.height,
//             child: videoWidget,
//           ),
//         );
//       } else {
//         return FittedBox(
//           fit: widget.fit ?? BoxFit.contain,
//           child: SizedBox(
//             width: _controller!.value.size.width,
//             height: _controller!.value.size.height,
//             child: videoWidget,
//           ),
//         );
//       }
//     }
//   }

//   @override
//   void dispose() {
//     _controller?.dispose();
//     _ytController?.dispose();
//     super.dispose();
//   }
// }
