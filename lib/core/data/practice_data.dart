import 'package:flutter/material.dart';
import '../models/practice_item.dart';

class PracticeData {
  static const List<PracticeItem> pranayama = [
    PracticeItem(
      id: 'nadi_shodhana',
      title: 'Nadi Shodhana',
      subtitle: 'Alternate nostril breathing for balance.',
      meta: '6-8 min',
      accent: Color(0xFF72E8D4),
      purpose: 'Balances the nervous system and calms the mind.',
      description:
          'Nadi Shodhana is a gentle breathing practice that involves alternating the breath between the left and right nostrils. It helps reduce stress, improve focus, and bring mental clarity.',
      steps: [
        'Sit comfortably with your spine straight.',
        'Close your right nostril with your right thumb and inhale through the left nostril.',
        'Close the left nostril with your ring finger and exhale through the right nostril.',
        'Inhale through the right nostril.',
        'Switch again and exhale through the left nostril.',
        'This completes one round. Continue slowly.',
      ],
      videoUrl: 'https://www.youtube.com/watch?v=n7dDoXEVLU0',
    ),
    PracticeItem(
      id: 'bhramari',
      title: 'Bhramari',
      subtitle: 'Humming breath to calm the nervous system.',
      meta: '4-6 min',
      accent: Color(0xFF5AD8FE),
      purpose: 'Calms the nervous system and reduces anxiety.',
      description:
          'Bhramari involves producing a soft humming sound during exhalation. The vibration helps soothe the mind and release mental tension.',
      steps: [
        'Sit comfortably and close your eyes.',
        'Inhale deeply through the nose.',
        'Exhale slowly while making a gentle humming sound.',
        'Feel the vibration in your head and chest.',
        'Repeat in a relaxed manner.',
      ],
      videoUrl: 'https://www.youtube.com/watch?v=Q3Y-aYucA8c',
    ),
    PracticeItem(
      id: 'ujjayi',
      title: 'Ujjayi',
      subtitle: 'Ocean breath to deepen focus.',
      meta: '5-7 min',
      accent: Color(0xFFB0A3FF),
      purpose: 'Deepens focus and promotes steady awareness.',
      description:
          'Ujjayi breathing is performed by gently constricting the throat, creating a soft ocean-like sound. It is commonly used to enhance concentration and regulate breath.',
      steps: [
        'Sit comfortably or lie down.',
        'Inhale slowly through the nose while slightly tightening the throat.',
        'Exhale through the nose with the same gentle throat contraction.',
        'Maintain a smooth, steady rhythm.',
        'Keep the breath slow and controlled.',
      ],
      videoUrl: 'https://www.youtube.com/watch?v=U6GV_qC32f8',
    ),
    PracticeItem(
      id: 'kapalabhati',
      title: 'Kapalabhati',
      subtitle: 'Cleansing breath for energy.',
      meta: '3-5 min',
      accent: Color(0xFFB078FF),
      purpose: 'Energizes the body and improves digestion.',
      description:
          'Kapalabhati is a cleansing technique involving rapid, forceful exhalations and passive inhalations. It stimulates energy and clears the respiratory system.',
      steps: [
        'Sit upright with hands resting on knees.',
        'Take a deep inhale.',
        'Forcefully exhale through the nose by contracting the abdomen.',
        'Allow inhalation to happen naturally.',
        'Continue in short, rhythmic bursts.',
      ],
      videoUrl: 'https://www.youtube.com/watch?v=k3PU0AM7X8M',
    ),
  ];

  static const List<PracticeItem> raagPractice = [
    PracticeItem(
      id: 'raag_yaman',
      title: 'Raag Yaman',
      subtitle: 'Evening raag for clarity and devotion.',
      meta: 'Evening',
      accent: Color(0xFF72E8D4),
      timeOfDay: 'Evening',
      mood: 'Clarity, devotion, openness',
      description:
          'Raag Yaman is a serene evening raga that evokes calmness and inner clarity. It is traditionally associated with devotion and expansive awareness, making it ideal for winding down or reflective listening.',
      steps: [
        'Sit or lie down comfortably in a quiet space.',
        'Play a slow, unhurried rendition of Raag Yaman.',
        'Keep your breath natural and relaxed.',
        'Gently notice the flow of notes without analysis.',
        'If the mind wanders, bring attention back to the melody.',
      ],
    ),
    PracticeItem(
      id: 'raag_bhairav',
      title: 'Raag Bhairav',
      subtitle: 'Morning raag for grounded focus.',
      meta: 'Early morning',
      accent: Color(0xFF5AD8FE),
      timeOfDay: 'Early morning',
      mood: 'Grounding, stability, focus',
      description:
          'Raag Bhairav is a profound morning raga known for its serious and meditative character. It promotes grounded awareness and mental discipline.',
      steps: [
        'Practice shortly after waking up.',
        'Sit upright with eyes closed or softly open.',
        'Listen attentively to the slow unfolding of the raga.',
        'Synchronize awareness with your breathing.',
        'Maintain a calm, observant state of mind.',
      ],
    ),
    PracticeItem(
      id: 'raag_kafi',
      title: 'Raag Kafi',
      subtitle: 'Soft afternoon mood for ease.',
      meta: 'Afternoon',
      accent: Color(0xFFB0A3FF),
      timeOfDay: 'Afternoon',
      mood: 'Ease, softness, emotional balance',
      description:
          'Raag Kafi has a gentle and soothing quality that evokes warmth and simplicity. It is well suited for relaxed listening during the afternoon.',
      steps: [
        'Choose a comfortable, relaxed posture.',
        'Play Raag Kafi at a moderate or slow tempo.',
        'Allow the body to soften with the music.',
        'Observe emotional shifts without judgment.',
        'Stay present with the sound.',
      ],
    ),
    PracticeItem(
      id: 'raag_bageshri',
      title: 'Raag Bageshri',
      subtitle: 'Late night serenity and introspection.',
      meta: 'Late night',
      accent: Color(0xFFB078FF),
      timeOfDay: 'Late night',
      mood: 'Serenity, introspection',
      description:
          'Raag Bageshri is a deeply expressive night raga that encourages introspection and emotional depth. It is ideal for quiet reflection before sleep.',
      steps: [
        'Dim the lights and reduce distractions.',
        'Listen in a seated or reclining position.',
        'Let the music guide your attention inward.',
        'Avoid active thinking; simply receive the sound.',
        'Allow a sense of stillness to emerge naturally.',
      ],
    ),
  ];
}
