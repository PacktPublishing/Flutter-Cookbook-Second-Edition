import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'ml.dart';
import 'result.dart';

class PictureScreen extends StatelessWidget {
  final XFile picture;
  const PictureScreen(this.picture, {super.key});

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Picture'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(picture.path),
          SizedBox(
              height: deviceHeight / 1.5,
              child: Image.file(File(picture.path))),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                child: const Text('Text Recognition'),
                onPressed: () {
                  final image = File(picture.path);
                  MLHelper helper = MLHelper();
                  helper.textFromImage(image).then((result) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ResultScreen(result)));
                  });
                },
              ),
              ElevatedButton(
                child: const Text('Barcode Reader'),
                onPressed: () {
                  final image = File(picture.path);
                  MLHelper helper = MLHelper();
                  helper.readBarcode(image).then((result) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ResultScreen(result)));
                  });
                },
              ),
              ElevatedButton(
                child: const Text('Image Labeler'),
                onPressed: () {
                  final image = File(picture.path);
                  MLHelper helper = MLHelper();
                  helper.labelImage(image).then((result) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ResultScreen(result)));
                  });
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                child: const Text('Face Recognition'),
                onPressed: () {
                  final image = File(picture.path);
                  MLHelper helper = MLHelper();
                  helper.detectFace(image).then((result) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ResultScreen(result)));
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
