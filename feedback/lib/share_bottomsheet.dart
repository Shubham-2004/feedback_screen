import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class SharePopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 20),
          Image.asset(
            "assets/rectangle.png",
            height: 4,
            width: 60,
          ),
          SizedBox(height: 23),
          Image.asset(
            "assets/Share the event, double the memories ✨.png",
            height: 21,
            width: 320,
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(right: 35.0),
            child: Text(
              'You will be notified when the friends join the event',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 12,
                color: Color.fromRGBO(0, 0, 0, 0.5),
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Material(
                  color: Colors.transparent,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: InkWell(
                      splashColor: Colors.grey.withOpacity(0.5),
                      onTap: () => _launchWp(),
                      child: Container(
                        height: 65,
                        width: 65,
                        alignment: Alignment.center,
                        child: Image.asset(
                          "assets/whatsapp.png",
                          height: 54,
                          width: 60,
                        ),
                      ),
                    ),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: Colors.grey.withOpacity(0.5),
                    onTap: () => _launchSMS(),
                    child: Container(
                      height: 65,
                      width: 65,
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/message.png",
                        height: 54,
                        width: 60,
                      ),
                    ),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: Colors.grey[400]!.withOpacity(0.5),
                    onTap: () => _launchFacebook(),
                    child: Container(
                      height: 65,
                      width: 65,
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/facebook.png",
                        height: 54,
                        width: 60,
                      ),
                    ),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: Colors.grey[400]!.withOpacity(0.5),
                    onTap: () => _launchx(),
                    child: Container(
                      height: 65,
                      width: 65,
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/x.png",
                        height: 54,
                        width: 60,
                      ),
                    ),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: Colors.grey[400]!.withOpacity(0.5),
                    onTap: () => _shareContent(context),
                    child: Container(
                      height: 65,
                      width: 65,
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/more.png",
                        height: 54,
                        width: 60,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 135,
                  child: ElevatedButton(
                    onPressed: () {
                      _shareContent(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/share_icon.png',
                          height: 14,
                          width: 14,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Share Link',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(245, 251, 255, 1),
                      foregroundColor: Colors.white,
                      minimumSize: Size(0, 10),
                      padding: EdgeInsets.symmetric(vertical: 4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                      splashFactory: InkRipple.splashFactory,
                    ),
                  ),
                ),
                SizedBox(
                  width: 135,
                  child: ElevatedButton(
                    onPressed: () {
                      const link = 'https://example.com';
                      Clipboard.setData(ClipboardData(text: link));
                      Fluttertoast.showToast(
                        msg: 'Link copied to clipboard!',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black.withOpacity(0.7),
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/copy_icon.png',
                          height: 14,
                          width: 14,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Copy Link',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(245, 251, 255, 1),
                      foregroundColor: Colors.white,
                      minimumSize: Size(0, 10),
                      padding: EdgeInsets.symmetric(vertical: 4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

// whatsapp://send?text=Your%20pre-filled%20message%20here
  Future<void> _launchWp() async {
    if (await launchUrl(
      Uri.parse('whatsapp://send?text=Your%20pre-filled%20message%20here'),
    )) {
    } else {
      throw 'Could not launch WhatsApp';
    }
  }

  Future<void> _launchSMS() async {
    final Uri smsUri = Uri(scheme: 'sms');
    if (await launchUrl(smsUri)) {
    } else {
      throw 'Could not launch SMS';
    }
  }

  Future<void> _launchFacebook() async {
    final Uri fbAppUri = Uri.parse(
        'https://www.facebook.com/dialog/share?app_id=123456789&display=popup&href=https%3A%2F%2Fexample.com&quote=Check%20out%20this%20cool%20website!');
    if (await launchUrl(fbAppUri)) {
      await launchUrl(fbAppUri, mode: LaunchMode.externalApplication);
    } else {
      final Uri fbWebUri = Uri.parse('https://www.facebook.com');
      if (await launchUrl(fbWebUri)) {
        await launchUrl(fbWebUri, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch Facebook';
      }
    }
  }

  Future<void> _launchx() async {
    final Uri xUri = Uri.parse('twitter://post');
    if (await launchUrl(xUri)) {
      await launchUrl(xUri, mode: LaunchMode.externalApplication);
    } else {
      final Uri webUri = Uri.parse('https://www.x.com');
      if (await launchUrl(webUri)) {
        await launchUrl(webUri, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch Twitter';
      }
    }
  }

  void _shareContent(BuildContext context) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    Share.share(
      'Check out this amazing event!',
      subject: 'Event Invitation',
      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
    );
  }
}
