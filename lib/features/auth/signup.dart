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
                  const SizedBox(height: 8),
                  // Logo + Brand
                  Row(
                    children: [
                      Image.asset(
                        'assets/logo.png',
                        width: 48,
                        height: 48,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Prana',
                            style: TextStyle(
                              color: Color(0xFF3D2B1F),
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            'Raag Breath',
                            style: TextStyle(
                              color: Color(0xFFC17D3C),
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
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
                  const SizedBox(height: 8),
                  const Text(
                    'I am a:',
                    style: TextStyle(
                      color: Color(0xFF3D2B1F),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _UserTypeSelector(
                    selected: _selectedUserType,
                    onChanged: (type) =>
                        setState(() => _selectedUserType = type),
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

// ─── User Type Selector ───────────────────────────────────────────────────────

class _UserTypeConfig {
  final UserType type;
  final String label;
  final IconData icon;
  final Color color;
  const _UserTypeConfig(this.type, this.label, this.icon, this.color);
}

class _UserTypeSelector extends StatelessWidget {
  final UserType selected;
  final ValueChanged<UserType> onChanged;

  const _UserTypeSelector({required this.selected, required this.onChanged});

  static const _types = [
    _UserTypeConfig(
      UserType.student,
      'Student',
      Icons.school_rounded,
      Color(0xFF1565C0),
    ),
    _UserTypeConfig(
      UserType.teacher,
      'Teacher',
      Icons.menu_book_rounded,
      Color(0xFF00695C),
    ),
    _UserTypeConfig(
      UserType.parent,
      'Parent',
      Icons.family_restroom_rounded,
      Color(0xFF6A1B9A),
    ),
    _UserTypeConfig(
      UserType.schoolAdmin,
      'School Admin',
      Icons.admin_panel_settings_rounded,
      Color(0xFFE65100),
    ),
    _UserTypeConfig(
      UserType.ngo,
      'NGO',
      Icons.people_alt_rounded,
      Color(0xFF880E4F),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Split into rows: first row 3, second row 2
    final row1 = _types.sublist(0, 3);
    final row2 = _types.sublist(3);

    return Column(
      children: [
        Row(
          children: row1
              .map(
                (cfg) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: _TypeCard(
                      cfg: cfg,
                      isSelected: selected == cfg.type,
                      onTap: () => onChanged(cfg.type),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const Spacer(flex: 1),
            ...row2.map(
              (cfg) => Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: _TypeCard(
                    cfg: cfg,
                    isSelected: selected == cfg.type,
                    onTap: () => onChanged(cfg.type),
                  ),
                ),
              ),
            ),
            const Spacer(flex: 1),
          ],
        ),
      ],
    );
  }
}

class _TypeCard extends StatefulWidget {
  final _UserTypeConfig cfg;
  final bool isSelected;
  final VoidCallback onTap;
  const _TypeCard({
    required this.cfg,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_TypeCard> createState() => _TypeCardState();
}

class _TypeCardState extends State<_TypeCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scale = Tween(
      begin: 1.0,
      end: 0.94,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cfg = widget.cfg;
    final sel = widget.isSelected;
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) {
        _ctrl.reverse();
        widget.onTap();
      },
      onTapCancel: () => _ctrl.reverse(),
      child: ScaleTransition(
        scale: _scale,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
          decoration: BoxDecoration(
            color: sel ? cfg.color.withOpacity(0.08) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: sel ? cfg.color : const Color(0xFFE8DDD0),
              width: sel ? 2 : 1.5,
            ),
            boxShadow: sel
                ? [
                    BoxShadow(
                      color: cfg.color.withOpacity(0.15),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                cfg.icon,
                color: sel ? cfg.color : const Color(0xFF8C7B6B),
                size: 28,
              ),
              const SizedBox(height: 6),
              Text(
                cfg.label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: sel ? FontWeight.w700 : FontWeight.w500,
                  color: sel ? cfg.color : const Color(0xFF3D2B1F),
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
