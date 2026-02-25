import 'package:flutter/material.dart';

class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Learn',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Text(
            'Build Awareness',
            style: TextStyle(
              color: Color(0xFF72E8D4),
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 16),
          _ModuleCard(
            title: 'Know Your Lungs',
            subtitle: 'Module 1',
            icon: Icons.air,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ModuleDetailScreen(moduleIndex: 1),
              ),
            ),
          ),
          const SizedBox(height: 16),
          _ModuleCard(
            title: 'What Harms Your Lungs',
            subtitle: 'Module 2',
            icon: Icons.warning_amber_rounded,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ModuleDetailScreen(moduleIndex: 2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          _ModuleCard(
            title: 'Keep Your Lungs Healthy',
            subtitle: 'Module 3',
            icon: Icons.health_and_safety,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ModuleDetailScreen(moduleIndex: 3),
              ),
            ),
          ),
          const SizedBox(height: 16),
          _ModuleCard(
            title: 'Air Quality Awareness',
            subtitle: 'Module 4',
            icon: Icons.cloud_outlined,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ModuleDetailScreen(moduleIndex: 4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ModuleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const _ModuleCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF72E8D4).withOpacity(0.2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: const Color(0xFF72E8D4), size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Color(0xFF72E8D4),
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    title,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Color(0xFF72E8D4)),
          ],
        ),
      ),
    );
  }
}

class ModuleDetailScreen extends StatelessWidget {
  final int moduleIndex;

  const ModuleDetailScreen({super.key, required this.moduleIndex});

