import 'package:flutter/material.dart';

class SchoolActionScreen extends StatelessWidget {
  const SchoolActionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF6EF),
      appBar: AppBar(
        title: const Text(
          'School Action Kit',
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
            const Icon(Icons.school, color: Color(0xFF5B8A6E), size: 64),
            const SizedBox(height: 24),
            const Text(
              'Supporting Students',
              style: TextStyle(
                color: Color(0xFF3D2B1F),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Schools play a critical role in supporting students with respiratory conditions. Teachers should be trained to recognize signs of breathing difficulties and respond appropriately.',
              style: TextStyle(
                color: Color(0xFF8C7B6B),
                fontSize: 16,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),
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
                    'In Case of Asthma Attack:',
                    style: TextStyle(
                      color: Color(0xFFD32F2F),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  _StepAction(
                    '1',
                    'Help the child to sit upright and stay calm.',
                  ),
                  _StepAction('2', 'Use their prescribed inhaler immediately.'),
                  _StepAction('3', 'Ensure the classroom is well-ventilated.'),
                  _StepAction(
                    '4',
                    'If symptoms do not improve, seek emergency help.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Preventative Measures',
              style: TextStyle(
                color: Color(0xFF3D2B1F),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              '• Minimize exposure to dust and pollutants in classrooms.\n• Promote awareness by conducting health sessions.\n• Encourage students to adopt healthy habits, like proper hydration and breathing exercises.',
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

class _StepAction extends StatelessWidget {
  final String step;
  final String text;

  const _StepAction(this.step, this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 12,
            backgroundColor: const Color(0xFFD32F2F).withOpacity(0.12),
            child: Text(
              step,
              style: const TextStyle(
                color: Color(0xFFD32F2F),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Color(0xFF3D2B1F), fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
