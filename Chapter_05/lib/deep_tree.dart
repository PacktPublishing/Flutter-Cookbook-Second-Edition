import 'package:flutter/material.dart';

class DeepTree extends StatelessWidget {
  const DeepTree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Let\'s find out how deep the rabbit hole goes'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                FlutterLogo(),
                Text('It\'s all widgets'),
              ],
            ),
            Expanded(child: Container(color: Colors.purple,)),
            const Text('Flutter is amazing'),
          ],
        ),
      ),
    );
  }
}