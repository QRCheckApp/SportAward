import 'package:dosport/app_model.dart';
import 'package:flutter/material.dart';
import 'package:shake/shake.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int stepAmount = 0;
  ShakeDetector? detector;

  List<AppModel> appList = [
    //Instagram
    AppModel(
      name: "Instagram",
      androidUrl: "com.instagram.and",
      iosUrl: "19023801823",
      requiredSteps: 3000,
    ),
    //Snapchat
    AppModel(
      name: "Snapchat",
      androidUrl: "com.snapchat.and",
      iosUrl: "19023801823",
      requiredSteps: 5000,
    ),
    //TiKTok
    AppModel(
      name: "TikTok",
      androidUrl: "com.tiktok.and",
      iosUrl: "19023801823",
      requiredSteps: 10000,
    ),
  ];

  @override
  void initState() {
    super.initState();
    // Initialize the ShakeDetector
    detector = ShakeDetector.autoStart(
      onPhoneShake: () => setState(() => stepAmount += 1000),
    );
  }

  @override
  void dispose() {
    detector?.stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SportAward"),
        actions: [
          IconButton(
            onPressed: () {
              showLicensePage(
                context: context,
                applicationName: "Junction23 \n © QrCheck",
              );
            },
            icon: const Icon(Icons.info_outline),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "You've walked",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(
                  "$stepAmount ",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                Text(
                  "steps today!",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: appList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(appList[index].name),
                  subtitle: Text(
                    "Walk ${appList[index].requiredSteps} steps to open",
                  ),
                  onTap: () {
                    if (stepAmount >= appList[index].requiredSteps) {
                      // Open the app
                    } else {
                      //Show a snackbar
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: const Duration(seconds: 1),
                          content: Text(
                            "You need to walk ${appList[index].requiredSteps - stepAmount} more steps to open ${appList[index].name}",
                          ),
                        ),
                      );
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            stepAmount = 0; // Reset stepAmount and call setState
          });
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
