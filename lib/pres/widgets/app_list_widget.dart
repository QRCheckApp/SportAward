import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';

import '../../data/app_model.dart';
import '../../style.dart';
import 'leading_icon.dart';

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
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      shrinkWrap: true,
      itemCount: appList.length,
      itemBuilder: (context, index) {
        return Card(
          color: SCol.grey,
          child: ListTile(
            title: Text(appList[index].name),
            //Edit this line

            trailing: LeadingIcon(
                stepAmount: stepAmount, appList: appList, index: index),
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
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 4),
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
              child: Text('Delete', style: TextStyle(color: SCol.red)),
              onPressed: () {
                Navigator.of(context).pop();
                onAppEdit(app, index, delete: true);
              },
            ),
          ],
        );
      },
    );
  }
}
