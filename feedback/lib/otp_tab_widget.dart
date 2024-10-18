import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';

class OtpTabWidget extends StatefulWidget {
  const OtpTabWidget({super.key});

  @override
  State<OtpTabWidget> createState() => _OtpTabWidgetState();
}

class _OtpTabWidgetState extends State<OtpTabWidget> {
  final Telephony telephony = Telephony.instance;
  String otpReceived = "";
  final TextEditingController phoneController = TextEditingController();
  final List<TextEditingController> otpControllers =
      List.generate(6, (index) => TextEditingController());
  final List<bool> otpFilled = List.generate(6, (index) => false);

  void startListening() {
    telephony.listenIncomingSms(
      onNewMessage: (SmsMessage message) {
        final otp = extractOtp(message.body!);
        setState(() {
          otpReceived = otp;
          fillOtpFields(otp);
        });
      },
      listenInBackground: false,
    );
  }

  String extractOtp(String message) {
    final regex = RegExp(r'\b\d{6}\b');
    final match = regex.firstMatch(message);
    return match != null ? match.group(0)! : "No OTP found";
  }

  void fillOtpFields(String otp) {
    if (otp.length == 6) {
      for (int i = 0; i < 6; i++) {
        otpControllers[i].text = otp[i];
        otpFilled[i] = true;
      }
      setState(() {});
    }
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

  void handleOtpInput(int index, String value) {
    if (value.isNotEmpty) {
      otpFilled[index] = true;
      if (index < 5) {
        FocusScope.of(context).nextFocus();
      }
    } else {
      otpFilled[index] = false;
      if (index > 0) {
        FocusScope.of(context).previousFocus();
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff2d9cdb),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Text(
              "Enter OTP",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(6, (index) {
                return SizedBox(
                  width: 45,
                  height: 50,
                  child: Center(
                    child: TextField(
                      cursorColor: otpFilled[index]
                          ? Colors.white
                          : const Color(0xff2d9cdb),
                      keyboardType: TextInputType.number,
                      controller: otpControllers[index],
                      textAlign: TextAlign.center,
                      onChanged: (value) => handleOtpInput(index, value),
                      decoration: InputDecoration(
                        filled: otpFilled[index],
                        fillColor: otpFilled[index]
                            ? const Color(0xff2d9cdb)
                            : Colors.transparent,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: otpFilled[index]
                                ? const Color(0xff2d9cdb)
                                : Colors.grey,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: const Color(0xff2d9cdb)),
                        ),
                        counterText: "",
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 12),
                      ),
                      style: TextStyle(
                        fontSize: 20,
                        color: otpFilled[index] ? Colors.white : Colors.black,
                      ),
                      textAlignVertical: TextAlignVertical.center,
                      maxLength: 1,
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Get OTP"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff2d9cdb),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 40),
                padding: const EdgeInsets.symmetric(vertical: 4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
