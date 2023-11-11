import 'package:dosport/app_model.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:shake/shake.dart';

import 'data.dart';
import 'widgets/leading_icon.dart';

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
      onPhoneShake: () => stepAmount += 1000,
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

  void handleAppEdit(AppModel editedApp, int index) {
    Data.appList[index] = editedApp; // Replace the old entry with the new one
    //sort app list

    Data.appList.sort((a, b) => a.requiredSteps.compareTo(b.requiredSteps));

    updateAndSortAppList(Data.appList); // Re-sort and update the list

    setState(() {}); // Update the UI
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
            AppListWidget(
              appList: sortedAppList,
              stepAmount: stepAmount,
              onAppEdit: handleAppEdit,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() => stepAmount += 1000);

          //setState(() => stepAmount = 0);
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

//Static AppListWidget
class AppListWidget extends StatelessWidget {
  const AppListWidget({
    super.key,
    required this.appList,
    required this.stepAmount,
    required this.onAppEdit,
  });

  final List<AppModel> appList;
  final int stepAmount;
  final Function(AppModel, int) onAppEdit;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: appList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(appList[index].name),
          //Edit this line
          leading: LeadingIcon(
              stepAmount: stepAmount, appList: appList, index: index),
          trailing: IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => editApp(context, index),
          ),
          subtitle: Text(
            "Walk ${appList[index].requiredSteps} steps to open",
          ),
          onTap: () async {
            if (stepAmount >= appList[index].requiredSteps) {
              // Open the app

              await LaunchApp.openApp(
                androidPackageName: appList[index].androidPackageName,
                iosUrlScheme: appList[index].iosUrlScheme,
                openStore: false,
              );
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
    );
  }

  void editApp(BuildContext context, int index) {
    AppModel app = appList[index];
    // Show a dialog or another UI to edit the app details
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newName = app.name;
        int newSteps = app.requiredSteps;
        // Create a dialog with form fields to edit name and required steps
        return AlertDialog(
          title: const Text('Edit App'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: TextEditingController(text: app.name),
                onChanged: (value) => newName = value,
                decoration: const InputDecoration(hintText: 'App Name'),
              ),
              TextField(
                controller:
                    TextEditingController(text: app.requiredSteps.toString()),
                onChanged: (value) =>
                    newSteps = int.tryParse(value) ?? app.requiredSteps,
                decoration: const InputDecoration(hintText: 'Required Steps'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                // Update the app with new values
                AppModel updatedApp = AppModel(
                  name: newName,
                  androidPackageName: app.androidPackageName,
                  iosUrlScheme: app.iosUrlScheme,
                  requiredSteps: newSteps,
                );
                // Call the callback to notify the HomePage
                onAppEdit(updatedApp, index);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
