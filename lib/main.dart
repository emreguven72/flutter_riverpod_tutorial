import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider_tutorial/providers/cart_notifier.dart';
import 'package:provider_tutorial/views/all_products_view.dart';
import 'package:provider_tutorial/views/animation_with_state_view.dart';
import 'package:provider_tutorial/views/change_notifier_provider_view.dart';
import 'package:provider_tutorial/views/deneme_view.dart';
import 'package:provider_tutorial/views/future_provider_view.dart';
import 'package:provider_tutorial/views/provider_view.dart';
import 'package:provider_tutorial/views/counter_view.dart';
import 'package:provider_tutorial/views/state_notifier_view.dart';
import 'package:provider_tutorial/views/state_provider_view.dart';
import 'package:provider_tutorial/views/stream_provider_view.dart';

void main() {
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartNotifierProvider);
    
    return Scaffold(
        appBar: AppBar(
          title: const Text("Main Screen"),
          actions: [
            Text(cart.length.toString())
          ],
        ),
        body: Center(
            child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const CounterPage()),
                );
              },
              child: const Text("Counter"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const ProviderView()),
                );
              },
              child: const Text("Provider"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const StateProviderView()),
                );
              },
              child: const Text("State Provider"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const StreamProviderView()),
                );
              },
              child: const Text("Stream Provider"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const FutureProviderView()),
                );
              },
              child: const Text("Future Provider"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const ChangeNotifierProviderView()),
                );
              },
              child: const Text("Change Notifier Provider"),
            ),
            ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const StateNotifierView()),
              );
            },
            child: const Text("State Notifier Provider"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AllProductsView()),
              );
            },
            child: const Text("All Products"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const DenemeView()),
              );
            },
            child: const Text("Deneme"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AnimationView()),
              );
            },
            child: const Text("Animation View"),
          ),
          ],
        )));
  }
}
