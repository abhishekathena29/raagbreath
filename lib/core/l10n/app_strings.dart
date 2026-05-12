import 'package:flutter/material.dart';

/// All app strings in English and Hindi.
/// Access via `context.strings.someKey` or `AppStrings.of(context).someKey`.
class AppStrings {
  final Map<String, String> _map;
  const AppStrings._(this._map);

  static const _en = {
    // General
    'app_name': 'Prana',
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
    'friend': 'Friend',
    'good_morning': 'Good Morning',
    'good_afternoon': 'Good Afternoon',
    'good_evening': 'Good Evening',

    // Bottom Navigation
    'nav_home': 'Home',
    'nav_learn': 'Learn',
    'nav_check_in': 'Check-In',
    'nav_access_to_care': 'Access to Care',
    'nav_ai_chat': 'AI Chat',

    // Home — Hub & Sections
    'hub_title': 'Your Lung Health Hub',
    'hub_subtitle': 'Choose a section to get started',
    'section_learn': 'Learn',
    'section_learn_sub': 'Build awareness & know your lungs',
    'section_diagnose': 'Check-In',
    'section_diagnose_sub': 'Reflect on habits & breathing comfort',
    'section_treatment': 'Access to Care',
    'section_treatment_sub': 'Explore calming routines & daily support',
    'section_meditation': 'Meditation',
    'section_meditation_sub': 'Breathing exercises to strengthen lungs',
    'section_music': 'Music Therapy',
    'section_music_sub': 'Ragas that calm and enhance breathing',
    'section_ai_chat': 'AI Chat',

    // Home — Stats & Headers
    'quick_actions': 'Quick Actions',
    'daily_health_tips': 'Daily Health Tips',
    'day_streak': 'Day Streak',
    'lung_score': 'Lung Score',

    // Home — Health Tips
    'tip_deep_breathing_title': 'Deep Breathing',
    'tip_deep_breathing_body': 'Practice deep breathing for 10 minutes daily to improve lung capacity and reduce stress.',
    'tip_hydrate_title': 'Stay Hydrated',
    'tip_hydrate_body': 'Drink at least 8 glasses of water daily. Proper hydration keeps your airways moist and clear.',
    'tip_walk_title': 'Daily Walk',
    'tip_walk_body': 'A 30-minute brisk walk each day strengthens your lungs and improves oxygen intake.',
    'tip_pranayama_title': 'Pranayama',
    'tip_pranayama_body': 'Practice Nadi Shodhana (alternate nostril breathing) to balance energy and improve focus.',
    'tip_fresh_air_title': 'Fresh Air',
    'tip_fresh_air_body': 'Open windows in the morning to ventilate your home and flush out pollutants overnight.',
    'tip_raga_title': 'Raga Therapy',
    'tip_raga_body': 'Listening to Raag Bhairav in the morning supports calm breathing and mental clarity.',

    // User types
    'role_student': 'Student',
    'role_teacher': 'Teacher',
    'role_school_admin': 'School Admin',
    'role_parent': 'Parent',
    'role_ngo': 'NGO',

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

    // Profile — practice items
    'practice_morning_pranayama': 'Morning Pranayama',
    'practice_morning_pranayama_sub': 'Nadi Shodhana + Bhramari',
    'practice_raga_listening': 'Raga Listening',
    'practice_raga_listening_sub': 'Raag Bhairav with tanpura drone',
    'practice_evening_yoga': 'Evening Yoga',
    'practice_evening_yoga_sub': 'Surya Namaskar + moon flow',
    'practice_breath_reset': 'Breath Reset',
    'practice_breath_reset_sub': 'Ujjayi + So-Ham meditation',
    'practice_riyaz_focus': 'Riyaz Focus',
    'practice_riyaz_focus_sub': 'Sa Re Ga warmup + Raag Yaman',
    'practice_night_calm': 'Night Calm',
    'practice_night_calm_sub': 'Yoga Nidra + soft humming',
    'minutes_short': 'min',

    // Treatment / Access to Care
    'access_to_care': 'Access to Care',
    'support_your_routine': 'Support Your Routine',
    'comfort_tools': 'Comfort Tools',
    'comfort_tools_sub': 'Explore simple tools that support easier breathing spaces',
    'classroom_tips': 'Classroom Comfort Tips',
    'classroom_tips_sub': 'Everyday ideas for calmer, cleaner learning spaces',
    'connect_pulmonologists': 'Connect with Pulmonologists',
    'doctor_name': 'Dr Bornali Dutta',
    'doctor_role': 'Director, Senior Pulmonologist',
    'doctor_hospital': 'Medanta Hospital, Gurgaon',
    'whatsapp': 'WhatsApp',

    // Diagnose / Check-In
    'check_in': 'Check-In',
    'breathing_lifestyle_check': 'Breathing & Lifestyle Check-In',
    'breathing_check_in': 'Breathing Check-In',
    'breathing_check_in_sub': 'Quick reflection on how your breathing feels today',
    'air_habit_check': 'Air & Habit Check',
    'air_habit_check_sub': 'See how daily habits may affect your breathing comfort',
    'breath_timer': 'Breath Timer',
    'breath_timer_sub': 'Time a gentle breath-hold practice for awareness',
    'caregiver_tips': 'Caregiver Tips',
    'caregiver_tips_sub': 'Support children with calm routines and cleaner air',

    // Meditation
    'meditation': 'Meditation',
    'meditation_subtitle': 'Guided journeys for stillness and focus.',
    'pranayama_breaths': 'Pranayama Breaths',
    'dhyana_practices': 'Dhyana Practices',
    'yoga_foundations': 'Yoga Foundations',

    // Music
    'music': 'Music',
    'music_subtitle': 'Indian classical practice for breath, raga, and rhythm.',
    'raag_practice': 'Raag Practice',
    'taal_layakari': 'Taal and Layakari',
    'breath_nada': 'Breath + Nada',

    // Learn
    'learn_tag': '📚  LEARN',
    'learn_academy_title': 'Lung Health Academy',
    'module_lungs_title': 'Know Your Lungs',
    'module_lungs_sub': 'Anatomy & Function',
    'module_harm_title': 'What Harms Your Lungs',
    'module_harm_sub': 'Pollution & Allergens',
    'module_healthy_title': 'Keep Your Lungs Healthy',
    'module_healthy_sub': 'Exercise & Diet',
    'module_aqi_title': 'Air Quality Awareness',
    'module_aqi_sub': 'AQI & Safety',
    'tag_foundation': 'FOUNDATION',
    'tag_awareness': 'AWARENESS',
    'tag_health': 'HEALTH',
    'tag_environment': 'ENVIRONMENT',
  };

