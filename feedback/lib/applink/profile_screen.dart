import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String profileId;
  const ProfileScreen({super.key, required this.profileId});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile: $profileId'),
      ),
      body: Center(
        child: Text('Viewing profile for user ID: $profileId'),
      ),
    );
  }
}
