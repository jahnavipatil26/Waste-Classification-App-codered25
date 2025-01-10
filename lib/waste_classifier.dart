// import 'dart:convert';
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:tflite_flutter/tflite_flutter.dart';
// import 'package:image/image.dart' as img;
// import 'package:path_provider/path_provider.dart';
//
// class WasteClassifier extends StatefulWidget {
//   @override
//   _WasteClassifierState createState() => _WasteClassifierState();
// }
//
// class _WasteClassifierState extends State<WasteClassifier> {
//   Interpreter? _interpreter;
//   String _result = 'Classify the waste by taking a picture!';
//   final ImagePicker _picker = ImagePicker();
//
//   @override
//   void initState() {
//     super.initState();
//     _loadModel();
//   }
//
//   // Load the TensorFlow Lite model
//   Future<void> _loadModel() async {
//     try {
//       _interpreter = await Interpreter.fromAsset('assets/garbage_model.tflite');
//       print('Model loaded successfully');
//     } catch (e) {
//       print('Error loading model: $e');
//     }
//   }
//
//   // Preprocess the image and classify it
//   Future<void> _classifyImage(XFile image) async {
//     img.Image? imageFile = img.decodeImage(await image.readAsBytes());
//     if (imageFile == null) return;
//
//     img.Image resizedImage = img.copyResize(imageFile, width: 224, height: 224);
//
//     List<List<List<List<double>>>> input = List.generate(
//       1,
//           (i) => List.generate(
//         224,
//             (j) => List.generate(
//           224,
//               (k) => List.generate(3, (l) {
//             int pixel = resizedImage.getPixel(k, j);
//             int red = img.getRed(pixel);
//             int green = img.getGreen(pixel);
//             int blue = img.getBlue(pixel);
//             return red / 255.0; // Use red as an example
//           }),
//         ),
//       ),
//     );
//
//     var outputBuffer = List.generate(1, (index) => List.filled(9, 0.0));
//
//     _interpreter?.run(input, outputBuffer);
//
//     var probabilities = outputBuffer[0];
//     int predictedClass = probabilities.indexOf(probabilities.reduce((a, b) => a > b ? a : b));
//
//     setState(() {
//       _result = "Predicted Waste Class: $predictedClass";
//     });
//
//     // Store the classification result in a JSON file
//     await _storeClassificationResult(predictedClass);
//   }
//
//   // Store the classification result in a local JSON file
//   Future<void> _storeClassificationResult(int predictedClass) async {
//     final directory = await getApplicationDocumentsDirectory();
//     final file = File('${directory.path}/classifications.json');
//
//     List<Map<String, dynamic>> classifications = [];
//     if (await file.exists()) {
//       final jsonData = await file.readAsString();
//       classifications = List<Map<String, dynamic>>.from(json.decode(jsonData));
//     }
//
//     classifications.add({
//       'timestamp': DateTime.now().toIso8601String(),
//       'predictedClass': predictedClass,
//     });
//
//     await file.writeAsString(json.encode(classifications));
//   }
//
//   // Capture an image using the camera
//   Future<void> _takePicture() async {
//     final XFile? image = await _picker.pickImage(source: ImageSource.camera);
//     if (image != null) {
//       _classifyImage(image);
//     }
//   }
//
//   @override
//   void dispose() {
//     _interpreter?.close();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Waste Classifier'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: _takePicture,
//               child: Text('Take Picture'),
//             ),
//             SizedBox(height: 20),
//             Text(
//               _result,
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

class WasteClassifier extends StatefulWidget {
  @override
  _WasteClassifierState createState() => _WasteClassifierState();
}

class _WasteClassifierState extends State<WasteClassifier> {
  Interpreter? _interpreter;
  String _result = 'Classify the waste by taking a picture!';
  final ImagePicker _picker = ImagePicker();
  double _progress = 0.0; // Progress for the progress bar

  @override
  void initState() {
    super.initState();
    _loadModel();
  }

  // Load the TensorFlow Lite model
  Future<void> _loadModel() async {
    try {
      _interpreter = await Interpreter.fromAsset('assets/garbage_model.tflite');
      print('Model loaded successfully');
    } catch (e) {
      print('Error loading model: $e');
    }
  }

  // Preprocess the image and classify it
  Future<void> _classifyImage(XFile image) async {
    setState(() {
      _progress = 0.1; // Show progress bar starting
    });

    img.Image? imageFile = img.decodeImage(await image.readAsBytes());
    if (imageFile == null) return;

    img.Image resizedImage = img.copyResize(imageFile, width: 224, height: 224);

    List<List<List<List<double>>>> input = List.generate(
      1,
          (i) => List.generate(
        224,
            (j) => List.generate(
          224,
              (k) => List.generate(3, (l) {
            int pixel = resizedImage.getPixel(k, j);
            int red = img.getRed(pixel);
            int green = img.getGreen(pixel);
            int blue = img.getBlue(pixel);
            return red / 255.0; // Use red as an example
          }),
        ),
      ),
    );

    var outputBuffer = List.generate(1, (index) => List.filled(9, 0.0));

    setState(() {
      _progress = 0.5; // Indicating halfway through
    });

    _interpreter?.run(input, outputBuffer);

    var probabilities = outputBuffer[0];
    int predictedClass = probabilities.indexOf(probabilities.reduce((a, b) => a > b ? a : b));
    double confidence = probabilities[predictedClass];

    setState(() {
      _result = "Predicted Waste Class: $predictedClass with ${confidence * 100}% confidence";
      _progress = 1.0; // Indicating completion
    });

    // Store the classification result in a JSON file
    await _storeClassificationResult(predictedClass, confidence);
  }

  // Store the classification result in a local JSON file
  Future<void> _storeClassificationResult(int predictedClass, double confidence) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/classifications.json');

    List<Map<String, dynamic>> classifications = [];
    if (await file.exists()) {
      final jsonData = await file.readAsString();
      classifications = List<Map<String, dynamic>>.from(json.decode(jsonData));
    }

    classifications.add({
      'timestamp': DateTime.now().toIso8601String(),
      'predictedClass': predictedClass,
      'confidence': confidence,
    });

    await file.writeAsString(json.encode(classifications));
  }

  // Capture an image using the camera
  Future<void> _takePicture() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      _classifyImage(image);
    }
  }

  @override
  void dispose() {
    _interpreter?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Waste Classifier'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _takePicture,
              child: Text('Take Picture'),
            ),
            SizedBox(height: 20),
            // Display progress bar
            _progress < 1.0
                ? LinearProgressIndicator(value: _progress)
                : SizedBox(height: 10),
            SizedBox(height: 20),
            // Display classification result
            Text(
              _result,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
