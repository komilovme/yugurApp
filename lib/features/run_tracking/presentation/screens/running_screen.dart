import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/run_provider.dart';

class RunningScreen extends ConsumerWidget {
  const RunningScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(runProvider);
    final notifier = ref.read(runProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Running')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tracking: ${state.running ? 'ON' : 'OFF'}'),
            const SizedBox(height: 8),
            Text('Points: ${state.points.length}'),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              children: [
                ElevatedButton(onPressed: state.running ? null : notifier.start, child: const Text('Start')),
                ElevatedButton(onPressed: state.running ? notifier.stop : null, child: const Text('Stop & Capture')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
