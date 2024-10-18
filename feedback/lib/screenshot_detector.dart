import 'package:flutter/material.dart';
import 'package:screen_capture_event/screen_capture_event.dart';

class ScreenshotDetector extends StatefulWidget {
  const ScreenshotDetector({Key? key}) : super(key: key);

  @override
  State<ScreenshotDetector> createState() => _ScreenshotDetectorState();
}

class _ScreenshotDetectorState extends State<ScreenshotDetector> {
  final ScreenCaptureEvent screenCaptureEvent = ScreenCaptureEvent();
  String _screenshotPath = "No screenshot captured yet";
  String activePage = "None";

  @override
  void initState() {
    super.initState();
    screenCaptureEvent.addScreenShotListener((f) {
      setState(() {
        _screenshotPath = "Screenshot captured on: $activePage";
      });
    });

    screenCaptureEvent.preventAndroidScreenShot(false);
    screenCaptureEvent.watch();
  }

  @override
  void dispose() {
    screenCaptureEvent.dispose();
    super.dispose();
  }

  void _navigateToPage(BuildContext context, String page) {
    setState(() {
      activePage = page;
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          switch (page) {
            case 'P1':
              return const P1();
            case 'P2':
              return const P2();
            case 'P3':
              return const P3();
            case 'P4':
              return const P4();
            case 'P5':
              return const P5();
            default:
              return const ScreenshotDetector();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Screenshot Detector"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Take a screenshot to test.',
              style: const TextStyle(color: Colors.black, fontSize: 18),
            ),
            const SizedBox(height: 20),
            Text(
              _screenshotPath,
              style: const TextStyle(color: Colors.blue, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => _navigateToPage(context, 'P1'),
              child: const Text('Go to Page 1'),
            ),
            ElevatedButton(
              onPressed: () => _navigateToPage(context, 'P2'),
              child: const Text('Go to Page 2'),
            ),
            ElevatedButton(
              onPressed: () => _navigateToPage(context, 'P3'),
              child: const Text('Go to Page 3'),
            ),
            ElevatedButton(
              onPressed: () => _navigateToPage(context, 'P4'),
              child: const Text('Go to Page 4'),
            ),
            ElevatedButton(
              onPressed: () => _navigateToPage(context, 'P5'),
              child: const Text('Go to Page 5'),
            ),
          ],
        ),
      ),
    );
  }
}

// Page 1
class P1 extends StatelessWidget {
  const P1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Page 1"),
      ),
      body: const Center(
        child: Text("You are on Page 1"),
      ),
    );
  }
}

// Page 2
class P2 extends StatelessWidget {
  const P2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Page 2"),
      ),
      body: const Center(
        child: Text("You are on Page 2"),
      ),
    );
  }
}

// Page 3
class P3 extends StatelessWidget {
  const P3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Page 3"),
      ),
      body: const Center(
        child: Text("You are on Page 3"),
      ),
    );
  }
}

// Page 4
class P4 extends StatelessWidget {
  const P4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Page 4"),
      ),
      body: const Center(
        child: Text("You are on Page 4"),
      ),
    );
  }
}

// Page 5
class P5 extends StatelessWidget {
  const P5({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Page 5"),
      ),
      body: const Center(
        child: Text("You are on Page 5"),
      ),
    );
  }
}
