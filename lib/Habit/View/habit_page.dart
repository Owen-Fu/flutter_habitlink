import 'package:flutter/material.dart';

class HabitPage extends StatelessWidget {
  const HabitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Habits'),
      ),
      body: ListView.builder(
        itemCount: 10, // Replace with actual habit count
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Habit ${index + 1}'),
            subtitle: const Text('Frequency: Daily'),
            trailing: const Icon(Icons.check_circle_outline),
            onTap: () {
              // Navigate to habit detail page
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to Add Habit screen
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}