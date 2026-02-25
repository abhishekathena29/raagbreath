import 'package:flutter/material.dart';

class TeacherParentAlertScreen extends StatelessWidget {
  const TeacherParentAlertScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D082B),
      appBar: AppBar(
        title: const Text(
          'Teacher / Parent Alert',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.warning_rounded,
              color: Colors.orangeAccent,
              size: 64,
            ),
            const SizedBox(height: 24),
            const Text(
              'Early Detection in Children',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Parents and teachers play a crucial role in identifying early signs of lung problems in children. Children may not always be able to explain their symptoms clearly, so observing their behavior is important.',
              style: TextStyle(
                color: Color(0xFFB7B0D7),
                fontSize: 16,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1A143C),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF2D2553)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Watch out for:',
                    style: TextStyle(
                      color: Color(0xFF5AD8FE),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  _BulletPoint('Frequent coughing'),
                  _BulletPoint('Difficulty in breathing'),
                  _BulletPoint('Reduced participation in physical activities'),
                  _BulletPoint('Unusual fatigue'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Action Plan',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'If a child shows repeated symptoms, it is important to seek medical advice. Early intervention can prevent the condition from worsening.\n\nTeachers can also help by ensuring that classrooms are well-ventilated and free from dust and pollutants.\n\nCreating awareness among parents and teachers ensures that children receive timely care and support, reducing the risk of long-term health issues.',
              style: TextStyle(
                color: Color(0xFFB7B0D7),
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BulletPoint extends StatelessWidget {
  final String text;
  const _BulletPoint(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '• ',
            style: TextStyle(
              color: Color(0xFF5AD8FE),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
