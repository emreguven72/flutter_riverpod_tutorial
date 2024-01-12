import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final stateProvider = StateProvider<int>((ref) => 0);

class StateProviderView extends ConsumerWidget {
  const StateProviderView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(stateProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("State Provider"),
      ),
      body: Center(
        child: Column(children: [Text(state.toString())]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(stateProvider.notifier).state++;
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
