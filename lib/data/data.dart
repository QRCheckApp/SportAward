import 'app_model.dart';

class Data {
  static const int stepIncrement = 100;

  static List<AppModel> appList = [
    //YouTube
    AppModel(
      name: "YouTube",
      androidPackageName: "com.google.android.youtube",
      iosUrlScheme: "youtube://",
      requiredSteps: 1000,
      iconPath: "assets/YouTube.png",
    ),
    //Instagram
    AppModel(
      name: "Instagram",
      androidPackageName: "com.instagram.android",
      iosUrlScheme: "instagram://",
      requiredSteps: 3000,
      iconPath: "assets/Instagram.png",
    ),
    //Snapchat
    AppModel(
      name: "Snapchat",
      androidPackageName: "com.snapchat.android",
      iosUrlScheme: "snapchat://",
      requiredSteps: 5000,
      iconPath: "assets/Snapchat.png",
    ),
    //TiKTok
    AppModel(
      name: "TikTok",
      androidPackageName: "com.zhiliaoapp.musically",
      iosUrlScheme: "tiktok://",
      requiredSteps: 10000,
      iconPath: "assets/TikTok.png",
    ),
  ];
}
