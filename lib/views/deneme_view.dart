import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:numberpicker/numberpicker.dart';

final counterProvider = StateProvider<int>((ref) => 0);
final counterProvider2 = StateProvider<int>((ref) => 10);

class DenemeView extends ConsumerWidget {
  const DenemeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);
    final counter2 = ref.watch(counterProvider2);

    ref.read(counterProvider.notifier).state = 10;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Deneme"),
      ),
      body: Column(
        children: [
          NumberPicker(
            value: counter,
            minValue: 0,
            maxValue: 400,
            step: 1,
            itemHeight: 30,
            axis: Axis.horizontal,
            onChanged: (value) {
              ref.read(counterProvider.notifier).state = value;
            },
          ),
          NumberPicker(
            value: counter2,
            minValue: 0,
            maxValue: 400,
            step: 1,
            itemHeight: 30,
            axis: Axis.horizontal,
            onChanged: (value) {
              ref.read(counterProvider2.notifier).state = value;
            },
          ),
        ],
      ),
    );
  }
}
