import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserModel {
  final name;
  final surname;
  final age;

  const UserModel(
      {required this.name, required this.surname, required this.age});
}

abstract class WebSocketClient {
  Stream<int> getCounterStream([int start]);
  Stream<UserModel> getUserData();
  Future<int> getCounterFuture();
}

class FakeWebSocketClient implements WebSocketClient {
  @override
  Stream<int> getCounterStream([int start = 0]) async* {
    int i = start;
    while (true) {
      await Future.delayed(const Duration(milliseconds: 500));
      yield i++;
    }
  }

  @override
  Stream<UserModel> getUserData() async* {
    UserModel user = UserModel(name: "Init", surname: "init", age: "0");
    while (true) {
      await Future.delayed(const Duration(milliseconds: 500));
      yield user;
    }
  }

  @override
  Future<int> getCounterFuture() async {
    int i = 13;
    await Future.delayed(const Duration(seconds: 3));
    return i;
  }
}

final webSocketProvider = Provider<WebSocketClient>(
  (ref) {
    return FakeWebSocketClient();
  },
);

final counterStreamProvider = StreamProvider.family<int, int>((ref, start) {
  final wsClient = ref.watch(webSocketProvider);
  return wsClient.getCounterStream(start);
});

final counterFutureProvider = FutureProvider<int>((ref) {
  final wsClient = ref.watch(webSocketProvider);
  return wsClient.getCounterFuture();
});

final userProvider = StreamProvider<UserModel>((ref) {
  final wsClient = ref.watch(webSocketProvider);
  return wsClient.getUserData();
});

class CounterPage extends ConsumerWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<int> counterStream = ref.watch(counterStreamProvider(5));

    final AsyncValue<int> counterFuture = ref.watch(counterFutureProvider);

    final AsyncValue<UserModel> userValue = ref.watch(userProvider);

    // ref.listen<int>(
    //   counterProvider,
    //   (previous, next) {
    //     if (next >= 5) {
    //       showDialog(
    //         context: context,
    //         builder: (context) {
    //           return AlertDialog(
    //             title: const Text("Warning"),
    //             content: const Text("Counter is dangerously increasing.Be carefull!!!!"),
    //             actions: [
    //               TextButton(onPressed: () {
    //                 Navigator.of(context).pop();
    //               }, child: const Text("OK"))
    //             ],
    //           );
    //         },
    //       );
    //     }
    //   },
    // );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter"),
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         ref.invalidate(counterProvider);
        //       },
        //       icon: const Icon(Icons.refresh))
        // ],
      ),
      body: Center(
        child: Column(
          children: [
            Text(counterStream
                .when(
                    data: (int value) => value,
                    error: (Object e, _) => e,
                    loading: () => 'loading...')
                .toString()),
            Text(userValue
                .when(
                    data: (UserModel value) => value.name,
                    error: (Object e, _) => e,
                    loading: () => "loading...")
                .toString()),
            Text(userValue
                .when(
                    data: (UserModel value) => value.surname,
                    error: (Object e, _) => e,
                    loading: () => "loading...")
                .toString()),
            Text(userValue
                .when(
                    data: (UserModel value) => value.age,
                    error: (Object e, _) => e,
                    loading: () => "loading...")
                .toString()),
            Text(counterFuture
                .when(
                    data: (int value) => value,
                    error: (Object e, _) => e,
                    loading: () => "loading...")
                .toString())
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
