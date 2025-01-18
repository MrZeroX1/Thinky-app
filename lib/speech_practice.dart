import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:provider/provider.dart';
import 'progress_state.dart'; // Import ProgressState

class SpeechPracticePage extends StatefulWidget {
  const SpeechPracticePage({super.key});

  @override
  State<SpeechPracticePage> createState() => _SpeechPracticePageState();
}

class _SpeechPracticePageState extends State<SpeechPracticePage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isRecording = false;
  bool _isCorrect = true; // Toggle between correct and incorrect

  // Play sound function
  Future<void> _playSound() async {
    try {
      await _audioPlayer
          .setSourceAsset('sounds/apple.mp3'); // Correct path to the asset
      await _audioPlayer.resume(); // Play the sound
    } catch (e) {
      print("Error playing sound: $e");
    }
  }

  // Simulate evaluating recording and update progress
  Future<void> _evaluateRecording(BuildContext context) async {
    setState(() {
      _isRecording = true;
    });

    // Simulate a delay for evaluation
    await Future.delayed(const Duration(seconds: 3));

    setState(() {
      _isRecording = false;
    });

    // Update the progress based on current state of _isCorrect
    Provider.of<ProgressState>(context, listen: false)
        .updateSpeechScore(_isCorrect);

    // Show feedback
    String feedback = _isCorrect ? "Correct!" : "Try Again!";
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(feedback),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );

    // Toggle between correct and incorrect for the next recording
    _isCorrect = !_isCorrect;
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          children: [
            // Header
            AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              flexibleSpace: const SizedBox.shrink(),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const Text(
                    "Speech Practice",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      print("Skip clicked");
                    },
                    child: const Text(
                      "Skip",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Title
            const Text(
              "Repeat words and learn pronunciation!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
            // Word Card
            Expanded(
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Repeat after me!",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 20),
                      IconButton(
                        icon: const Icon(Icons.volume_up, size: 40),
                        color: Colors.blue,
                        onPressed: _playSound,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "APPLE",
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 30),
                      GestureDetector(
                        onTap: () => _evaluateRecording(context),
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Colors.greenAccent, Colors.green],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.green.withOpacity(0.4),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.mic,
                            size: 40,
                            color: _isRecording ? Colors.red : Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      if (_isRecording)
                        const Text(
                          "Recording...",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