  static const _hi = {
    // General
    'app_name': 'प्राण',
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
    'friend': 'मित्र',
    'good_morning': 'सुप्रभात',
    'good_afternoon': 'नमस्कार',
    'good_evening': 'शुभ संध्या',

    // Bottom Navigation
    'nav_home': 'होम',
    'nav_learn': 'सीखें',
    'nav_check_in': 'चेक-इन',
    'nav_access_to_care': 'देखभाल',
    'nav_ai_chat': 'एआई चैट',

    // Home — Hub & Sections
    'hub_title': 'आपका फेफड़ा स्वास्थ्य केंद्र',
    'hub_subtitle': 'शुरू करने के लिए एक अनुभाग चुनें',
    'section_learn': 'सीखें',
    'section_learn_sub': 'जागरूकता बढ़ाएं और फेफड़ों को जानें',
    'section_diagnose': 'चेक-इन',
    'section_diagnose_sub': 'आदतों और सांस की सहजता पर ध्यान दें',
    'section_treatment': 'देखभाल तक पहुँच',
    'section_treatment_sub': 'शांत दिनचर्या और दैनिक सहारा खोजें',
    'section_meditation': 'ध्यान',
    'section_meditation_sub': 'फेफड़ों को मजबूत करने वाले व्यायाम',
    'section_music': 'संगीत चिकित्सा',
    'section_music_sub': 'राग जो सांस को शांत और बेहतर बनाते हैं',
    'section_ai_chat': 'एआई चैट',

    // Home — Stats & Headers
    'quick_actions': 'त्वरित क्रियाएँ',
    'daily_health_tips': 'दैनिक स्वास्थ्य सुझाव',
    'day_streak': 'दिनों का सिलसिला',
    'lung_score': 'फेफड़ा स्कोर',

    // Home — Health Tips
    'tip_deep_breathing_title': 'गहरी साँस',
    'tip_deep_breathing_body': 'फेफड़ों की क्षमता बढ़ाने और तनाव कम करने के लिए रोज़ 10 मिनट गहरी साँस लें।',
    'tip_hydrate_title': 'पर्याप्त पानी पिएं',
    'tip_hydrate_body': 'रोज़ कम से कम 8 गिलास पानी पिएं। उचित जलयोजन वायुमार्ग को नम और साफ़ रखता है।',
    'tip_walk_title': 'दैनिक सैर',
    'tip_walk_body': 'रोज़ 30 मिनट तेज़ चलना फेफड़ों को मजबूत करता है और ऑक्सीजन ग्रहण बेहतर करता है।',
    'tip_pranayama_title': 'प्राणायाम',
    'tip_pranayama_body': 'ऊर्जा संतुलित करने और एकाग्रता बढ़ाने के लिए नाड़ी शोधन (अनुलोम-विलोम) करें।',
    'tip_fresh_air_title': 'ताज़ी हवा',
    'tip_fresh_air_body': 'सुबह घर की खिड़कियाँ खोलें ताकि हवा बदले और रात भर के प्रदूषक बाहर निकल जाएं।',
    'tip_raga_title': 'राग चिकित्सा',
    'tip_raga_body': 'सुबह राग भैरव सुनना शांत साँस और मानसिक स्पष्टता में मदद करता है।',

    // User types
    'role_student': 'विद्यार्थी',
    'role_teacher': 'शिक्षक',
    'role_school_admin': 'विद्यालय प्रशासक',
    'role_parent': 'अभिभावक',
    'role_ngo': 'एनजीओ',

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

    // Profile — practice items
    'practice_morning_pranayama': 'प्रातः प्राणायाम',
    'practice_morning_pranayama_sub': 'नाड़ी शोधन + भ्रामरी',
    'practice_raga_listening': 'राग श्रवण',
    'practice_raga_listening_sub': 'तानपूरे के साथ राग भैरव',
    'practice_evening_yoga': 'सायं योग',
    'practice_evening_yoga_sub': 'सूर्य नमस्कार + चंद्र प्रवाह',
    'practice_breath_reset': 'श्वास पुनर्संतुलन',
    'practice_breath_reset_sub': 'उज्जायी + सो-हम ध्यान',
    'practice_riyaz_focus': 'रियाज़ केंद्र',
    'practice_riyaz_focus_sub': 'सा-रे-गा वार्मअप + राग यमन',
    'practice_night_calm': 'रात्रि शांति',
    'practice_night_calm_sub': 'योग निद्रा + मधुर गुंजन',
    'minutes_short': 'मि',

    // Treatment / Access to Care
    'access_to_care': 'देखभाल तक पहुँच',
    'support_your_routine': 'अपनी दिनचर्या में सहारा',
    'comfort_tools': 'आराम के उपकरण',
    'comfort_tools_sub': 'सरल उपकरण जो आसान साँस लेने में मदद करते हैं',
    'classroom_tips': 'कक्षा आराम सुझाव',
    'classroom_tips_sub': 'शांत और स्वच्छ अध्ययन स्थलों के लिए रोज़मर्रा के विचार',
    'connect_pulmonologists': 'पल्मोनोलॉजिस्ट से संपर्क करें',
    'doctor_name': 'डॉ. बोर्नाली दत्ता',
    'doctor_role': 'निदेशक, वरिष्ठ पल्मोनोलॉजिस्ट',
    'doctor_hospital': 'मेदांता अस्पताल, गुड़गांव',
    'whatsapp': 'व्हाट्सऐप',

    // Diagnose / Check-In
    'check_in': 'चेक-इन',
    'breathing_lifestyle_check': 'श्वास और जीवनशैली चेक-इन',
    'breathing_check_in': 'श्वास चेक-इन',
    'breathing_check_in_sub': 'आज आपकी साँस कैसी लग रही है, इस पर एक त्वरित विचार',
    'air_habit_check': 'वायु और आदत जाँच',
    'air_habit_check_sub': 'देखें कि दैनिक आदतें आपकी साँस को कैसे प्रभावित कर सकती हैं',
    'breath_timer': 'श्वास टाइमर',
    'breath_timer_sub': 'जागरूकता के लिए हल्की श्वास-धारण अभ्यास का समय लें',
    'caregiver_tips': 'देखभालकर्ता सुझाव',
    'caregiver_tips_sub': 'शांत दिनचर्या और स्वच्छ हवा से बच्चों का सहारा',

    // Meditation
    'meditation': 'ध्यान',
    'meditation_subtitle': 'स्थिरता और एकाग्रता के लिए निर्देशित यात्राएँ।',
    'pranayama_breaths': 'प्राणायाम श्वास',
    'dhyana_practices': 'ध्यान अभ्यास',
    'yoga_foundations': 'योग आधार',

    // Music
    'music': 'संगीत',
    'music_subtitle': 'श्वास, राग और लय के लिए भारतीय शास्त्रीय अभ्यास।',
    'raag_practice': 'राग अभ्यास',
    'taal_layakari': 'ताल और लयकारी',
    'breath_nada': 'श्वास + नाद',

    // Learn
    'learn_tag': '📚  सीखें',
    'learn_academy_title': 'फेफड़ा स्वास्थ्य अकादमी',
    'module_lungs_title': 'अपने फेफड़ों को जानें',
    'module_lungs_sub': 'शरीर रचना और कार्य',
    'module_harm_title': 'फेफड़ों को क्या नुकसान पहुँचाता है',
    'module_harm_sub': 'प्रदूषण और एलर्जन',
    'module_healthy_title': 'फेफड़ों को स्वस्थ रखें',
    'module_healthy_sub': 'व्यायाम और आहार',
    'module_aqi_title': 'वायु गुणवत्ता जागरूकता',
    'module_aqi_sub': 'एक्यूआई और सुरक्षा',
    'tag_foundation': 'आधार',
    'tag_awareness': 'जागरूकता',
    'tag_health': 'स्वास्थ्य',
    'tag_environment': 'पर्यावरण',
  };

