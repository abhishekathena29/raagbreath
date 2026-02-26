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
      backgroundColor: const Color(0xFFFBF6EF),
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
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Color(0xFF3D2B1F),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Create account',
                    style: TextStyle(
                      color: Color(0xFF3D2B1F),
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Join us with your email',
                    style: TextStyle(color: Color(0xFF8C7B6B), fontSize: 15),
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
                        color: Color(0xFFC17D3C),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      labelStyle: const TextStyle(color: Color(0xFF8C7B6B)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Color(0xFFE8DDD0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Color(0xFFC17D3C),
                          width: 1.5,
                        ),
                      ),
                    ),
                    dropdownColor: Colors.white,
                    style: const TextStyle(color: Color(0xFF3D2B1F)),
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
                  const SizedBox(height: 28),
                  if (_isLoading)
                    const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFFC17D3C),
                      ),
                    )
                  else
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFC17D3C),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 2,
                          shadowColor: const Color(0xFFC17D3C).withOpacity(0.3),
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
                        style: TextStyle(color: Color(0xFF8C7B6B)),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: Color(0xFFC17D3C),
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
      cursorColor: const Color(0xFFC17D3C),
      style: const TextStyle(color: Color(0xFF3D2B1F)),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: const Color(0xFFC17D3C)),
        filled: true,
        fillColor: Colors.white,
        labelStyle: const TextStyle(color: Color(0xFF8C7B6B)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFE8DDD0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFC17D3C), width: 1.5),
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
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFBF6EF), Color(0xFFF0E6D6)],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -80,
            right: -40,
            child: _warmCircle(const Color(0xFFC17D3C).withOpacity(0.10)),
          ),
          Positioned(
            bottom: -100,
            left: -60,
            child: _warmCircle(const Color(0xFF8B6B4A).withOpacity(0.08)),
          ),
        ],
      ),
    );
  }

  Widget _warmCircle(Color color) {
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
