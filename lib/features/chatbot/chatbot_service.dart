import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter/foundation.dart';

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({required this.text, required this.isUser, DateTime? timestamp})
    : timestamp = timestamp ?? DateTime.now();
}

class ChatbotService extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  GenerativeModel? _model;
  ChatSession? _chat;
  bool _isInitialized = false;
  bool _isLoading = false;
  String? _error;

  final List<ChatMessage> _messages = [];

  List<ChatMessage> get messages => List.unmodifiable(_messages);
  bool get isInitialized => _isInitialized;
  bool get isLoading => _isLoading;
  String? get error => _error;

  static const String _systemPrompt = '''
You are a friendly, knowledgeable lung health assistant called "RaagBreath AI".
Your expertise covers:
- Respiratory anatomy and how lungs work
- Breathing exercises (pranayama, diaphragmatic breathing, pursed-lip breathing)
- Common lung conditions (asthma, COPD, bronchitis, pneumonia)
- Air quality and pollution awareness (AQI, PM2.5)
- Tips for maintaining healthy lungs
- When to see a doctor for respiratory symptoms
- Yoga and meditation for lung health

Guidelines:
- Always be empathetic, encouraging, and supportive.
- Use simple language that anyone can understand.
- If asked about topics outside lung/respiratory health, politely redirect the conversation back.
- Never provide specific medical diagnoses. Always recommend consulting a doctor for serious concerns.
- Keep responses concise (2-4 paragraphs max) unless the user asks for detailed information.
- Use emojis sparingly to keep the tone warm and friendly.
''';

  Future<void> initialize() async {
    if (_isInitialized) return;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Fetch API key and model from Firestore
      final doc = await _db.collection('app_config').doc('gemini').get();

      if (!doc.exists || doc.data() == null) {
        throw Exception('Gemini configuration not found in Firestore');
      }

      final data = doc.data()!;
      final apiKey = data['apiKey'] as String?;
      final modelName = data['model'] as String? ?? 'gemini-2.0-flash';

      if (apiKey == null || apiKey.isEmpty) {
        throw Exception('API key not configured');
      }

      _model = GenerativeModel(
        model: modelName,
        apiKey: apiKey,
        systemInstruction: Content.text(_systemPrompt),
      );

      _chat = _model!.startChat();
      _isInitialized = true;

      // Add welcome message
      _messages.add(
        ChatMessage(
          text:
              'Hello! 👋 I\'m your Lung Health Assistant. You can ask me anything about breathing exercises, lung conditions, air quality, or how to keep your lungs healthy. How can I help you today?',
          isUser: false,
        ),
      );
    } catch (e) {
      _error = e.toString();
      debugPrint('ChatbotService init error: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> sendMessage(String text) async {
    if (!_isInitialized || _chat == null) return;
    if (text.trim().isEmpty) return;

    // Add user message
    _messages.add(ChatMessage(text: text.trim(), isUser: true));
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _chat!.sendMessage(Content.text(text.trim()));
      final reply =
          response.text ?? 'I couldn\'t generate a response. Please try again.';

      _messages.add(ChatMessage(text: reply, isUser: false));
    } catch (e) {
      _error = 'Failed to get response. Please try again.';
      _messages.add(
        ChatMessage(
          text: 'Sorry, I encountered an error. Please try again.',
          isUser: false,
        ),
      );
      debugPrint('ChatbotService send error: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  void clearChat() {
    _messages.clear();
    if (_model != null) {
      _chat = _model!.startChat();
    }
    _messages.add(
      ChatMessage(
        text:
            'Chat cleared! 🌬️ Feel free to ask me anything about lung health.',
        isUser: false,
      ),
    );
    notifyListeners();
  }
}
