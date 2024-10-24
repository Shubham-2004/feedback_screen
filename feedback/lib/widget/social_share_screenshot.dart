import 'package:flutter/material.dart';

class SocialShareScreenshot extends StatelessWidget {
  final String assetPath;
  final String label;
  final VoidCallback onTap;

  const SocialShareScreenshot({
    Key? key,
    required this.assetPath,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 60,
        width: 60,
        alignment: Alignment.center,
        child: Column(
          children: [
            Image.asset(
              assetPath,
              height: 30,
              width: 30,
            ),
            const SizedBox(height: 5.0),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xff777777),
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
