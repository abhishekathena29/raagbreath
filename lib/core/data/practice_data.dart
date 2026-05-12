import 'package:flutter/material.dart';
import '../models/practice_item.dart';

class PracticeData {
  static const List<PracticeItem> pranayama = [
    PracticeItem(
      id: 'nadi_shodhana',
      title: 'Nadi Shodhana',
      subtitle: 'Alternate nostril breathing for balance.',
      meta: '6-8 min',
      accent: Color(0xFFC17D3C),
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
      accent: Color(0xFF4A7FA8),
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
      accent: Color(0xFF8B6B4A),
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
      accent: Color(0xFF7B5EA7),
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

  static const List<PracticeItem> meditation = [
    PracticeItem(
      id: 'so_ham',
      title: 'So-Ham',
      subtitle: 'Breath mantra for inward attention.',
      meta: '8-12 min',
      accent: Color(0xFFC17D3C),
      purpose: 'Builds steady attention by pairing breath with a quiet mantra.',
      description:
          'So-Ham is a simple meditation where the natural breath is paired with the sound of "So" on the inhale and "Ham" on the exhale. It helps settle scattered thoughts and brings attention back to the body.',
      steps: [
        'Sit comfortably with your spine tall and shoulders relaxed.',
        'Close your eyes or soften your gaze.',
        'As you inhale, silently notice the sound "So".',
        'As you exhale, silently notice the sound "Ham".',
        'Let the breath stay natural without forcing it.',
        'When your mind wanders, gently return to the mantra and breath.',
      ],
    ),
    PracticeItem(
      id: 'trataka',
      title: 'Trataka',
      subtitle: 'Soft gaze to steady the mind.',
      meta: '5-8 min',
      accent: Color(0xFF4A7FA8),
      purpose: 'Improves focus and supports a calm, steady mental state.',
      description:
          'Trataka is a gentle gazing practice. A soft, steady gaze on one point helps reduce mental restlessness and trains attention without strain.',
      steps: [
        'Place a small object or candle at eye level.',
        'Sit comfortably about an arm length away.',
        'Rest your gaze softly on one point.',
        'Blink naturally and avoid straining your eyes.',
        'After a few minutes, close your eyes and notice the after-image.',
        'Finish by relaxing the face and taking a few easy breaths.',
      ],
    ),
    PracticeItem(
      id: 'yoga_nidra',
      title: 'Yoga Nidra',
      subtitle: 'Guided body scan for deep rest.',
      meta: '15-20 min',
      accent: Color(0xFF7B5EA7),
      purpose: 'Encourages deep rest and releases physical tension.',
      description:
          'Yoga Nidra is a reclining meditation that guides attention through the body. It is helpful when the nervous system needs rest and the breath needs space to soften.',
      steps: [
        'Lie down comfortably with support under your head or knees.',
        'Let your arms rest by your sides.',
        'Take a few slow breaths and settle into stillness.',
        'Move attention through the body one area at a time.',
        'Notice each area without trying to change it.',
        'Return slowly by deepening the breath before sitting up.',
      ],
    ),
  ];

  static const List<PracticeItem> yoga = [
    PracticeItem(
      id: 'surya_namaskar',
      title: 'Surya Namaskar',
      subtitle: 'Sun salutations to warm up the body.',
      meta: '10-12 min',
      accent: Color(0xFFC17D3C),
      purpose: 'Warms the body and coordinates movement with breath.',
      description:
          'Surya Namaskar is a flowing sequence that links posture and breathing. Practiced gently, it can improve body awareness, circulation, and respiratory rhythm.',
      steps: [
        'Stand tall and take one steady breath.',
        'Move slowly through each posture with awareness.',
        'Inhale as the chest opens or the body lengthens.',
        'Exhale as you fold, step back, or lower down.',
        'Keep the pace comfortable and smooth.',
        'Rest after a few rounds and observe your breathing.',
      ],
    ),
    PracticeItem(
      id: 'hatha_basics',
      title: 'Hatha Basics',
      subtitle: 'Foundational postures for alignment.',
      meta: '12-15 min',
      accent: Color(0xFF5B8A6E),
      purpose: 'Builds grounded posture and relaxed breathing.',
      description:
          'Hatha basics combine simple standing and seated postures. The practice emphasizes alignment, ease, and breath awareness rather than speed.',
      steps: [
        'Begin in a comfortable standing posture.',
        'Practice gentle side bends and shoulder rolls.',
        'Move into simple standing poses with steady breathing.',
        'Keep your knees soft and avoid forcing range.',
        'Sit for a short forward fold or twist.',
        'End with relaxed breathing for one minute.',
      ],
    ),
    PracticeItem(
      id: 'moon_flow',
      title: 'Moon Flow',
      subtitle: 'Gentle stretches for evening calm.',
      meta: '8-10 min',
      accent: Color(0xFF8B6B4A),
      purpose: 'Helps the body unwind before rest.',
      description:
          'Moon Flow is a slow evening sequence with gentle stretches and longer exhalations. It is designed to reduce tension and prepare the body for sleep.',
      steps: [
        'Sit or stand comfortably in a quiet space.',
        'Take slow breaths with slightly longer exhalations.',
        'Move through gentle neck, shoulder, and side stretches.',
        'Add a slow forward fold if it feels comfortable.',
        'Keep the movement soft and unhurried.',
        'Finish seated with both hands resting on the belly.',
      ],
    ),
  ];

  static const List<PracticeItem> raagPractice = [
    PracticeItem(
      id: 'raag_yaman',
      title: 'Raag Yaman',
      subtitle: 'Evening raag for clarity and devotion.',
      meta: 'Evening',
      accent: Color(0xFFC17D3C),
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
      accent: Color(0xFF4A7FA8),
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
      accent: Color(0xFF8B6B4A),
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
      accent: Color(0xFF7B5EA7),
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

  static const List<PracticeItem> taalPractice = [
    PracticeItem(
      id: 'teentaal',
      title: 'Teentaal',
      subtitle: '16 beats, steady and expansive.',
      meta: 'Dha Dhin Dhin Dha',
      accent: Color(0xFFC17D3C),
      purpose: 'Develops rhythmic steadiness and attentive listening.',
      description:
          'Teentaal is a 16-beat cycle used widely in Hindustani classical music. Practicing it slowly can create a stable rhythm for breath awareness and focus.',
      steps: [
        'Sit comfortably and tap a slow, even pulse.',
        'Count the 16 beats in four groups of four.',
        'Speak the first phrase: Dha Dhin Dhin Dha.',
        'Continue the full cycle at a relaxed pace.',
        'Let your breathing stay smooth as you count.',
        'Repeat several cycles without speeding up.',
      ],
    ),
    PracticeItem(
      id: 'ektaal',
      title: 'Ektaal',
      subtitle: '12 beats for slow vilambit.',
      meta: 'Dhin Dhin DhaGe',
      accent: Color(0xFF4A7FA8),
      purpose: 'Supports patience, timing, and calm concentration.',
      description:
          'Ektaal is a 12-beat rhythm often used in slower classical compositions. Its measured structure is useful for practicing calm attention.',
      steps: [
        'Begin with a slow hand tap or clap pattern.',
        'Count 12 beats evenly without rushing.',
        'Speak the bols softly with the rhythm.',
        'Notice the empty and emphasized points in the cycle.',
        'Keep your shoulders and jaw relaxed.',
        'Complete five slow cycles with steady breathing.',
      ],
    ),
    PracticeItem(
      id: 'rupak',
      title: 'Rupak',
      subtitle: '7 beats with a rolling feel.',
      meta: 'Tin Tin Na Dhin Na',
      accent: Color(0xFF7B5EA7),
      purpose: 'Builds rhythmic flexibility and playful focus.',
      description:
          'Rupak is a 7-beat cycle with a distinctive flowing quality. Its uneven grouping encourages alert but relaxed attention.',
      steps: [
        'Tap a gentle seven-beat pulse.',
        'Group the rhythm as 3 + 2 + 2.',
        'Speak Tin Tin Na, then Dhin Na, then Dhin Na.',
        'Keep the sound light and relaxed.',
        'Let the rhythm roll without becoming tense.',
        'Pause after a few rounds and notice your breath.',
      ],
    ),
  ];

  static const List<PracticeItem> breathTone = [
    PracticeItem(
      id: 'aum_humming',
      title: 'AUM Humming',
      subtitle: 'Resonant humming to steady the breath.',
      meta: '5-7 min',
      accent: Color(0xFFC17D3C),
      purpose: 'Uses sound vibration to lengthen exhalation and calm the body.',
      description:
          'AUM humming combines a comfortable inhale with a long, resonant exhale. The vibration can make the breath feel smoother and more grounded.',
      steps: [
        'Sit upright with the face and jaw relaxed.',
        'Inhale gently through the nose.',
        'Exhale with a soft AUM or humming sound.',
        'Feel the vibration around the lips, chest, or head.',
        'Keep the sound comfortable, never forced.',
        'Rest quietly between rounds if needed.',
      ],
    ),
    PracticeItem(
      id: 'sargam_warmup',
      title: 'Sargam Warmup',
      subtitle: 'Sa Re Ga to loosen the voice.',
      meta: '7-10 min',
      accent: Color(0xFF4A7FA8),
      purpose: 'Warms the voice while encouraging steady breath control.',
      description:
          'Sargam warmups use simple note patterns to connect breath, voice, and attention. Keep the tone soft and the range comfortable.',
      steps: [
        'Take a relaxed breath and hum softly.',
        'Sing Sa Re Ga Re Sa at a comfortable pitch.',
        'Keep each note smooth and easy.',
        'Pause for a natural inhale between phrases.',
        'Repeat slowly without pushing the voice.',
        'End with a quiet hum and relaxed breathing.',
      ],
    ),
    PracticeItem(
      id: 'tanpura_drone',
      title: 'Tanpura Drone',
      subtitle: 'Sustain tone for pitch focus.',
      meta: '10-12 min',
      accent: Color(0xFF7B5EA7),
      purpose:
          'Creates a stable sound field for listening and breath awareness.',
      description:
          'A tanpura drone offers a continuous tonal base. Listening or gently matching the tone can support concentration and slow breathing.',
      steps: [
        'Play a soft tanpura drone or imagine a steady base note.',
        'Sit comfortably with your chest open.',
        'Listen to the drone for several natural breaths.',
        'Hum or sing one comfortable sustained note.',
        'Stop before the breath feels strained.',
        'Alternate listening and gentle tone practice.',
      ],
    ),
  ];
}
