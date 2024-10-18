import 'dart:async';
import 'package:feedback/event_card.dart';
import 'package:flutter/material.dart';

class CardSlider extends StatefulWidget {
  @override
  _CardSliderState createState() => _CardSliderState();
}

class _CardSliderState extends State<CardSlider> {
  final PageController _pageController =
      PageController(viewportFraction: 0.8); // Adjusted to show adjacent cards
  int _currentPage = 0;
  Timer? _timer;

  final List<Map<String, String>> events = [
    {
      'name': 'The Navratri Project 2024',
      'location': 'Ahmedabad',
      'date': '9th, 10th, 11th October',
    },
    {
      'name': 'Garba Night 2024',
      'location': 'Surat',
      'date': '5th October',
    },
    {
      'name': 'Dandiya Event 2024',
      'location': 'Rajkot',
      'date': '7th October',
    },
    {
      'name': 'Garba Festival 2024',
      'location': 'Vadodara',
      'date': '8th October',
    },
    {
      'name': 'Navratri Bash 2024',
      'location': 'Mumbai',
      'date': '10th October',
    },
  ];

  late List<Map<String, String>> duplicatedEvents;

  @override
  void initState() {
    super.initState();
    duplicatedEvents = List.from(events)..addAll(events);
    _startAutoSlide();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      if (_currentPage < duplicatedEvents.length - 1) {
        _currentPage++;
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 800),
          curve: Curves.ease,
        );
      } else {
        _currentPage = events.length;
        _pageController.jumpToPage(_currentPage);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Featured Events'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 230,
            child: PageView.builder(
              controller: _pageController,
              itemCount: duplicatedEvents.length,
              onPageChanged: (int index) {
                setState(() {
                  _currentPage = index;
                });
                if (_currentPage == duplicatedEvents.length - 1) {
                  _currentPage = events.length - 1;
                  _pageController.jumpToPage(_currentPage);
                }
              },
              itemBuilder: (context, index) {
                final event = duplicatedEvents[index];
                return EventCard(
                  eventName: event['name']!,
                  location: event['location']!,
                  date: event['date']!,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(events.length, (index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  width: _currentPage % events.length == index ? 20 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentPage % events.length == index
                        ? Color(0xff2d9cdb)
                        : Colors.grey[300],
                    borderRadius: _currentPage % events.length == index
                        ? BorderRadius.circular(12)
                        : BorderRadius.circular(4),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
