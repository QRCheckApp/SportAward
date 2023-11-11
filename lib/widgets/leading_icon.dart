import 'package:flutter/material.dart';

import '../app_model.dart';

class LeadingIcon extends StatelessWidget {
  const LeadingIcon({
    super.key,
    required this.stepAmount,
    required this.appList,
    required this.index,
  });

  final int stepAmount;
  final List<AppModel> appList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Icon(
      stepAmount >= appList[index].requiredSteps
          ? Icons.open_in_new
          : Icons.cancel,
      color: stepAmount >= appList[index].requiredSteps ? null : Colors.red,
    );
  }
}
