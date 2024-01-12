import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final myProvider = Provider<String>((ref) => "Emre");

class ProviderView extends ConsumerWidget {
  const ProviderView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myName = ref.watch(myProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Provider Page"),),
      body: Center(
        child: Text(myName),
      ),
    );
  }
}
