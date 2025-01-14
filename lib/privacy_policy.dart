import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

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
            // Custom AppBar
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 16, right: 16),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const Text(
                    "Back",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(flex: 2),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Privacy Policy",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            // Privacy Policy Content
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
                  child: SingleChildScrollView(
                    child: const Text(
                      _privacyPolicyContent,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const String _privacyPolicyContent = '''
Privacy Policy

This Privacy Policy explains how we collect, use, and protect your information when you use Thinky. We value your trust and are committed to safeguarding your data.

Information We Collect:
1. **User Information**: We may collect information such as usernames, email addresses, and passwords during account creation for personalized experiences.
2. **Voice Data**: Any voice recordings from the Speech Practice page are securely processed for accuracy and learning purposes. These recordings are not shared or stored permanently.
3. **Chat Data**: Conversations in Ask Thinky are processed to enhance the chatbot's responses. No personal data is extracted or stored permanently.
4. **Progress Data**: Data related to games, exercises, and scores is stored locally and securely to track progress.

How We Use Your Information:
1. To enhance your learning experience through personalized feedback.
2. To calculate and display progress on the Progress Page.
3. To provide seamless interaction with AI-powered features like Speech Practice and Ask Thinky.

Data Storage and Security:
1. All data is stored locally on your device or securely in the cloud (if enabled by the parent).
2. No third-party access to your data without explicit permission.

Your Choices:
1. You can delete your account and all associated data by contacting support or through the settings page.
2. Parents have full control over the stored progress and can reset it at any time.

Third-Party Services:
We may use third-party tools for analytics, storage, or chatbot enhancement. These tools comply with data protection laws and are used only to improve app functionality.

Changes to This Policy:
This Privacy Policy may be updated occasionally. You will be notified of significant changes.

Contact Us:
If you have any questions or concerns about this Privacy Policy, please contact us at support@thinkyapp.com.

Thank you for trusting Thinky!
''';
