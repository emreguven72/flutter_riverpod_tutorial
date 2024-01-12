import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider_tutorial/providers/cart_notifier.dart';
import 'package:provider_tutorial/providers/product_sort_type.dart';
import 'package:provider_tutorial/repository/product_repository.dart';

class AllProductsView extends ConsumerWidget {
  const AllProductsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allProducts = ref.watch(futureProductsProvider);
    final productSortType = ref.watch(productSortTypeProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text("All Products"),
          actions: [
            Row(
              children: [
                Container(
                  color: productSortType == ProductSortType.name
                      ? Colors.purple.withOpacity(0.5)
                      : Colors.transparent,
                  child: TextButton(
                      onPressed: () {
                        ref.read(productSortTypeProvider.notifier).state =
                            ProductSortType.name;
                      },
                      child: const Text("Name")),
                ),
                Container(
                  color: productSortType == ProductSortType.price
                      ? Colors.purple.withOpacity(0.5)
                      : Colors.transparent,
                  child: TextButton(
                      onPressed: () {
                        ref.read(productSortTypeProvider.notifier).state =
                            ProductSortType.price;
                      },
                      child: const Text("Price")),
                )
              ],
            )
          ],
        ),
        body: allProducts.when(
          data: (data) => SingleChildScrollView(
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 3,
                mainAxisSpacing: 2,
              ),
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                final product = data.elementAt(index);
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
                      TextButton(
                        onPressed: () {
                          ref
                              .read(cartNotifierProvider.notifier)
                              .addProductToCart(product);
                        },
                        child: const Text("Add to Cart"),
                      )
                    ],
                  )),
                );
              },
            ),
          ),
          error: (error, _) => Text(error.toString()),
          loading: () => const CircularProgressIndicator(),
        ));
  }
}
