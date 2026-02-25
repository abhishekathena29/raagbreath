import 'package:flutter/material.dart';

class SchoolActionScreen extends StatelessWidget {
  const SchoolActionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D082B),
      appBar: AppBar(
        title: const Text(
          'School Action Kit',
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
            const Icon(Icons.school, color: Color(0xFFB0A3FF), size: 64),
            const SizedBox(height: 24),
            const Text(
              'Supporting Students',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Schools play a critical role in supporting students with respiratory conditions. Teachers should be trained to recognize signs of breathing difficulties and respond appropriately.',
              style: TextStyle(
                color: Color(0xFFB7B0D7),
                fontSize: 16,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),
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
                    'In Case of Asthma Attack:',
                    style: TextStyle(
                      color: Color(0xFFFF6B6B),
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
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              '• Minimize exposure to dust and pollutants in classrooms.\n• Promote awareness by conducting health sessions.\n• Encourage students to adopt healthy habits, like proper hydration and breathing exercises.',
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
            backgroundColor: const Color(0xFFFF6B6B).withOpacity(0.2),
            child: Text(
              step,
              style: const TextStyle(
                color: Color(0xFFFF6B6B),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
