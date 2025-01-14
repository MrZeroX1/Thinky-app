import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'progress_state.dart';

class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    final progressState = Provider.of<ProgressState>(context);

    double speechScore = progressState.speechTotal > 0
        ? (progressState.speechCorrect / progressState.speechTotal) * 100
        : 0;

    double emotionScore = progressState.emotionTotal > 0
        ? (progressState.emotionCorrect / progressState.emotionTotal) * 100
        : 0;

    double overallScore = (speechScore + emotionScore) / 2;

    String grade;
    String gradeTitle;

    if (overallScore >= 90) {
      grade = "A";
      gradeTitle = "You are Excellent";
    } else if (overallScore >= 80) {
      grade = "B";
      gradeTitle = "You almost there";
    } else if (overallScore >= 65) {
      grade = "C";
      gradeTitle = "Keep Going";
    } else if (overallScore >= 50) {
      grade = "D";
      gradeTitle = "Practice More";
    } else {
      grade = "E";
      gradeTitle = "Better Luck Next Time";
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6A1B9A), Color(0xFF42A5F5)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // AppBar
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const Text(
                    "Progress",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.share, color: Colors.white),
                    onPressed: () {
                      print("Share Progress");
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Circular Overall Score
            Center(
              child: Container(
                width: 100,
                height: 100,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${overallScore.toStringAsFixed(0)}%",
                          style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "GRADE $grade",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Grade Title
            Center(
              child: Text(
                gradeTitle,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Cards for Progress
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      _buildProgressCard(
                        title: "Speech Practice",
                        subtitle:
                            "Completed ${progressState.speechCorrect} Speech Exercises!",
                        score: speechScore,
                      ),
                      const SizedBox(height: 20),
                      _buildProgressCard(
                        title: "Emotion Game",
                        subtitle:
                            "Mastered ${progressState.emotionCorrect} Emotions!",
                        score: emotionScore,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to create a progress card
  Widget _buildProgressCard({
    required String title,
    required String subtitle,
    required double score,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 70, // Increased size
            width: 70, // Increased size
            child: CircularProgressIndicator(
              value: score / 100,
              strokeWidth: 8,
              backgroundColor: Colors.black12,
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFF6A1B9A),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
