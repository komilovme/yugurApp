import 'package:flutter/material.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Leaderboard')),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => ListTile(
          leading: CircleAvatar(child: Text('#${index + 1}')),
          title: Text('Runner ${index + 1}'),
          trailing: Text('${(10 - index) * 1200} m²'),
        ),
      ),
    );
  }
}
