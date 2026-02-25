import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raag_breath/features/auth/models/user_model.dart';
import 'package:raag_breath/features/auth/services/auth_service.dart';
import 'package:raag_breath/features/auth/services/firestore_service.dart';
import '../navigation/main_shell.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _ageController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  Gender _gender = Gender.male;
  ActivityLevel _activity = ActivityLevel.moderate;
  bool _isLoading = false;

  Future<void> _saveBio() async {
    final age = int.tryParse(_ageController.text);
    final height = double.tryParse(_heightController.text);
    final weight = double.tryParse(_weightController.text);

    if (age == null || height == null || weight == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter valid age, height, and weight'),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final user = Provider.of<AuthService>(context, listen: false).user;
      if (user != null) {
        // Update user bio in Firestore
        await FirestoreService().updateUserBio(
          user.uid,
          age: age,
          heightCm: height,
          weightKg: weight,
          gender: _gender,
          activityLevel: _activity,
        );

        if (mounted) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const MainShell()),
            (route) => false,
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error saving bio: $e')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D082B),
      body: Stack(
        children: [
          const _AuthBackground(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Tell us about you',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'We use this to estimate your lung capacity',
                    style: TextStyle(color: Color(0xFFB7B0D7), fontSize: 15),
                  ),
                  const SizedBox(height: 32),

                  Row(
                    children: [
                      Expanded(
                        child: _InputField(
                          label: 'Age',
                          icon: Icons.cake_outlined,
                          controller: _ageController,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _InputField(
                          label: 'Height (cm)',
                          icon: Icons.height,
                          controller: _heightController,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _InputField(
                          label: 'Weight (kg)',
                          icon: Icons.monitor_weight_outlined,
                          controller: _weightController,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  const Text(
                    "Gender",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  _buildDropdown<Gender>(
                    value: _gender,
                    items: Gender.values,
                    onChanged: (v) => setState(() => _gender = v!),
                  ),

                  const SizedBox(height: 24),
                  const Text(
                    "Activity Level",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  _buildDropdown<ActivityLevel>(
                    value: _activity,
                    items: ActivityLevel.values,
                    onChanged: (v) => setState(() => _activity = v!),
                  ),

                  const SizedBox(height: 48),

                  if (_isLoading)
                    const Center(child: CircularProgressIndicator())
                  else
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF72E8D4),
                          foregroundColor: const Color(0xFF0D082B),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: _saveBio,
                        child: const Text(
                          'Continue to App',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown<T>({
    required T value,
    required List<T> items,
    required ValueChanged<T?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF17123A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF2D2553)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          isExpanded: true,
          dropdownColor: const Color(0xFF1A143C),
          icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF72E8D4)),
          style: const TextStyle(color: Colors.white),
          items: items.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item.toString().split('.').last.toUpperCase()),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  const _InputField({
    required this.label,
    required this.icon,
    required this.controller,
    this.keyboardType,
  });

  final String label;
  final IconData icon;
  final TextEditingController controller;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      cursorColor: const Color(0xFF72E8D4),
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: const Color(0xFF72E8D4)),
        filled: true,
        fillColor: const Color(0xFF17123A),
        labelStyle: const TextStyle(color: Color(0xFFB7B0D7)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF2D2553)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF72E8D4)),
        ),
      ),
    );
  }
}

class _AuthBackground extends StatelessWidget {
  const _AuthBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF3B1F5D), Color(0xFF0D082B)],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -80,
            right: -30,
            child: _glowCircle(const Color(0xFF72E8D4).withValues(alpha: 0.2)),
          ),
          Positioned(
            bottom: -90,
            left: -60,
            child: _glowCircle(const Color(0xFFB078FF).withValues(alpha: 0.22)),
          ),
        ],
      ),
    );
  }

  Widget _glowCircle(Color color) {
    return Container(
      width: 260,
      height: 260,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: [color, Colors.transparent]),
      ),
    );
  }
}
