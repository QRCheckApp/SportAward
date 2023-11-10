import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int stepAmount = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        const Text("You did so many steps today:"),
        Text(stepAmount.toString()),
        ElevatedButton(
          onPressed: () async {
            int steps = stepAmount + 1000;
            setState(() {
              stepAmount = steps;
            });
          },
          child: const Text("Get steps"),
        ),
      ]),
    );
  }
}