  factory AppStrings.of(BuildContext context) {
    final locale = Localizations.localeOf(context);
    if (locale.languageCode == 'hi') return AppStrings._(_hi);
    return AppStrings._(_en);
  }

  String get(String key) => _map[key] ?? _en[key] ?? key;

  /// Time-of-day greeting in the active locale.
  String get greetingNow {
    final h = DateTime.now().hour;
    if (h < 12) return get('good_morning');
    if (h < 17) return get('good_afternoon');
    return get('good_evening');
  }

  // ── Convenience getters ──────────────────────────────────────────────────
  String get appName => get('app_name');
  String get hello => get('hello');
  String get welcomeBack => get('welcome_back');
  String get profile => get('profile');
  String get signOut => get('sign_out');
  String get language => get('language');
  String get english => get('english');
  String get hindi => get('hindi');
  String get darkMode => get('dark_mode');
  String get edit => get('edit');
  String get done => get('done');
  String get next => get('next');
  String get back => get('back');
  String get save => get('save');
  String get cancel => get('cancel');
  String get friend => get('friend');

  String get navHome => get('nav_home');
  String get navLearn => get('nav_learn');
  String get navCheckIn => get('nav_check_in');
  String get navAccessToCare => get('nav_access_to_care');
  String get navAiChat => get('nav_ai_chat');

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
  String get sectionAiChat => get('section_ai_chat');

