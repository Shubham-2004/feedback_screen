import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';

class ReadSmsScreen extends StatefulWidget {
  const ReadSmsScreen({super.key});

  @override
  State<ReadSmsScreen> createState() => _ReadSmsScreenState();
}

class _ReadSmsScreenState extends State<ReadSmsScreen> {
  final Telephony telephony = Telephony.instance;
  String otpReceived = "";

  void startListening() {
    telephony.listenIncomingSms(
      onNewMessage: (SmsMessage message) {
        final otp = extractOtp(message.body!);
        setState(() {
          otpReceived = otp;
        });
      },
      listenInBackground: false,
    );
  }

  String extractOtp(String message) {
    final regex = RegExp(r'\b\d{4,6}\b');
    final match = regex.firstMatch(message);
    return match != null ? match.group(0)! : "No OTP found";
  }

  @override
  void initState() {
    super.initState();
    requestPermissions();
  }

  void requestPermissions() async {
    bool? result = await telephony.requestSmsPermissions;
    if (result != null && result) {
      startListening();
    } else {
      print("Permissions not granted");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xff2d9cdb),
          title: const Text('OTP Tab')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text("OTP Received: $otpReceived"),
        ),
      ),
    );
  }
}
