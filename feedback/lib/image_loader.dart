import 'package:flutter/material.dart';

class ImageLoader extends StatefulWidget {
  const ImageLoader({super.key});

  @override
  _ImageLoaderState createState() => _ImageLoaderState();
}

class _ImageLoaderState extends State<ImageLoader> {
  String imageUrl = '';
  ImageProvider? imageProvider;

  void _updateImage() {
    setState(() {
      imageProvider = imageUrl.isEmpty ? null : NetworkImage(imageUrl);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Loader'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) {
                imageUrl = value;
                _updateImage();
              },
              decoration: const InputDecoration(
                hintText: 'Enter image URL',
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: imageProvider != null
                  ? Image(image: imageProvider!)
                  : const Center(child: Text('No image selected')),
            ),
          ],
        ),
      ),
    );
  }
}
