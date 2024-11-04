import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              foregroundImage: Image.asset('assets/images/icon.png').image,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'Ride the Wave of Productivity',
            ),
            SizedBox(
              height: 8,
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
