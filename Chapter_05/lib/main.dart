import 'package:dogs/e_commerce_screen.dart';
import 'package:flutter/material.dart';
import 'deep_tree.dart';
import 'flex_screen.dart';
import 'profile_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.green,
        appBarTheme: AppBarTheme(
          elevation: 10,
          titleTextStyle: const TextTheme(
            titleLarge: TextStyle(
              fontFamily: 'LeckerliOne',
              fontSize: 24,
            ),
          ).titleLarge,
        ),
      ),
      home: const ECommerceScreen(),
    );
  }
}
