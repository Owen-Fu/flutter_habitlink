import 'package:flutter/material.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community Challenges'),
      ),
      body: ListView.builder(
        itemCount: 5, // Replace with actual challenge count
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text('Challenge ${index + 1}'),
              subtitle: Text('Participants: ${50 + index}'),
              onTap: () {
                // Navigate to challenge detail page
              },
            ),
          );
        },
      ),
    );
  }
}
