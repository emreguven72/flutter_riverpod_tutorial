import 'package:flutter_riverpod/flutter_riverpod.dart';

final productSortTypeProvider = StateProvider<ProductSortType>((ref) => ProductSortType.name);

enum ProductSortType { name, price }