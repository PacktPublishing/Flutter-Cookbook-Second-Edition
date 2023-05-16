import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UploadFileScreen extends StatefulWidget {
  const UploadFileScreen({super.key});

  @override
  State<UploadFileScreen> createState() => _UploadFileScreenState();
}

class _UploadFileScreenState extends State<UploadFileScreen> {
  File? _image;
  String _message = '';
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload To FireStore')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              child: const Text('Choose Image'),
              onPressed: () {
                getImage();
              },
            ),
            SizedBox(
                height: 200,
                child: _image == null ? null : Image.file(_image!)),
            ElevatedButton(
              child: const Text('Upload Image'),
              onPressed: () {
                uploadImage();
              },
            ),
            Text(_message),
          ],
        ),
      ),
    );
  }

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
     if (pickedFile != null) {
        _image = File(pickedFile.path);
         setState(() {});
      } else {
        print('No image selected.');
      }
  }

  Future uploadImage() async {
    if (_image != null) {
      String fileName = basename(_image!.path);
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref(fileName);
      setState(() {
        _message = 'Uploading file. Please wait...';
      });
      ref.putFile(_image!).then((TaskSnapshot result) {
        if (result.state == TaskState.success) {
          setState(() {
            _message = 'File Uploaded Successfully';
          });
        } else {
          setState(() {
            _message = 'Error Uploading File';
          });
        }
      });
    }
  }
}
