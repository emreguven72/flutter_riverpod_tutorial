import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider_tutorial/repository/product_repository.dart';

class FutureProviderView extends ConsumerWidget {
  const FutureProviderView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fakeDataList = ref.watch(futureBasicProductsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Future Provider"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: fakeDataList.when(
                data: (data) => GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      color: Colors.amber,
                      child: Center(
                          child: Column(
                        children: [
                          Text(data.elementAt(index).name),
                          Text(data.elementAt(index).name),
                          Text('${data.elementAt(index).price}'),
                        ],
                      )),
                    );
                  },
                ),
                error: (error, _) => Text(error.toString()),
                loading: () => const CircularProgressIndicator(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
