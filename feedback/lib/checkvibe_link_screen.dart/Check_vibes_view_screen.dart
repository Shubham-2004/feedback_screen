import 'dart:ui';
import 'package:feedback/checkvibe_link_screen.dart/vibe_check.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CheckVibesViewScreen extends StatefulHookConsumerWidget {
  final List<VibeCheck> vibeCheckList;
  final int initialIndex;
  final String avatar;
  final String title;

  const CheckVibesViewScreen({
    super.key,
    required this.vibeCheckList,
    required this.initialIndex,
    required this.avatar,
    required this.title,
  });

  @override
  ConsumerState<CheckVibesViewScreen> createState() => _CheckVibesViewState();
}

class _CheckVibesViewState extends ConsumerState<CheckVibesViewScreen>
    with SingleTickerProviderStateMixin {
  late int _currentIndex;
  late PageController _pageController;
  late PageController _secondPageController;
  late AnimationController _animationController;
  bool _isPaused = false;
  bool _isVideoLoading = true;
  bool _isVideoReady = false;
  YoutubePlayerController? _youtubeController;
  double _pausedProgress = 0.0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _secondPageController = PageController(initialPage: _currentIndex);
    _pageController = PageController(initialPage: _currentIndex);
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 10));
    _animationController.addStatusListener(_animationStatusListener);
    _animationController.addListener(() {
      setState(() {});
    });

    _isVideoLoading = _currentIndex >= widget.vibeCheckList.length;
    if (!_isVideoLoading) {
      _initializeYoutubePlayer();
    }
  }

  void _initializeYoutubePlayer() {
    final vibeCheck = widget.vibeCheckList[_currentIndex];
    if (vibeCheck.type == "video" && vibeCheck.url != null) {
      final videoId = YoutubePlayer.convertUrlToId(vibeCheck.url!);
      if (videoId != null) {
        setState(() {
          _isVideoReady = false;
          _isVideoLoading = true;
          _pausedProgress = 0.0;
        });

        _youtubeController = YoutubePlayerController(
          initialVideoId: videoId,
          flags: const YoutubePlayerFlags(
            mute: false,
            hideThumbnail: true,
            showLiveFullscreenButton: true,
            autoPlay: true,
            hideControls: true,
            disableDragSeek: false,
            enableCaption: false,
            controlsVisibleAtStart: true,
            isLive: false,
            useHybridComposition: true,
          ),
        );
        _youtubeController!.addListener(_onYoutubePlayerStateChange);
      }
    }
  }

  void _onYoutubePlayerStateChange() {
    if (_youtubeController!.value.isReady && !_isVideoReady) {
      setState(() {
        _isVideoReady = true;
        _isVideoLoading = false;
      });
      _startAnimation();
    }

    if (_youtubeController!.value.playerState == PlayerState.ended) {
      _moveToNext();
    }
  }

  void _animationStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _moveToNext();
    }
  }

  void _startAnimation() {
    if (!_isPaused && !_isVideoLoading && _isVideoReady) {
      _animationController.forward(from: _pausedProgress);
    }
  }

  void _pauseVideo() {
    if (_youtubeController != null &&
        _youtubeController!.value.isPlaying &&
        _isVideoReady) {
      _youtubeController!.pause();
      _pausedProgress = _animationController.value;
      _animationController.stop();
      setState(() {
        _isPaused = true;
      });
    }
  }

  void _resumeVideo() {
    if (_youtubeController != null &&
        !_youtubeController!.value.isPlaying &&
        _isVideoReady) {
      _youtubeController!.play();
      _animationController.forward(from: _pausedProgress);
      setState(() {
        _isPaused = false;
      });
    }
  }

  Future<void> _disposeYoutubeController() async {
    if (_youtubeController != null) {
      _youtubeController!.removeListener(_onYoutubePlayerStateChange);
      _youtubeController!.pause();
      _youtubeController = null;
    }
  }

  void _moveToPrevious() async {
    if (_currentIndex > 0) {
      await _disposeYoutubeController();
      setState(() {
        _currentIndex--;
        _secondPageController.jumpToPage(_currentIndex);
        _pageController.jumpToPage(_currentIndex);
        _isVideoLoading = true;
        _isVideoReady = false;
      });
      _animationController.reset();
      _initializeYoutubePlayer();
    }
  }

  void _moveToNext() async {
    if (_currentIndex < (widget.vibeCheckList.length - 1)) {
      await _disposeYoutubeController();
      setState(() {
        _currentIndex++;
        _secondPageController.jumpToPage(_currentIndex);
        _pageController.jumpToPage(_currentIndex);
        _isVideoLoading = true;
        _isVideoReady = false;
      });
      _animationController.reset();
      _initializeYoutubePlayer();
    } else {
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _secondPageController.dispose();
    _animationController.dispose();
    _disposeYoutubeController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 221, 170, 170),
        body: GestureDetector(
          onVerticalDragStart: (details) {},
          onVerticalDragUpdate: (details) {
            if (details.delta.dy > 20) {
              Navigator.of(context).pop();
            }
          },
          onLongPressStart: (_) => _pauseVideo(),
          onLongPressEnd: (_) => _resumeVideo(),
          onTapUp: (details) {
            if (details.localPosition.dx <
                MediaQuery.of(context).size.width / 2) {
              _moveToPrevious();
            } else {
              _moveToNext();
            }
          },
          child: Stack(
            children: [
              PageView.builder(
                controller: _secondPageController,
                itemCount: widget.vibeCheckList.length,
                itemBuilder: (context, index) {
                  return ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(color: Colors.black),
                  );
                },
              ),
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              PageView.builder(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.vibeCheckList.length,
                itemBuilder: (context, index) {
                  final VibeCheck vibeCheck = widget.vibeCheckList[index];
                  if (vibeCheck.type == "video" && _youtubeController != null) {
                    return YoutubePlayer(
                      controller: _youtubeController!,
                      showVideoProgressIndicator: false,
                      onReady: () {
                        setState(() {
                          _isVideoReady = true;
                          _isVideoLoading = false;
                        });
                        _startAnimation();
                      },
                    );
                  } else {
                    return Center(child: Image.network(vibeCheck.url ?? ""));
                  }
                },
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Row(
                  children: List.generate(
                    widget.vibeCheckList.length,
                    (index) {
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: LinearProgressIndicator(
                            value: _currentIndex > index
                                ? 1.0
                                : (_currentIndex == index && _isVideoReady
                                    ? _animationController.value
                                    : 0.0),
                            backgroundColor: Colors.grey.withOpacity(0.4),
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.white),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                top: 15,
                left: 10,
                right: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
