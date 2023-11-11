class AppModel {
  final String name;
  final String androidPackageName;
  final String iosUrlScheme;
  final int requiredSteps;

  AppModel({
    required this.name,
    required this.androidPackageName,
    required this.iosUrlScheme,
    required this.requiredSteps,
  });
}
