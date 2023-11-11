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

  void addNewApp() {
    // Initial values for the new app
    String newName = '';
    int newSteps = 0;
    String newAndroidPackageName = '';
    String newIosUrlScheme = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New App'),
          content: SingleChildScrollView(
            // Use SingleChildScrollView to avoid overflow
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  onChanged: (value) => newName = value,
                  decoration: const InputDecoration(hintText: 'App Name'),
                ),
                TextField(
                  onChanged: (value) => newSteps = int.tryParse(value) ?? 0,
                  decoration: const InputDecoration(hintText: 'Required Steps'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  onChanged: (value) => newAndroidPackageName = value,
                  decoration:
                      const InputDecoration(hintText: 'Android Package Name'),
                ),
                TextField(
                  onChanged: (value) => newIosUrlScheme = value,
                  decoration: const InputDecoration(hintText: 'iOS URL Scheme'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                AppModel newApp = AppModel(
                  name: newName,
                  androidPackageName: newAndroidPackageName,
                  iosUrlScheme: newIosUrlScheme,
                  requiredSteps: newSteps,
                );
                // Add the new app to the list
                setState(() {
                  sortedAppList.add(newApp);
                  Data.appList.add(
                      newApp); // If you want to update the main data source as well
                  sortAppList(); // Sort the list again after adding the new app
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
        onPressed: addNewApp,
        child: const Icon(Icons.add),
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
  final Function(AppModel, int, {bool delete}) onAppEdit;

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

    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newName = app.name;
        int newSteps = app.requiredSteps;

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
            // New Delete button
            TextButton(
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
              onPressed: () {
                // Logic to delete the app
                Navigator.of(context).pop(); // Close the dialog
                onAppEdit(app, index,
                    delete: true); // Call the callback with delete flag
              },
            ),
          ],
        );
      },
    );
  }
}
