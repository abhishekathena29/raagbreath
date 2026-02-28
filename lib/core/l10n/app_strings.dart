import 'package:flutter/material.dart';

/// All app strings in English and Hindi.
/// Access via `context.strings.someKey` or `AppStrings.of(context).someKey`.
class AppStrings {
  final Map<String, String> _map;
  const AppStrings._(this._map);

  static const _en = {
    // General
    'app_name': 'Raag Breath',
    'hello': 'Hello! 👋',
    'welcome_back': 'Welcome Back',
    'profile': 'Profile',
    'sign_out': 'Sign Out',
    'language': 'Language',
    'english': 'English',
    'hindi': 'हिन्दी',
    'dark_mode': 'Dark Mode',
    'edit': 'Edit',
    'done': 'Done',
    'next': 'Next →',
    'back': '← Back',
    'save': 'Save',
    'cancel': 'Cancel',

    // Home
    'hub_title': 'Your Lung Health Hub',
    'hub_subtitle': 'Choose a section to get started',
    'section_learn': 'Learn',
    'section_learn_sub': 'Build awareness & know your lungs',
    'section_diagnose': 'Diagnose',
    'section_diagnose_sub': 'Check symptoms & assess your risk',
    'section_treatment': 'Treatment',
    'section_treatment_sub': 'Take action & find doctors near you',
    'section_meditation': 'Meditation',
    'section_meditation_sub': 'Breathing exercises to strengthen lungs',
    'section_music': 'Music Therapy',
    'section_music_sub': 'Ragas that calm and enhance breathing',

    // Auth — Login
    'welcome_back_heading': 'Welcome back',
    'sign_in_subtitle': 'Sign in to continue your calm',
    'email': 'Email',
    'password': 'Password',
    'login': 'Login',
    'skip_login': 'Skip Login (Guest)',
    'no_account': "Don't have an account?",
    'sign_up': 'Sign up',
    'login_with_phone': '📱  Login with Phone',
    'login_failed': 'Login Failed',

    // Auth — Phone OTP
    'phone_login_title': 'Phone Login',
    'phone_login_subtitle': 'Enter your mobile number to continue',
    'mobile_number': 'Mobile Number',
    'send_otp': 'Send OTP',
    'sending_otp': 'Sending OTP…',
    'enter_otp': 'Enter OTP',
    'otp_sent_to': 'OTP sent to ',
    'verify': 'Verify & Login',
    'verifying': 'Verifying…',
    'resend_otp': 'Resend OTP',
    'phone_hint': 'e.g. 9876543210',
    'otp_hint': '6-digit OTP',
    'invalid_phone': 'Please enter a valid 10-digit mobile number',
    'invalid_otp': 'Please enter the 6-digit OTP',

    // Profile
    'lung_capacity': 'Lung Capacity',
    'dynamic_score': 'Dynamic Score',
    'todays_sadhana': "Today's Sadhana",
    'saved_routines': 'Saved Routines',
    'recent_activity': 'Recent Activity',
    'keep_breathing': 'Keep breathing, keep growing.',
    'estimated': 'Estimated',
    'goal': 'Goal',
    'streak': 'Streak',
    'days': 'Days',
    'total_practice': 'Total Practice',
    'sessions': 'Sessions',
    'view_history': 'View History >',
    'loading_profile': 'Loading Profile…',
    'login_to_view_profile': 'Please login to view profile',
  };

