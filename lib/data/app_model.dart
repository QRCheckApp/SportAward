class AppModel {
  final String name;
  final String androidPackageName;
  final String iosUrlScheme;
  final int requiredSteps;
  final String iconPath;

  AppModel({
    required this.name,
    required this.androidPackageName,
    required this.iosUrlScheme,
    required this.requiredSteps,
    required this.iconPath,
  });
}
