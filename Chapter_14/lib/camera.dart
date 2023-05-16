import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'picture.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  List<CameraDescription> cameras = [];
  List<Widget> cameraButtons = [];
  CameraController? cameraController;
  CameraDescription? activeCamera;
  CameraPreview? preview;

  @override
  void initState() {
    super.initState();
    listCameras().then((result) {
      setState(() {
        cameraButtons = result;
        setCameraController();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Camera View'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: cameraButtons.isEmpty
                        ? [const Text('No cameras available')]
                        : cameraButtons,
                  ),
                  SizedBox(height: size.height / 2 , child: preview),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        child: const Text('Take Picture'),
                        onPressed: () {
                          if (cameraController != null) {
                            takePicture().then((dynamic picture) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PictureScreen(picture)));
                            });
                          }
                        },
                      )
                    ],
                  ),
                ])));
  }

  Future<List<Widget>> listCameras() async {
    List<Widget> buttons = [];
    cameras = await availableCameras();
    if (cameras.isEmpty) return [];
    activeCamera ??= cameras.first;

    for (CameraDescription camera in cameras) {
      buttons.add(ElevatedButton(
          onPressed: () {
            setState(() {
              activeCamera = camera;
              setCameraController();
            });
          },
          child: Row(
            children: [const Icon(Icons.camera_alt), Text(camera.name)],
          )));
    }
    return buttons;
  }

  @override
  void dispose() {
    cameraController?.dispose();

    super.dispose();
  }

  Future setCameraController() async {
    if (activeCamera == null) return;

    if (cameraController != null) {
      await cameraController!.dispose();
    }

    cameraController = CameraController(
      activeCamera!,
      ResolutionPreset.high,
    );
    try {
      await cameraController!.initialize();
    } catch (e) {
      print('Ccamera controller initialize error: $e');
      return;
    }
    setState(() {
      preview = CameraPreview(
        cameraController!,
      );
    });
  }

  Future takePicture() async {
    if (cameraController == null) {
      return;
    }
    if (!cameraController!.value.isInitialized) {
      return;
    }
    if (cameraController!.value.isTakingPicture) {
      return;
    }
    try {
      await cameraController!.setFlashMode(FlashMode.off);
      XFile picture = await cameraController!.takePicture();
      // ignore: use_build_context_synchronously
      return picture;
    } catch (exception) {
      print(exception.toString());
    }
  }
}
