import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raag_breath/core/l10n/app_strings.dart';
import 'package:raag_breath/features/auth/phone_login.dart';
import 'package:raag_breath/features/auth/services/auth_service.dart';
import 'signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _handleGuestLogin() async {
    setState(() => _isLoading = true);
    try {
      final authService = Provider.of<AuthService>(context, listen: false);
      await authService.signInAsGuest();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Guest Login Failed: $e')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _handleLogin() async {
    setState(() => _isLoading = true);
    try {
      final authService = Provider.of<AuthService>(context, listen: false);
      await authService.signIn(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${context.strings.loginFailed}: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = context.strings;
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
                  const SizedBox(height: 40),
                  // Logo
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFC17D3C).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.air,
                          color: Color(0xFFC17D3C),
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        s.appName,
                        style: const TextStyle(
                          color: Color(0xFF3D2B1F),
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Text(
                    s.welcomeBackHeading,
                    style: const TextStyle(
                      color: Color(0xFF3D2B1F),
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    s.signInSubtitle,
                    style: const TextStyle(
                      color: Color(0xFF8C7B6B),
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 32),
                  _InputField(
                    label: s.email,
                    icon: Icons.mail_outline,
                    controller: _emailController,
                    obscure: false,
                  ),
                  const SizedBox(height: 16),
                  _InputField(
                    label: s.password,
                    icon: Icons.lock_outline,
                    controller: _passwordController,
                    obscure: true,
                  ),
                  const SizedBox(height: 28),
                  if (_isLoading)
                    const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFFC17D3C),
                      ),
                    )
                  else
                    Column(
                      children: [
                        // Email login
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
                              shadowColor: const Color(
                                0xFFC17D3C,
                              ).withOpacity(0.3),
                            ),
                            onPressed: _handleLogin,
                            child: Text(
                              s.login,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Phone login
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF3949AB),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 0,
                            ),
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const PhoneLoginPage(),
                              ),
                            ),
                            child: Text(
                              s.loginWithPhone,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Guest
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFFC17D3C),
                              side: const BorderSide(
                                color: Color(0xFFC17D3C),
                                width: 1.5,
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            onPressed: _handleGuestLogin,
                            child: Text(
                              s.skipLogin,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        s.noAccount,
                        style: const TextStyle(color: Color(0xFF8C7B6B)),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const SignupPage()),
                        ),
                        child: Text(
                          s.signUp,
                          style: const TextStyle(
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
          Positioned(
            top: 200,
            left: -30,
            child: _warmCircle(
              const Color(0xFFC17D3C).withOpacity(0.06),
              size: 180,
            ),
          ),
        ],
      ),
    );
  }

  Widget _warmCircle(Color color, {double size = 260}) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: RadialGradient(colors: [color, Colors.transparent]),
    ),
  );
}
