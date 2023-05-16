import 'package:flutter/material.dart';
import 'ml.dart';
import 'result.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  final TextEditingController txtLanguage = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Language Detection'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: txtLanguage,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Enter some text in any language',
              ),
            ),
            Center(
                child: ElevatedButton(
              child: const Text('Detect Language'),
              onPressed: () {
                MLHelper helper = MLHelper();
                helper.identifyLanguage(txtLanguage.text).then((result) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ResultScreen(result)));
                });
              },
            )),
            ElevatedButton(
              child: const Text('Classify Text'),
              onPressed: () {
                MLHelper helper = MLHelper();
                helper.classifyText(txtLanguage.text).then((result) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ResultScreen(result)));
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    txtLanguage.dispose();
    super.dispose();
  }
}
