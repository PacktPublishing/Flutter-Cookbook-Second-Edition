import 'package:flutter/material.dart';

class NavigationSecond extends StatefulWidget {
  const NavigationSecond({super.key});

  @override
  State<NavigationSecond> createState() => _NavigationSecondState();
}

class _NavigationSecondState extends State<NavigationSecond> {
  @override
  Widget build(BuildContext context) {
    Color color;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Navigation Second Screen'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(
                  child: const Text('Red'),
                  onPressed: () {
                    color = Colors.red.shade700;
                    Navigator.pop(context, color);
                  }),
              ElevatedButton(
                  child: const Text('Green'),
                  onPressed: () {
                    color = Colors.green.shade700;
                    Navigator.pop(context, color);
                  }),
              ElevatedButton(
                  child: const Text('Blue'),
                  onPressed: () {
                    color = Colors.blue.shade700;
                    Navigator.pop(context, color);
                  }),
            ],
          ),
        ));
  }
}
