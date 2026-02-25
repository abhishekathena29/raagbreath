import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raag_breath/features/auth/models/user_model.dart';
import 'package:raag_breath/features/auth/services/auth_service.dart';
import 'package:raag_breath/features/auth/services/firestore_service.dart';
import 'onboarding_screen.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  UserType _selectedUserType = UserType.student;
  bool _isLoading = false;

  Future<void> _handleSignup() async {
    setState(() => _isLoading = true);

    try {
      final authService = Provider.of<AuthService>(context, listen: false);
      final firestoreService = FirestoreService();

      // 1. Create Auth User
      final user = await authService.signUp(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      if (user != null) {
        // 2. Create Firestore User with defaults
        final userModel = UserModel(
          uid: user.uid,
          email: user.email!,
          name: _nameController.text.trim(),
          age: 0, // Placeholder
          heightCm: 0, // Placeholder
          weightKg: 0, // Placeholder
          gender: Gender.male, // Placeholder
          activityLevel: ActivityLevel.moderate, // Placeholder
          userType: _selectedUserType,
        );

        await firestoreService.createUser(userModel);

        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const OnboardingScreen()),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Signup Failed: $e')));
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
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Create account',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Join us with your email',
                    style: TextStyle(color: Color(0xFFB7B0D7), fontSize: 15),
                  ),
                  const SizedBox(height: 28),
                  _InputField(
                    label: 'Full Name',
                    icon: Icons.person_outline,
                    controller: _nameController,
                    obscure: false,
                  ),
                  const SizedBox(height: 16),
                  _InputField(
                    label: 'Email',
                    icon: Icons.mail_outline,
                    controller: _emailController,
                    obscure: false,
                  ),
                  const SizedBox(height: 16),
                  _InputField(
                    label: 'Password',
                    icon: Icons.lock_outline,
                    controller: _passwordController,
                    obscure: true,
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<UserType>(
                    value: _selectedUserType,
                    decoration: InputDecoration(
                      labelText: 'Role',
                      prefixIcon: const Icon(
                        Icons.badge_outlined,
                        color: Color(0xFF72E8D4),
                      ),
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
                    dropdownColor: const Color(0xFF1A143C),
                    style: const TextStyle(color: Colors.white),
                    items: UserType.values.map((type) {
                      String label = type.name;
                      if (type == UserType.schoolAdmin)
                        label = 'School Administrator';
                      if (type == UserType.ngo) label = 'NGO';
                      return DropdownMenuItem(
                        value: type,
                        child: Text(
                          label.substring(0, 1).toUpperCase() +
                              label.substring(1),
                        ),
                      );
                    }).toList(),
                    onChanged: (UserType? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _selectedUserType = newValue;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 22),
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
                          elevation: 4,
                        ),
                        onPressed: _handleSignup,
                        child: const Text(
                          'Sign up',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account?',
                        style: TextStyle(color: Color(0xFFB7B0D7)),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: Color(0xFF72E8D4),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  const _InputField({
    required this.label,
    required this.icon,
    required this.controller,
    required this.obscure,
  });

  final String label;
  final IconData icon;
  final TextEditingController controller;
  final bool obscure;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscure,
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
