import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider_tutorial/data/basic_product_fake_data.dart';
import 'package:provider_tutorial/data/product_fake_data.dart';
import 'package:provider_tutorial/models/basic_product.dart';
import 'package:provider_tutorial/models/product.dart';
import 'package:provider_tutorial/providers/product_sort_type.dart';

final futureBasicProductsProvider = FutureProvider<List<BasicProduct>>((ref) async {
  await Future.delayed(const Duration(seconds: 5));
  return BasicProductFakeData.products;
});

final futureProductsProvider = FutureProvider<List<Product>>((ref) async {
  await Future.delayed(const Duration(seconds: 1));
  final sortType = ref.watch(productSortTypeProvider);

  switch(sortType) {
    case ProductSortType.name:
      ProductFakeData.data_list.sort((a,b) => b.name.compareTo(a.name));
      break;
    case ProductSortType.price:
      ProductFakeData.data_list.sort((a,b) => b.newPrice.compareTo(a.newPrice));
      break;
  }

  return ProductFakeData.data_list;

});


