// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';

// class DemoAppState extends State<DemoApp> {
//   String imageUrl = '';
//   String imageId = '';
//   String imageAuthor = '';
//   String imageDownloadUrl = '';
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _fetchImageData();
//   }

//   Future<void> _fetchImageData() async {
//     final response =
//         await http.get(Uri.parse('https://picsum.photos/id/1/info'));
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       setState(() {
//         imageUrl = data['download_url'];
//         imageId = data['id'];
//         imageAuthor = data['author'];
//         imageDownloadUrl = data['url'];
//         isLoading = false;
//       });
//     } else {
//       setState(() {
//         isLoading = false;
//       });
//       throw Exception('Failed to load image data');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Share Plus Plugin Demo',
//       theme: ThemeData(
//         useMaterial3: true,
//         colorSchemeSeed: const Color(0x9f4376f8),
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Share Plus Plugin Demo'),
//           elevation: 4,
//         ),
//         body: Builder(
//           builder: (BuildContext context) {
//             return isLoading
//                 ? const Center(child: CircularProgressIndicator())
//                 : SingleChildScrollView(
//                     padding: const EdgeInsets.all(24),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisSize: MainAxisSize.min,
//                       children: <Widget>[
//                         imageUrl.isNotEmpty
//                             ? Image.network(imageUrl)
//                             : const Text('Failed to load image'),
//                         const SizedBox(height: 16),
//                         Text('Image ID: $imageId'),
//                         const SizedBox(height: 8),
//                         Text('Author: $imageAuthor'),
//                         const SizedBox(height: 32),
//                         ElevatedButton(
//                           onPressed: () =>
//                               _shareImage(context), // Use this context
//                           child: const Text('Share Image and Details'),
//                         ),
//                       ],
//                     ),
//                   );
//           },
//         ),
//       ),
//     );
//   }

//   void _shareImage(BuildContext context) async {
//     final box = context.findRenderObject() as RenderBox?;
//     final scaffoldMessenger = ScaffoldMessenger.of(context);

//     try {
//       final uri = Uri.parse(imageUrl);
//       final response = await http.get(uri);
//       final bytes = response.bodyBytes;

//       final tempDir = await getTemporaryDirectory();
//       final tempFile = File('${tempDir.path}/image_$imageId.jpg');
//       await tempFile.writeAsBytes(bytes);

//       final xFile = XFile(tempFile.path);

//       final shareResult = await Share.shareXFiles(
//         [xFile],
//         text:
//             'Heyy \n \nJust found this amazing event happening in $imageId on AllEvents.🙌🏻\n\nWe should totally go! 🤩\n Check it out - $imageDownloadUrl',
//         sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
//       );

//       scaffoldMessenger.showSnackBar(getResultSnackBar(shareResult));
//     } catch (error) {
//       scaffoldMessenger.showSnackBar(
//         SnackBar(content: Text('Failed to share image: $error')),
//       );
//     }
//   }

//   SnackBar getResultSnackBar(ShareResult result) {
//     return SnackBar(
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text("Share result: ${result.status}"),
//           if (result.status == ShareResultStatus.success)
//             Text("Shared to: ${result.raw}")
//         ],
//       ),
//     );
//   }
// }
