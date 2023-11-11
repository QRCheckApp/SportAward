import 'package:dosport/style.dart';
import 'package:flutter/material.dart';

class Badge {
  final String title;
  final IconData icon;
  final String description;
  final BadgeStatus status;

  Badge(this.title, this.icon, this.description, this.status);
}

enum BadgeStatus { bronze, silver, gold, disabled }

// Badge Status toString
extension BadgeStatusExtension on BadgeStatus {
  String get name {
    switch (this) {
      case BadgeStatus.bronze:
        return 'Bronze';
      case BadgeStatus.silver:
        return 'Silver';
      case BadgeStatus.gold:
        return 'Gold';
      case BadgeStatus.disabled:
        return 'Not achieved';
      default:
        return 'Unknown';
    }
  }
}

class BadgePage extends StatelessWidget {
  BadgePage({super.key});

  final List<Badge> badges = [
    Badge(
        "Joint Genius",
        Icons.healing,
        "Walking is a low-impact exercise that is gentle on the joints, making it suitable for people of various fitness levels. It can help maintain joint flexibility and reduce the risk of arthritis.",
        BadgeStatus.gold),
    Badge(
        "Immune Invincible",
        Icons.shield,
        "Regular moderate exercise, such as walking, has been linked to a stronger immune system. It may help the body defend against illnesses and infections.",
        BadgeStatus.gold),
    Badge(
        "Bone Builder",
        Icons.build,
        "Weight-bearing exercises like walking help maintain bone density and reduce the risk of osteoporosis, especially important as you age.",
        BadgeStatus.gold),
    Badge(
        "Mood Master",
        Icons.mood,
        "Physical activity, including walking, triggers the release of endorphins, which are known as 'feel-good' hormones. This can help reduce stress, anxiety, and symptoms of depression.",
        BadgeStatus.silver),
    Badge(
        "Brain Booster",
        Icons.psychology,
        "Walking has been associated with cognitive benefits, including better memory and cognitive function. It may also reduce the risk of developing cognitive decline as you age.",
        BadgeStatus.silver),
    Badge(
        "Dreamy Dozer",
        Icons.hotel,
        "Engaging in regular physical activity, including walking, can improve the quality of your sleep. It helps regulate sleep patterns and promotes relaxation.",
        BadgeStatus.silver),
    Badge(
        "Heart Hero",
        Icons.favorite,
        "Regular walking helps improve cardiovascular health by increasing blood circulation, reducing the risk of heart disease, and maintaining healthy blood pressure levels.",
        BadgeStatus.silver),
    Badge(
        "Weight Warrior",
        Icons.fitness_center,
        "Walking can contribute to weight management and weight loss by burning calories and promoting a healthy metabolism.",
        BadgeStatus.silver),
    Badge(
        "Energizer Enthusiast",
        Icons.flash_on,
        "Walking increases oxygen flow throughout the body, providing a natural energy boost. Regular physical activity can combat feelings of fatigue and increase overall energy levels.",
        BadgeStatus.bronze),
    Badge(
        "Digestive Dynamo",
        Icons.restaurant,
        "Walking can aid in digestion by promoting regular bowel movements and reducing bloating. It can also help prevent constipation.",
        BadgeStatus.bronze),
    Badge(
        "Social Star",
        Icons.groups,
        "Walking can be a social activity, providing opportunities to connect with friends, family, or neighbors. Social interaction contributes to mental and emotional well-being.",
        BadgeStatus.bronze),
    Badge(
        "Longevity Hero",
        Icons.hourglass_full,
        "Studies suggest that regular physical activity, such as walking, is associated with increased life expectancy. It contributes to overall health and wellness, promoting a longer and healthier life.",
        BadgeStatus.bronze),
    Badge(
        "Health Guard",
        Icons.local_hospital,
        "Walking can be beneficial for managing and preventing various chronic conditions, including type 2 diabetes, hypertension, and certain types of cancer.",
        BadgeStatus.disabled),
  ];

  void _showBadgeDetails(BuildContext context, Badge badge) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: AspectRatio(
            aspectRatio: 2,
            child: Card(
              color: _getColorForStatus(badge.status),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(badge.icon, size: 50),
                    const SizedBox(height: 10),
                    Text(badge.title,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineSmall),
                  ],
                ),
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text(
                'Badge Rank: ${badge.status.name}', // Added line
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.left, // Added line
              ),
              SizedBox(height: 4),
              Text(badge.description, textAlign: TextAlign.justify)
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Color _getColorForStatus(BadgeStatus status) {
    switch (status) {
      case BadgeStatus.bronze:
        return SCol.bronze; // A bronze-like color
      case BadgeStatus.silver:
        return SCol.silver; // A shiny silver color
      case BadgeStatus.gold:
        return SCol.gold; // A bright gold color
      case BadgeStatus.disabled:
        return SCol.grey; // A light gray for disabled
      default:
        return Colors.blue; // Default color if needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 3 items per row
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1, // Ensures the items are square
        ),
        itemCount: badges.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _showBadgeDetails(context, badges[index]),
            child: Card(
              color: _getColorForStatus(badges[index].status),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(badges[index].icon, size: 50),
                      Text(
                        badges[index].title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ]),
              ),
            ),
          );
        },
      ),
    );
  }
}
