import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider_tutorial/repository/stream_repository_provider.dart';

final streamValueProvider = StreamProvider.autoDispose((ref) {
  final streamRepository = ref.watch(streamRepositoryProvider);
  return streamRepository.getStream();
});

class StreamProviderView extends ConsumerWidget {
  const StreamProviderView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stream = ref.watch(streamValueProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Stream Provider"),
      ),
      body: Center(
        child: stream.when(
          data: (data) => Text(data.toString()),
          error: (error, stackTrace) => Text(error.toString()),
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
