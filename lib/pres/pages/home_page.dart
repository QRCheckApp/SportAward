import 'package:dosport/data/app_model.dart';
import 'package:flutter/material.dart';
import 'package:shake/shake.dart';

import '../../data/data.dart';
import '../widgets/app_list_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ShakeDetector? detector;

  int stepAmount = 0;
  List<AppModel> sortedAppList = [];

  @override
  void initState() {
    super.initState();
    // Initialize the ShakeDetector
    detector = ShakeDetector.autoStart(
      onPhoneShake: () => setState(() => stepAmount += 1000),
    );

    // Initialize the app list
    Data.appList.sort((a, b) => a.requiredSteps.compareTo(b.requiredSteps));
    sortedAppList = List.from(Data.appList); // Create a copy of the list
  }

  @override
  void dispose() {
    // Dispose the ShakeDetector
    detector?.stopListening();
    super.dispose();
  }

  void sortAppList() {
    sortedAppList.sort((a, b) => a.requiredSteps.compareTo(b.requiredSteps));
  }

  void updateAndSortAppList(List<AppModel> newAppList) {
    sortedAppList = List.from(newAppList); // Update the list

    sortAppList(); // Sort the list
  }

  void handleAppEdit(AppModel editedApp, int index, {bool delete = false}) {
    if (delete) {
      // Remove the app from the lists
      Data.appList.removeAt(index);
      sortedAppList.removeAt(index);
    } else {
      // Existing logic to replace the app
      Data.appList[index] = editedApp;
      sortedAppList[index] = editedApp;
    }

    // Re-sort and update the list
    Data.appList.sort((a, b) => a.requiredSteps.compareTo(b.requiredSteps));
    updateAndSortAppList(Data.appList);

    setState(() {}); // Update the UI
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            AppListWidget(
              appList: sortedAppList,
              stepAmount: stepAmount,
              onAppEdit: handleAppEdit,
            ),
          ],
        ),
      ),
    );
  }
}
