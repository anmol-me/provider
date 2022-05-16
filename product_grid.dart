import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/product_item.dart';
import '../providers/product_data.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavs;

  const ProductsGrid({Key? key, required this.showFavs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productList = Provider.of<ProductData>(context);
    final selectedProductList =
        showFavs ? productList.favouriteItems : productList.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      // Nested Provider
      // is connected to Provider.of<Products>
      // for dynamic data
      itemCount: selectedProductList.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: selectedProductList[i],
        child: const ProductItem(
          // Would have this way without Provider
            // id: selectedProductsData[i].id,
            // title: selectedProductsData[i].title,
            // imageUrl: selectedProductsData[i].imageUrl,
            ),
      ),
    );
  }
}
