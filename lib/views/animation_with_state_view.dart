import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final countProvider = StateNotifierProvider((_) => CountProvider(1));

final currentCount = Provider((ref) => ref.watch(countProvider));

class CountProvider extends StateNotifier<int> {
  CountProvider(int state) : super(state);

  void increment() {
    state += 1;
  }
}

class AnimationView extends HookConsumerWidget {
  const AnimationView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(countProvider.notifier);

    return Scaffold(
        appBar: AppBar(
          title: Text("Riverpod Animation Example"),
        ),
        body: Column(
          children: [
            AnimatedWidget(),
            ElevatedButton(
              child: Text("Increment"),
              onPressed: () {
                notifier.increment();
              },
            ),
          ],
        ));
  }
}

class AnimatedWidget extends HookConsumerWidget {
  final Duration duration = const Duration(milliseconds: 1000);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _controller = useAnimationController(duration: duration);
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
    });

    var _count = ref.watch(currentCount);
    useValueChanged(_count, (_, __) async {
      _controller.forward();
    });

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Center(
          child: Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.green[300]!.withOpacity(_controller.value),
                shape: BoxShape.circle),
            height: 200,
            width: 200,
            child: Center(
              child: Text(
                _count.toString(),
                textScaleFactor: 5,
              ),
            ),
          ),
        );
      },
    );
  }
}
