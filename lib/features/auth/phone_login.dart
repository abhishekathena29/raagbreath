import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:raag_breath/core/l10n/app_strings.dart';

class PhoneLoginPage extends StatefulWidget {
  const PhoneLoginPage({super.key});

  @override
  State<PhoneLoginPage> createState() => _PhoneLoginPageState();
}

class _PhoneLoginPageState extends State<PhoneLoginPage> {
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  final _phoneFocus = FocusNode();
  final _otpFocus = FocusNode();

  bool _otpSent = false;
  bool _isLoading = false;
  String _verificationId = '';
  int? _resendToken;
  String _phoneForDisplay = '';

  static const _accentTop = Color(0xFF1A237E);
  static const _accentBot = Color(0xFF3949AB);
  static const _accent = Color(0xFF3949AB);

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    _phoneFocus.dispose();
    _otpFocus.dispose();
    super.dispose();
  }

  // ── Step 1: Send OTP ──────────────────────────────────────────────────────

  Future<void> _sendOtp() async {
    final s = context.strings;
    final phone = _phoneController.text.trim();
    if (phone.length != 10 || int.tryParse(phone) == null) {
      _showError(s.invalidPhone);
      return;
    }

    setState(() => _isLoading = true);
    _phoneForDisplay = phone;
    final fullNumber = '+91$phone';

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: fullNumber,
      forceResendingToken: _resendToken,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Android auto-retrieval
        await _signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        if (mounted) {
          setState(() => _isLoading = false);
          _showError(e.message ?? 'Verification failed. Check your number.');
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        if (mounted) {
          setState(() {
            _verificationId = verificationId;
            _resendToken = resendToken;
            _otpSent = true;
            _isLoading = false;
          });
          Future.delayed(const Duration(milliseconds: 200), () {
            if (mounted) _otpFocus.requestFocus();
          });
        }
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        if (mounted) _verificationId = verificationId;
      },
    );
  }

  // ── Step 2: Verify OTP ───────────────────────────────────────────────────

  Future<void> _verifyOtp() async {
    final s = context.strings;
    final code = _otpController.text.trim();
    if (code.length != 6) {
      _showError(s.invalidOtp);
      return;
    }
    setState(() => _isLoading = true);
    final credential = PhoneAuthProvider.credential(
      verificationId: _verificationId,
      smsCode: code,
    );
    await _signInWithCredential(credential);
  }

  Future<void> _signInWithCredential(PhoneAuthCredential credential) async {
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      // AuthGate handles navigation automatically on auth state change
      if (mounted) Navigator.of(context).popUntil((r) => r.isFirst);
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        _showError(e.message ?? 'Invalid OTP. Please try again.');
      }
    }
  }

  void _showError(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: Colors.redAccent),
    );
  }

  // ── UI ────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final s = context.strings;
    return Scaffold(
      backgroundColor: const Color(0xFFEEF0FF),
      body: Stack(
        children: [
          // Background decor
          Positioned(
            top: -80,
            right: -40,
            child: _decCircle(const Color(0xFF3949AB).withValues(alpha: 0.08)),
          ),
          Positioned(
            bottom: -100,
            left: -60,
            child: _decCircle(const Color(0xFF1A237E).withValues(alpha: 0.06)),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back button
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.06),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: _accentTop,
                        size: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Header
                  Container(
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [_accentTop, _accentBot],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('📱', style: TextStyle(fontSize: 40)),
                        const SizedBox(height: 10),
                        Text(
                          s.phoneLoginTitle,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          s.phoneLoginSubtitle,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  if (!_otpSent) _buildPhoneStep(s) else _buildOtpStep(s),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneStep(AppStrings s) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        s.mobileNumber,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: Color(0xFF1A237E),
        ),
      ),
      const SizedBox(height: 10),
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 17),
              decoration: BoxDecoration(
                color: _accent.withValues(alpha: 0.08),
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(16),
                ),
                border: Border(
                  right: BorderSide(color: _accent.withValues(alpha: 0.2)),
                ),
              ),
              child: const Text(
                '+91  🇮🇳',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: _accent,
                ),
              ),
            ),
            Expanded(
              child: TextField(
                controller: _phoneController,
                focusNode: _phoneFocus,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                style: const TextStyle(
                  fontSize: 16,
                  letterSpacing: 1.5,
                  color: Color(0xFF1A237E),
                ),
                decoration: InputDecoration(
                  hintText: s.phoneHint,
                  hintStyle: const TextStyle(
                    color: Color(0xFFBDBDBD),
                    letterSpacing: 0,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 10),
      const Text(
        'India (+91) only. SMS rates may apply.',
        style: TextStyle(fontSize: 11, color: Color(0xFF9E9E9E)),
      ),
      const SizedBox(height: 28),
      SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _isLoading ? null : _sendOtp,
          style: ElevatedButton.styleFrom(
            backgroundColor: _accent,
            foregroundColor: Colors.white,
            disabledBackgroundColor: _accent.withValues(alpha: 0.4),
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          child: _isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : Text(s.sendOtp),
        ),
      ),
    ],
  );

  Widget _buildOtpStep(AppStrings s) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _accent.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            const Icon(Icons.check_circle_rounded, color: _accent, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                '${s.otpSentTo}+91 $_phoneForDisplay',
                style: const TextStyle(
                  color: _accent,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 24),
      Text(
        s.enterOtp,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: Color(0xFF1A237E),
        ),
      ),
      const SizedBox(height: 10),
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
            ),
          ],
        ),
        child: TextField(
          controller: _otpController,
          focusNode: _otpFocus,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(6),
          ],
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 24,
            letterSpacing: 8,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A237E),
          ),
          decoration: InputDecoration(
            hintText: '_ _ _ _ _ _',
            hintStyle: const TextStyle(
              color: Color(0xFFBDBDBD),
              letterSpacing: 4,
              fontSize: 20,
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 18,
            ),
          ),
        ),
      ),
      const SizedBox(height: 28),
      SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _isLoading ? null : _verifyOtp,
          style: ElevatedButton.styleFrom(
            backgroundColor: _accent,
            foregroundColor: Colors.white,
            disabledBackgroundColor: _accent.withValues(alpha: 0.4),
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          child: _isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : Text(s.verify),
        ),
      ),
      const SizedBox(height: 16),
      Center(
        child: TextButton.icon(
          onPressed: _isLoading
              ? null
              : () {
                  setState(() {
                    _otpSent = false;
                    _otpController.clear();
                  });
                },
          icon: const Icon(Icons.refresh_rounded, size: 16, color: _accent),
          label: Text(
            s.resendOtp,
            style: const TextStyle(color: _accent, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    ],
  );

  Widget _decCircle(Color color) => Container(
    width: 260,
    height: 260,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: RadialGradient(colors: [color, Colors.transparent]),
    ),
  );
}
