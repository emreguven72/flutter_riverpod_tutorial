import 'package:provider_tutorial/models/product.dart';

class ProductFakeData {
    static final List<Product> data_list = [
      Product(id: 1, description: "Laptop", name: 'Macbook Pro', newPrice: 1000, oldPrice: 950),
      Product(id: 2, description: "Phone", name: 'IPhone 15', newPrice: 700, oldPrice: 900),
      Product(id: 3, description: "Laptop", name: 'Monster X', newPrice: 1500, oldPrice: 1590),
    ];
}