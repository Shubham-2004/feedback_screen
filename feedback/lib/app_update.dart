import 'package:flutter/material.dart';

class AppUpdate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          )),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 10.0,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(224, 224, 224, 1),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(4),
                          bottomLeft: Radius.circular(4),
                          bottomRight: Radius.circular(4),
                        )),
                    width: 60,
                    height: 4,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 187.5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                )),
                child: Image.asset(
                  'assets/ae_new.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          Text(
            "We've gotten better!",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Color.fromRGBO(0, 0, 0, 1),
            ),
          ),
          SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'A brand new version of the AllEvents app is available in the play store.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                color: Color.fromRGBO(0, 0, 0, 0.5),
              ),
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(bottom: 35.0, left: 25, right: 25),
            child: ElevatedButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/reload.png',
                    height: 16,
                    width: 16,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Update Now',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff2d9cdb),
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 40), //
                padding: EdgeInsets.symmetric(vertical: 4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