  static const _hi = {
    // General
    'app_name': 'राग ब्रेथ',
    'hello': 'नमस्ते! 👋',
    'welcome_back': 'वापसी पर स्वागत है',
    'profile': 'प्रोफ़ाइल',
    'sign_out': 'साइन आउट',
    'language': 'भाषा',
    'english': 'English',
    'hindi': 'हिन्दी',
    'dark_mode': 'डार्क मोड',
    'edit': 'संपादित करें',
    'done': 'पूर्ण',
    'next': 'आगे →',
    'back': '← वापस',
    'save': 'सहेजें',
    'cancel': 'रद्द करें',

    // Home
    'hub_title': 'आपका फेफड़ा स्वास्थ्य केंद्र',
    'hub_subtitle': 'शुरू करने के लिए एक अनुभाग चुनें',
    'section_learn': 'सीखें',
    'section_learn_sub': 'जागरूकता बढ़ाएं और फेफड़ों को जानें',
    'section_diagnose': 'निदान',
    'section_diagnose_sub': 'लक्षण जांचें और जोखिम का आकलन करें',
    'section_treatment': 'उपचार',
    'section_treatment_sub': 'कार्रवाई करें और पास के डॉक्टर खोजें',
    'section_meditation': 'ध्यान',
    'section_meditation_sub': 'फेफड़ों को मजबूत करने वाले व्यायाम',
    'section_music': 'संगीत चिकित्सा',
    'section_music_sub': 'राग जो सांस को शांत और बेहतर बनाते हैं',

    // Auth — Login
    'welcome_back_heading': 'वापसी पर स्वागत है',
    'sign_in_subtitle': 'अपनी शांति जारी रखने के लिए साइन इन करें',
    'email': 'ईमेल',
    'password': 'पासवर्ड',
    'login': 'लॉगिन',
    'skip_login': 'अतिथि के रूप में जारी रखें',
    'no_account': 'खाता नहीं है?',
    'sign_up': 'साइन अप',
    'login_with_phone': '📱  फ़ोन से लॉगिन करें',
    'login_failed': 'लॉगिन विफल',

    // Auth — Phone OTP
    'phone_login_title': 'फ़ोन लॉगिन',
    'phone_login_subtitle': 'जारी रखने के लिए मोबाइल नंबर दर्ज करें',
    'mobile_number': 'मोबाइल नंबर',
    'send_otp': 'OTP भेजें',
    'sending_otp': 'OTP भेजा जा रहा है…',
    'enter_otp': 'OTP दर्ज करें',
    'otp_sent_to': 'OTP भेजा गया: ',
    'verify': 'सत्यापित करें और लॉगिन करें',
    'verifying': 'सत्यापित हो रहा है…',
    'resend_otp': 'OTP दोबारा भेजें',
    'phone_hint': 'उदा. 9876543210',
    'otp_hint': '6 अंकों का OTP',
    'invalid_phone': 'कृपया 10 अंकों का मान्य मोबाइल नंबर दर्ज करें',
    'invalid_otp': 'कृपया 6 अंकों का OTP दर्ज करें',

    // Profile
    'lung_capacity': 'फेफड़ों की क्षमता',
    'dynamic_score': 'गतिशील स्कोर',
    'todays_sadhana': 'आज की साधना',
    'saved_routines': 'सहेजी दिनचर्या',
    'recent_activity': 'हाल की गतिविधि',
    'keep_breathing': 'सांस लेते रहें, बढ़ते रहें।',
    'estimated': 'अनुमानित',
    'goal': 'लक्ष्य',
    'streak': 'सिलसिला',
    'days': 'दिन',
    'total_practice': 'कुल अभ्यास',
    'sessions': 'सत्र',
    'view_history': 'इतिहास देखें >',
    'loading_profile': 'प्रोफ़ाइल लोड हो रही है…',
    'login_to_view_profile': 'प्रोफ़ाइल देखने के लिए लॉगिन करें',
  };

  factory AppStrings.of(BuildContext context) {
    final locale = Localizations.localeOf(context);
    if (locale.languageCode == 'hi') return AppStrings._(_hi);
    return AppStrings._(_en);
  }

  String get(String key) => _map[key] ?? _en[key] ?? key;

  // ── Convenience getters ──────────────────────────────────────────────────
  String get appName => get('app_name');
  String get hello => get('hello');
  String get welcomeBack => get('welcome_back');
  String get profile => get('profile');
  String get signOut => get('sign_out');
  String get language => get('language');
  String get english => get('english');
  String get hindi => get('hindi');
  String get hubTitle => get('hub_title');
  String get hubSubtitle => get('hub_subtitle');
  String get sectionLearn => get('section_learn');
  String get sectionLearnSub => get('section_learn_sub');
  String get sectionDiagnose => get('section_diagnose');
  String get sectionDiagnoseSub => get('section_diagnose_sub');
  String get sectionTreatment => get('section_treatment');
  String get sectionTreatmentSub => get('section_treatment_sub');
  String get sectionMeditation => get('section_meditation');
  String get sectionMeditationSub => get('section_meditation_sub');
  String get sectionMusic => get('section_music');
  String get sectionMusicSub => get('section_music_sub');
  String get welcomeBackHeading => get('welcome_back_heading');
  String get signInSubtitle => get('sign_in_subtitle');
  String get email => get('email');
  String get password => get('password');
  String get login => get('login');
  String get skipLogin => get('skip_login');
  String get noAccount => get('no_account');
  String get signUp => get('sign_up');
  String get loginWithPhone => get('login_with_phone');
  String get loginFailed => get('login_failed');
  String get phoneLoginTitle => get('phone_login_title');
  String get phoneLoginSubtitle => get('phone_login_subtitle');
  String get mobileNumber => get('mobile_number');
  String get sendOtp => get('send_otp');
  String get sendingOtp => get('sending_otp');
  String get enterOtp => get('enter_otp');
  String get otpSentTo => get('otp_sent_to');
  String get verify => get('verify');
  String get verifying => get('verifying');
  String get resendOtp => get('resend_otp');
  String get phoneHint => get('phone_hint');
  String get otpHint => get('otp_hint');
  String get invalidPhone => get('invalid_phone');
  String get invalidOtp => get('invalid_otp');
  String get lungCapacity => get('lung_capacity');
  String get dynamicScore => get('dynamic_score');
  String get todaysSadhana => get('todays_sadhana');
  String get savedRoutines => get('saved_routines');
  String get recentActivity => get('recent_activity');
  String get keepBreathing => get('keep_breathing');
  String get estimated => get('estimated');
  String get goal => get('goal');
  String get streak => get('streak');
  String get days => get('days');
  String get totalPractice => get('total_practice');
  String get sessions => get('sessions');
  String get viewHistory => get('view_history');
  String get loadingProfile => get('loading_profile');
  String get loginToViewProfile => get('login_to_view_profile');
}

extension AppStringsX on BuildContext {
  AppStrings get strings => AppStrings.of(this);
}
