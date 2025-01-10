import 'dart:collection';
import 'dart:math';
import 'package:deep_waste/models/Tips.dart';
import 'package:flutter/material.dart';

class TipsNotifier extends ChangeNotifier {
  List<Tips> _tips = [
    Tips("1001", "pla", [
      "Find the Filter: Search for the quiz filter in Instagram’s effects or through a friend's story",
      "Apply the Filter: Tap on the filter to open it, and make sure your face is in the camera frame.",
      "Understand the Rules: Nod right for the correct answer and left for the wrong answer.",
      "Answer Questions: Keep nodding your head in response to the questions that appear above your head.",
      "Finish and Share: After the quiz ends, check your score and share it on your story if you want!",
    ]),
    Tips("1002", "paper", [
      "Find the Filter: Search for the quiz filter in Instagram’s effects or through a friend's story",
      "Apply the Filter: Tap on the filter to open it, and make sure your face is in the camera frame.",
      "Understand the Rules: Nod right for the correct answer and left for the wrong answer.",
      "Answer Questions: Keep nodding your head in response to the questions that appear above your head.",
      "Finish and Share: After the quiz ends, check your score and share it on your story if you want!",
    ]),
    Tips("1003", "biological", [
      "Find the Filter: Search for the quiz filter in Instagram’s effects or through a friend's story",
      "Apply the Filter: Tap on the filter to open it, and make sure your face is in the camera frame.",
      "Understand the Rules: Nod right for the correct answer and left for the wrong answer.",
      "Answer Questions: Keep nodding your head in response to the questions that appear above your head.",
      "Finish and Share: After the quiz ends, check your score and share it on your story if you want!",
    ]),
    Tips("1004", "glass", [
      "Find the Filter: Search for the quiz filter in Instagram’s effects or through a friend's story",
      "Apply the Filter: Tap on the filter to open it, and make sure your face is in the camera frame.",
      "Understand the Rules: Nod right for the correct answer and left for the wrong answer.",
      "Answer Questions: Keep nodding your head in response to the questions that appear above your head.",
      "Finish and Share: After the quiz ends, check your score and share it on your story if you want!",
    ]),
    Tips("1005", "metal", [
      "Find the Filter: Search for the quiz filter in Instagram’s effects or through a friend's story",
      "Apply the Filter: Tap on the filter to open it, and make sure your face is in the camera frame.",
      "Understand the Rules: Nod right for the correct answer and left for the wrong answer.",
      "Answer Questions: Keep nodding your head in response to the questions that appear above your head.",
      "Finish and Share: After the quiz ends, check your score and share it on your story if you want!",
    ]),
    Tips("1006", "cardboard", [
      "Find the Filter: Search for the quiz filter in Instagram’s effects or through a friend's story",
      "Apply the Filter: Tap on the filter to open it, and make sure your face is in the camera frame.",
      "Understand the Rules: Nod right for the correct answer and left for the wrong answer.",
      "Answer Questions: Keep nodding your head in response to the questions that appear above your head.",
      "Finish and Share: After the quiz ends, check your score and share it on your story if you want!",
    ]),
    Tips("1007", "trash", [
      "Find the Filter: Search for the quiz filter in Instagram’s effects or through a friend's story",
      "Apply the Filter: Tap on the filter to open it, and make sure your face is in the camera frame.",
      "Understand the Rules: Nod right for the correct answer and left for the wrong answer.",
      "Answer Questions: Keep nodding your head in response to the questions that appear above your head.",
      "Finish and Share: After the quiz ends, check your score and share it on your story if you want!",
    ])
  ];

  UnmodifiableListView<Tips> get rewards => UnmodifiableListView(_tips);

  Tips getRandomTip() {
    final _random = new Random();
    return _tips[_random.nextInt(_tips.length)];
  }
}
