import 'package:flutter/material.dart';

class StoryCacheImage extends StatelessWidget {
  final String image; // The URL of the image
  final bool isLandscape;

  const StoryCacheImage({
    Key? key,
    required this.image,
    this.isLandscape = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        width:
            isLandscape ? double.infinity : MediaQuery.of(context).size.width,
        height: isLandscape ? MediaQuery.of(context).size.height / 2 : 250.0,
        child: FadeInImage(
          placeholder: const AssetImage(
              'assets/images/placeholder.png'), // Placeholder image
          image: NetworkImage(image), // Loading the image from the network
          fit: BoxFit.cover,
          imageErrorBuilder: (context, error, stackTrace) {
            // Display an error icon if the image fails to load
            return const Center(
              child: Icon(Icons.error, color: Colors.red, size: 40),
            );
          },
        ),
      ),
    );
  }
}
