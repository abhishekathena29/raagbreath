import 'package:flutter/material.dart';

class TeacherParentAlertScreen extends StatelessWidget {
  const TeacherParentAlertScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF6EF),
      appBar: AppBar(
        title: const Text(
          'Caregiver Tips',
          style: TextStyle(color: Color(0xFF3D2B1F)),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF3D2B1F)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.warning_rounded,
              color: Color(0xFFCF8A3E),
              size: 64,
            ),
            const SizedBox(height: 24),
            const Text(
              'Comfort Cues for Children',
              style: TextStyle(
                color: Color(0xFF3D2B1F),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Parents and teachers can help children feel more comfortable by noticing their energy, breathing ease, and surroundings. Many children find it hard to describe discomfort clearly, so gentle observation matters.',
              style: TextStyle(
                color: Color(0xFF8C7B6B),
                fontSize: 16,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE8DDD0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Notice when a child seems:',
                    style: TextStyle(
                      color: Color(0xFFC17D3C),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  _BulletPoint('Frequently coughing or clearing their throat'),
                  _BulletPoint('Less comfortable during active play'),
                  _BulletPoint('Tired or distracted more than usual'),
                  _BulletPoint('Bothered by dusty or stuffy spaces'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Support Plan',
              style: TextStyle(
                color: Color(0xFF3D2B1F),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'If a child seems uncomfortable repeatedly, help them slow down, sit in a calm place, and move away from smoke, dust, or strong smells.\n\nTeachers can also support children by keeping classrooms well-ventilated, offering water breaks, and encouraging gentle breathing routines.\n\nConsistent awareness from caregivers helps children feel supported and makes it easier to spot patterns that may need extra attention.',
              style: TextStyle(
                color: Color(0xFF8C7B6B),
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
              color: Color(0xFFC17D3C),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Color(0xFF3D2B1F), fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
