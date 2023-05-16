import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class HappyScreen extends StatefulWidget {
  const HappyScreen({super.key});

  @override
  State<HappyScreen> createState() => _HappyScreenState();
}

class _HappyScreenState extends State<HappyScreen> {
  late FirebaseAnalytics analytics;
  @override
  void initState() {
    analytics = FirebaseAnalytics.instance;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Happy Happy!'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('I\'m happy!'),
          onPressed: () {
            analytics.logEvent(name: 'Happy');
          },
        ),
      ),
    );
  }
}
