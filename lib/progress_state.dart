import 'package:flutter/foundation.dart';

class ProgressState with ChangeNotifier {
  // Speech Practice state
  int speechCorrect = 0;
  int speechTotal = 0;

  // Emotion Game state
  int emotionCorrect = 0;
  int emotionTotal = 0;

  // Update Speech Practice scores
  void updateSpeechScore(bool isCorrect) {
    speechTotal++;
    if (isCorrect) speechCorrect++;
    notifyListeners();
  }

  // Update Emotion Game scores
  void updateEmotionScore(bool isCorrect) {
    emotionTotal++;
    if (isCorrect) emotionCorrect++;
    notifyListeners();
  }
}
