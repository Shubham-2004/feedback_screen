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
          InkWell(
            onTap: () {
              // Add your onTap functionality for Message here
            },
            child: Container(
              height: 60,
              width: 60,
              alignment: Alignment.center,
              child: Column(
                children: [
                  Image.asset(
                    "assets/message_new.png",
                    height: 30,
                    width: 30,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 5.0),
                    child: Text(
                      'Message',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xff777777),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              // Add your onTap functionality for WhatsApp here
            },
            child: Container(
              height: 60,
              width: 60,
              alignment: Alignment.center,
              child: Column(
                children: [
                  Image.asset(
                    "assets/wp_new.png",
                    height: 30,
                    width: 30,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 5.0),
                    child: Text(
                      'Whatsapp',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xff777777),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              // Add your onTap functionality for Facebook here
            },
            child: Container(
              height: 60,
              width: 60,
              alignment: Alignment.center,
              child: Column(
                children: [
                  Image.asset(
                    "assets/fb_new.png",
                    height: 30,
                    width: 30,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 5.0),
                    child: Text(
                      'Facebook',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xff777777),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              // Add your onTap functionality for More here
            },
            child: Container(
              height: 60,
              width: 60,
              alignment: Alignment.center,
              child: Column(
                children: [
                  Image.asset(
                    "assets/more_new.png",
                    height: 30,
                    width: 30,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 5.0),
                    child: Text(
                      'More',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xff777777),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
