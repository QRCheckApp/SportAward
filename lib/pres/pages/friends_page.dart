import 'package:dosport/style.dart';
import 'package:flutter/material.dart';

class Friend {
  final String username;
  final int steps;

  Friend(this.username, this.steps);
}

class FriendsPage extends StatelessWidget {
  const FriendsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data
    List<Friend> friends = [
      Friend("PixelPierre", 10000),
      Friend("CoderCarlos", 8500),
      Friend("BinaryBianca", 7250),
      Friend("ScriptSophia", 6800),
      Friend("TechieTomasz", 5500),
    ];

    //methode that returns a first place icon if the user is first place, second place icon if the user is second place, third place icon if the user is third place, and a fourth place icon if the user is fourth place
    Icon placeIcon(int index) {
      if (index == 0) {
        return Icon(Icons.emoji_events_rounded, color: SCol.gold);
      } else if (index == 1) {
        return Icon(Icons.emoji_events_rounded, color: SCol.silver);
      } else if (index == 2) {
        return Icon(Icons.emoji_events_rounded, color: SCol.bronze);
      } else {
        return Icon(Icons.person, color: SCol.onBackground);
      }
    }

    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: friends.length,
              itemBuilder: (context, index) {
                return Card(
                  color: SCol.grey,
                  child: ListTile(
                    minVerticalPadding: 20,
                    leading: placeIcon(index),
                    title: Text(friends[index].username,
                        style: Theme.of(context).textTheme.titleLarge),
                    trailing: Text(
                      '${friends[index].steps}\'',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 4);
              }),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: SCol.primary,
          shape: const CircleBorder(),
          onPressed: () {},
          child: const Icon(Icons.add),
        ));
  }
}
