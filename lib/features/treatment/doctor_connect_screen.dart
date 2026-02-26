import 'package:flutter/material.dart';

class DoctorConnectScreen extends StatelessWidget {
  const DoctorConnectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF6EF),
      appBar: AppBar(
        title: const Text(
          'Doctor Connect',
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
              Icons.medical_services,
              color: Color(0xFF4A7FA8),
              size: 64,
            ),
            const SizedBox(height: 24),
            const Text(
              'Find Professional Help',
              style: TextStyle(
                color: Color(0xFF3D2B1F),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Access to healthcare is an important part of managing lung health. Consulting a doctor ensures that you receive accurate diagnosis and appropriate treatment. It also helps in managing chronic conditions and preventing complications.',
              style: TextStyle(
                color: Color(0xFF8C7B6B),
                fontSize: 16,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFE8DDD0)),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.map_outlined,
                    color: Color(0xFF4A7FA8),
                    size: 48,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Integration Coming Soon',
                    style: TextStyle(
                      color: Color(0xFF3D2B1F),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'We are working on integrating a map to find nearby doctors and clinics, as well as teleconsultation options.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xFF8C7B6B), fontSize: 14),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4A7FA8),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text('Notify Me When Ready'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
