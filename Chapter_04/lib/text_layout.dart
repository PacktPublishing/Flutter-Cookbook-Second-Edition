import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextLayout extends StatelessWidget {
  const TextLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        'Hello, World!',
        style: GoogleFonts.leckerliOne(fontSize: 40),
      ),
      Text(
        'Text can wrap without issue',
        style: Theme.of(context).textTheme.titleLarge,
      ),
//make sure the Text below is all in one line:
      const Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam at mauris massa. Suspendisse potenti. Aenean aliquet eu nisl vitae tempus.'),
      const Divider(),
      RichText(
          text: const TextSpan(
        text: 'Flutter text is ',
        style: TextStyle(fontSize: 22, color: Colors.black),
        children: <TextSpan>[
          TextSpan(
            text: 'really ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
            children: [
              TextSpan(
                text: 'powerful.',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  decorationStyle: TextDecorationStyle.double,
                  fontSize: 40,
                ),
              ),
            ],
          ),
        ],
      ),),
    ]);
  }
}
