import 'app_model.dart';

class Data {
  static List<AppModel> appList = [
    //YouTube
    AppModel(
      name: "YouTube",
      androidPackageName: "com.google.android.youtube",
      iosUrlScheme: "youtube://",
      requiredSteps: 1000,
    ),
    //Instagram
    AppModel(
      name: "Instagram",
      androidPackageName: "com.instagram.android",
      iosUrlScheme: "instagram://",
      requiredSteps: 3000,
    ),
    //Snapchat
    AppModel(
      name: "Snapchat",
      androidPackageName: "com.snapchat.android",
      iosUrlScheme: "snapchat://",
      requiredSteps: 5000,
    ),
    //TiKTok
    AppModel(
      name: "TikTok",
      androidPackageName: "com.zhiliaoapp.musically",
      iosUrlScheme: "tiktok://",
      requiredSteps: 10000,
    ),
  ];
}
