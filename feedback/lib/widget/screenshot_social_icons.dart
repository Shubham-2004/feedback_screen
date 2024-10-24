import 'package:feedback/widget/social_share_screenshot.dart';
import 'package:flutter/material.dart';

class ScreenshotSocialIcons extends StatelessWidget {
  const ScreenshotSocialIcons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SocialShareScreenshot(
            assetPath: "assets/message_new.png",
            label: "Message",
            onTap: () {},
          ),
          SocialShareScreenshot(
            assetPath: "assets/wp_new.png",
            label: "Whatsapp",
            onTap: () {},
          ),
          SocialShareScreenshot(
            assetPath: "assets/fb_new.png",
            label: "Facebook",
            onTap: () {},
          ),
          SocialShareScreenshot(
            assetPath: "assets/more_new.png",
            label: "More",
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
