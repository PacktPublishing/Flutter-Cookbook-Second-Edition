import 'package:area/area.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const screen = PackageScreen();
    return MaterialApp(
      title: 'Packages App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: screen,
    );
  }
}

class PackageScreen extends StatefulWidget {
  const PackageScreen({super.key});

  @override
  State<PackageScreen> createState() => _PackageScreenState();
}

class _PackageScreenState extends State<PackageScreen> {
  final TextEditingController txtHeight = TextEditingController();
  final TextEditingController txtWidth = TextEditingController();
  String result = '';

  @override
  void dispose() {
    txtHeight.dispose();
    txtWidth.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Package App'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppTextField(txtWidth, 'Width'),
            AppTextField(txtHeight, 'Height'),
            const Padding(
              padding: EdgeInsets.all(24),
            ),
            ElevatedButton(
              child: const Text('Calculate Area'),
              onPressed: () {
                final double width = double.tryParse(txtWidth.text) ?? 0;
                final double height = double.tryParse(txtHeight.text) ?? 0;
                final String res = calculateAreaRect(width, height);
                setState(() {
                  result = res;
                });
              },
            ),
            const Padding(
              padding: EdgeInsets.all(24),
            ),
            Text(result),
          ],
        ),
      ),
    );
  }
}

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  const AppTextField(this.controller, this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(hintText: label),
      ),
    );
  }
}
