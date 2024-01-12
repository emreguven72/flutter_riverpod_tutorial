import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider_tutorial/models/product.dart';
import 'package:provider_tutorial/providers/cart_notifier.dart';

class StateNotifierView extends ConsumerWidget {
  const StateNotifierView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("State Notifier"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2 / 3,
              mainAxisSpacing: 2,
            ),
            itemCount: cart.length,
            itemBuilder: (BuildContext context, int index) {
              final product = cart.elementAt(index);
              return Card(
                color: Colors.amber,
                child: Center(
                    child: Column(
                  children: [
                    Text(product.id.toString()),
                    Text(product.name),
                    Text(product.description),
                    Text(product.newPrice.toString()),
                    Text(product.oldPrice.toString()),
                    IconButton(
                      onPressed: () {
                        ref
                            .read(cartNotifierProvider.notifier)
                            .removeProductFromCart(product.id);
                      },
                      icon: const Icon(Icons.delete),
                    )
                  ],
                )),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            ref.read(cartNotifierProvider.notifier).addProductToCart(Product(
                  id: 10,
                  description: "Descript",
                  name: "Deneme",
                  newPrice: 10,
                  oldPrice: 50,
                ));
          },
          child: const Icon(Icons.add)),
    );
  }
}
