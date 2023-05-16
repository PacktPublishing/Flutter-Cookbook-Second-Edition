import 'package:flutter/material.dart';
import 'animated_list.dart';
import 'dismissible.dart';
import 'fade_transition.dart';
import 'list_screen.dart';
import 'my_animation.dart';
import './shape_animation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
        return MaterialApp(
      title: 'Animations Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
     home: const DismissibleScreen(),
   );

  }
}