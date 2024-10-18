// import 'dart:ui';
// import 'package:feedback/app_update.dart';
// import 'package:feedback/share_bottomsheet.dart';
// import 'package:flutter/material.dart';

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   bool isBottomSheetOpen = false;

//   void _openBottomSheet(BuildContext context) {
//     setState(() {
//       isBottomSheetOpen = true;
//     });

//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (context) => SharePopup(),
//     ).whenComplete(() {
//       setState(() {
//         isBottomSheetOpen = false;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Center(
//             child: Text(
//               'This is the home screen',
//               style: TextStyle(fontSize: 24),
//             ),
//           ),
//           if (isBottomSheetOpen)
//             BackdropFilter(
//               filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
//               child: Container(
//                 color: Colors.black.withOpacity(0.6),
//               ),
//             ),
//           Positioned(
//             bottom: 50,
//             right: 50,
//             child: FloatingActionButton(
//               onPressed: () => _openBottomSheet(context),
//               child: Icon(Icons.update),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => context.go('/profile/11820070'),
              child: const Text('Go to Profile with ID: 11820070'),
            ),
          ],
        ),
      ),
    );
  }
}