  @override
  Widget build(BuildContext context) {
    final moduleData = _getModuleData(moduleIndex);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          moduleData['title']!,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: const NetworkImage(
                    'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?auto=format&fit=crop&w=900&q=80',
                  ), // Placeholder visual
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.4),
                    BlendMode.darken,
                  ),
                ),
              ),
              alignment: Alignment.center,
              child: const Icon(
                Icons.play_circle_fill,
                color: Colors.white70,
                size: 64,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              moduleData['content']!,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                fontSize: 16,
                height: 1.6,
              ),
            ),
            if (moduleData['terms'] != null) ...[
              const SizedBox(height: 24),
              const Text(
                'General Lung Terms',
                style: TextStyle(
                  color: Color(0xFF72E8D4),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                moduleData['terms']!,
                style: TextStyle(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.6),
                  fontSize: 15,
                  height: 1.6,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Map<String, String> _getModuleData(int index) {
    switch (index) {
      case 1:
        return {
          'title': 'Know Your Lungs',
          'content':
              'Your lungs are one of the most important organs in your body because they help you breathe and provide oxygen to every cell. Every time you inhale, air enters your body through your nose or mouth, travels down your windpipe (called the trachea), and reaches your lungs. Inside the lungs, there are millions of tiny air sacs called alveoli. These air sacs are surrounded by blood vessels, and this is where oxygen passes into your bloodstream.\n\nOnce oxygen enters your blood, it is carried to different parts of your body to produce energy. At the same time, your body produces carbon dioxide as a waste gas, which is carried back to your lungs and released when you exhale. This continuous exchange of oxygen and carbon dioxide keeps your body functioning properly. If your lungs are not healthy, your body does not get enough oxygen, which can make you feel tired, weak, or breathless.\n\nYour lungs also play an important role in protecting your body. Tiny hair-like structures called cilia line your airways and help trap dust, germs, and harmful particles, preventing them from entering deeper into your lungs. Mucus in your airways also helps capture these harmful substances so they can be removed when you cough or sneeze. This makes your lungs not just a breathing organ, but also a defence system for your body.\n\nOn average, a person breathes around 15–20 times per minute, which adds up to nearly 20,000 breaths a day. This shows how constantly your lungs are working to keep you alive and active. Taking care of your lungs is therefore essential for your overall health and well-being.',
          'terms':
              'Lungs:\nThe lungs are the pair of pinkish-gray, spongy organs in your chest. They supply your body with oxygen and remove carbon dioxide, a waste gas, from your body.\n\nRespiratory system:\nThe respiratory system is made up of the organs that are involved in breathing. These include the nose, throat, larynx (voice box), trachea (windpipe), and lungs.\n\nGas exchange:\nGas exchange happens when you breathe. Oxygen moves from your lungs to your blood and carbon dioxide moves from your blood to your lungs.\n\nOxygen:\nOxygen is a colorless, odorless gas that is needed for plant and animal life. Oxygen that you breathe in enters the blood from the lungs and travels to the tissues.\n\nAirways:\nThe airways are tubes that carry air in and out of your lungs.\n\nAlveoli:\nAlveoli are tiny air sacs at the end of the branches of air tubes in your lungs where oxygen enters the blood and carbon dioxide leaves the blood.\n\nVentilation:\nPulmonary ventilation is another term for breathing. It is the process of air flowing into the lungs while inhaling and out of the lungs while exhaling.',
        };
      case 2:
        return {
          'title': 'What Harms Your Lungs',
          'content':
              'Your lungs are sensitive organs and can be easily affected by the air you breathe. One of the biggest threats to lung health today is air pollution. Air pollution contains very tiny particles, especially PM2.5, which are so small that they can travel deep into your lungs and even enter your bloodstream. These particles come from vehicles, factories, construction dust, and burning of waste. Even when the air looks clean, it may still contain harmful pollutants.\n\nIndoor air pollution is often overlooked but can be just as harmful. Smoke from cooking, burning incense sticks, mosquito coils, and poor ventilation can lead to the accumulation of harmful particles inside homes. Spending long hours in poorly ventilated spaces increases exposure to these pollutants, which can affect lung health over time.\n\nDust, pollen, and pet dander are common allergens that can trigger breathing problems, especially in people with asthma or allergies. These substances can cause inflammation in the airways, making it harder to breathe. Understanding these risks helps you take simple steps, such as wearing a mask in polluted environments, improving ventilation, and avoiding exposure to smoke.',
        };
      case 3:
        return {
          'title': 'Keep Your Lungs Healthy',
          'content':
              'Maintaining healthy lungs is essential for overall well-being, and it largely depends on your daily habits. Regular physical activity is one of the best ways to keep your lungs strong. When you exercise, your lungs work harder to supply oxygen to your muscles, which improves lung capacity and efficiency over time. Activities like walking, running, cycling, and playing sports are all beneficial.\n\nBreathing exercises can also help strengthen your lungs. Techniques such as deep breathing and controlled exhalation improve oxygen intake and help your lungs function more effectively. Practices like yoga and simple pranayama can enhance lung capacity and promote relaxation.\n\nProtecting your lungs from pollution is equally important. On days when air quality is poor, it is advisable to limit outdoor activities and wear a mask if you need to go outside. Staying indoors with proper ventilation and using air purifiers where possible can reduce exposure to harmful pollutants.\n\nA healthy diet and proper hydration also play a role in lung health. Fruits and vegetables rich in antioxidants help reduce inflammation, while drinking enough water keeps the airways moist and helps the lungs function smoothly. Avoiding exposure to smoke, dust, and harmful chemicals is another key step in maintaining healthy lungs.\n\nEarly detection and management can prevent complications and improve quality of life. Healthy lungs are essential for a healthy life.',
        };
      case 4:
        return {
          'title': 'Air Quality Awareness',
          'content':
              'The Air Quality Index (AQI) is used for reporting daily air quality. It tells you how clean or polluted your air is, and what associated health effects might be a concern for you.\n\nIt is an indicator developed by government agencies to communicate how polluted the air currently is or how polluted it is forecast to become. As the AQI increases, it means that a large percentage of the population will experience severe adverse health effects.\n\nAir pollution levels are measured daily and ranked on a scale of 0 for perfect air all the way up to 500 for air pollution levels that pose an immediate danger to the public. The AQI breaks air pollution levels into six categories, each of which has a name, an associated color, and advice to go along with it. AQI values at or below 100 are considered satisfactory for almost everyone. When AQI values are above 100, air quality is unhealthy. The higher the number, the more people are at risk of health harm.\n\nGood (0-50): Satisfactory air quality.\nModerate (51-100): Acceptable, but some risk for sensitive individuals.\nUnhealthy for Sensitive Groups (101-150): Health effects possible for sensitive groups.\nUnhealthy (151-200): General public may experience health effects.\nVery Unhealthy (201-300): Increased risk for everyone.\nHazardous (301 and higher): Emergency conditions, affecting all individuals.\n\nBeing aware of air quality helps you take preventive measures and protect your lungs.',
        };
      default:
        return {'title': 'Module', 'content': 'Content coming soon.'};
    }
  }
}
