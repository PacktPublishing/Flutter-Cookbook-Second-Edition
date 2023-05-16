import 'dart:io';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:google_mlkit_language_id/google_mlkit_language_id.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'classifier.dart';

class MLHelper {
  Future<String> textFromImage(File image) async {
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final InputImage inputImage = InputImage.fromFile(image);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);
    return recognizedText.text;
  }

  Future<String> readBarcode(File image) async {
    final barcodeScanner = BarcodeScanner(formats: [BarcodeFormat.all]);
    final InputImage inputImage = InputImage.fromFile(image);
    String result = '';

    final List<Barcode> barcodes =
        await barcodeScanner.processImage(inputImage);

    for (Barcode barcode in barcodes) {
      final String displayValue = barcode.displayValue ?? '';
      result += '$displayValue\n';
    }

    return result;
  }

  Future<String> labelImage(File image) async {
    String result = '';
    final InputImage inputImage = InputImage.fromFile(image);

    final ImageLabelerOptions options =
        ImageLabelerOptions(confidenceThreshold: 0.5);
    final imageLabeler = ImageLabeler(options: options);
    final List<ImageLabel> labels = await imageLabeler.processImage(inputImage);

    for (ImageLabel label in labels) {
      final String text = label.label;
      final int index = label.index;
      final double confidence = label.confidence;
      result += '$index: $text - ${confidence * 100}% \n';
    }
    return result;
  }

  Future<String> detectFace(File image) async {
    String result = '';
    final InputImage inputImage = InputImage.fromFile(image);
    final options = FaceDetectorOptions(
      enableClassification: true,
      enableTracking: true,
      enableLandmarks: true,
      performanceMode: FaceDetectorMode.accurate,
    );
    final faceDetector = FaceDetector(options: options);
    final List<Face> faces = await faceDetector.processImage(inputImage);
    result = 'There are ${faces.length} face(s) in your picture \n';
    for (Face face in faces) {
      result += 'Face #$num: \n';
      result += 'Smiling: ${face.smilingProbability ?? 0 * 100}% \n';
      result +=
          'Left Eye Open: ${(face.leftEyeOpenProbability ?? 0) * 100}% \n';
      result +=
          'Right Eye Open: ${(face.rightEyeOpenProbability ?? 0) * 100}% \n';
    }
    return result;
  }

  Future<String> identifyLanguage(String text) async {
    String result = '';
    final languageIdentifier = LanguageIdentifier(confidenceThreshold: 0.5);
    final List<IdentifiedLanguage> languages =
        await languageIdentifier.identifyPossibleLanguages(text);
    for (IdentifiedLanguage language in languages) {
      result +=
          'Language: ${language.languageTag} - Confidence: ${language.confidence * 100}%';
    }
    return result;
  }

  Future<String> classifyText(String message) async {
    String result;
    Classifier classifier = Classifier();
    int value = await classifier.classify(message);
    if (value > 0) {
      result = 'Positive sentiment';
    } else {
      result = 'Negative sentiment';
    }
    return result;
  }
}