  String get quickActions => get('quick_actions');
  String get dailyHealthTips => get('daily_health_tips');
  String get dayStreak => get('day_streak');
  String get lungScore => get('lung_score');

  String get tipDeepBreathingTitle => get('tip_deep_breathing_title');
  String get tipDeepBreathingBody => get('tip_deep_breathing_body');
  String get tipHydrateTitle => get('tip_hydrate_title');
  String get tipHydrateBody => get('tip_hydrate_body');
  String get tipWalkTitle => get('tip_walk_title');
  String get tipWalkBody => get('tip_walk_body');
  String get tipPranayamaTitle => get('tip_pranayama_title');
  String get tipPranayamaBody => get('tip_pranayama_body');
  String get tipFreshAirTitle => get('tip_fresh_air_title');
  String get tipFreshAirBody => get('tip_fresh_air_body');
  String get tipRagaTitle => get('tip_raga_title');
  String get tipRagaBody => get('tip_raga_body');

  String get roleStudent => get('role_student');
  String get roleTeacher => get('role_teacher');
  String get roleSchoolAdmin => get('role_school_admin');
  String get roleParent => get('role_parent');
  String get roleNgo => get('role_ngo');

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

  String get practiceMorningPranayama => get('practice_morning_pranayama');
  String get practiceMorningPranayamaSub => get('practice_morning_pranayama_sub');
  String get practiceRagaListening => get('practice_raga_listening');
  String get practiceRagaListeningSub => get('practice_raga_listening_sub');
  String get practiceEveningYoga => get('practice_evening_yoga');
  String get practiceEveningYogaSub => get('practice_evening_yoga_sub');
  String get practiceBreathReset => get('practice_breath_reset');
  String get practiceBreathResetSub => get('practice_breath_reset_sub');
  String get practiceRiyazFocus => get('practice_riyaz_focus');
  String get practiceRiyazFocusSub => get('practice_riyaz_focus_sub');
  String get practiceNightCalm => get('practice_night_calm');
  String get practiceNightCalmSub => get('practice_night_calm_sub');
  String get minutesShort => get('minutes_short');

