import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../providers/product.dart';
import '../pages/product_detail_page.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productModel = Provider.of<ProductModel>(context);
    final cartData = Provider.of<CartData>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailPage.routeTo,
                arguments: productModel.id);
          },
          child: Image.network(
            productModel.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          leading: IconButton(
            // color: Theme.of(context).colorScheme.secondary,
            color: Colors.deepOrange,
            icon: Icon(productModel.isFavourite
                ? Icons.favorite
                : Icons.favorite_border),
            onPressed: () {
              productModel.toggleFavoriteStatus();
            },
          ),
          backgroundColor: Colors.black87,
          title: Text(productModel.title, textAlign: TextAlign.center),
          trailing: IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              cartData.addItem(productModel.id!,
                  productModel.price, productModel.title);
              // productId, used as key in Map of _items
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Added!'),
                  duration: const Duration(seconds: 4),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {
                      cartData
                          .removeSingleCartItem(productModel.id!);
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
