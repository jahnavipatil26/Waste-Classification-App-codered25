import 'package:tflite_flutter/tflite_flutter.dart';
import 'dart:typed_data';

class TFLiteHelper {
  Interpreter? _interpreter;

  Future<void> loadModel() async {
    try {
      _interpreter = await Interpreter.fromAsset('assets/waste_classifier.tflite');
      print('Model loaded successfully');
    } catch (e) {
      print('Error loading model: $e');
    }
  }

  List<dynamic> runModel(Uint8List input) {
    var output = List.filled(1 * 9, 0).reshape([1, 9]);  // 9 classes
    _interpreter?.run(input, output);
    return output[0];
  }

  void close() {
    _interpreter?.close();
  }
}