  String get accessToCare => get('access_to_care');
  String get supportYourRoutine => get('support_your_routine');
  String get comfortTools => get('comfort_tools');
  String get comfortToolsSub => get('comfort_tools_sub');
  String get classroomTips => get('classroom_tips');
  String get classroomTipsSub => get('classroom_tips_sub');
  String get connectPulmonologists => get('connect_pulmonologists');
  String get doctorName => get('doctor_name');
  String get doctorRole => get('doctor_role');
  String get doctorHospital => get('doctor_hospital');
  String get whatsapp => get('whatsapp');

  String get checkIn => get('check_in');
  String get breathingLifestyleCheck => get('breathing_lifestyle_check');
  String get breathingCheckIn => get('breathing_check_in');
  String get breathingCheckInSub => get('breathing_check_in_sub');
  String get airHabitCheck => get('air_habit_check');
  String get airHabitCheckSub => get('air_habit_check_sub');
  String get breathTimer => get('breath_timer');
  String get breathTimerSub => get('breath_timer_sub');
  String get caregiverTips => get('caregiver_tips');
  String get caregiverTipsSub => get('caregiver_tips_sub');

  String get meditation => get('meditation');
  String get meditationSubtitle => get('meditation_subtitle');
  String get pranayamaBreaths => get('pranayama_breaths');
  String get dhyanaPractices => get('dhyana_practices');
  String get yogaFoundations => get('yoga_foundations');

  String get music => get('music');
  String get musicSubtitle => get('music_subtitle');
  String get raagPractice => get('raag_practice');
  String get taalLayakari => get('taal_layakari');
  String get breathNada => get('breath_nada');

  String get learnTag => get('learn_tag');
  String get learnAcademyTitle => get('learn_academy_title');
  String get moduleLungsTitle => get('module_lungs_title');
  String get moduleLungsSub => get('module_lungs_sub');
  String get moduleHarmTitle => get('module_harm_title');
  String get moduleHarmSub => get('module_harm_sub');
  String get moduleHealthyTitle => get('module_healthy_title');
  String get moduleHealthySub => get('module_healthy_sub');
  String get moduleAqiTitle => get('module_aqi_title');
  String get moduleAqiSub => get('module_aqi_sub');
  String get tagFoundation => get('tag_foundation');
  String get tagAwareness => get('tag_awareness');
  String get tagHealth => get('tag_health');
  String get tagEnvironment => get('tag_environment');
}

extension AppStringsX on BuildContext {
  AppStrings get strings => AppStrings.of(this);
}
