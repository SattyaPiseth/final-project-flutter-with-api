import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/products.dart';
import '../../../Provider/add_to_cart_provider.dart';
import '../../../Provider/favorite_provider.dart';

class ProductCard extends StatelessWidget {
  final Data product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final favoriteProvider = Provider.of<FavoriteProvider>(context, listen: false);

    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: InkWell(
        onTap: () {
          // Implement navigation to product details if needed
          // Navigator.pushNamed(context, '/product-details', arguments: product);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: AspectRatio(
                  aspectRatio: 1, // Aspect ratio of 1:1 (square)
                  child: product.image != null && product.image!.isNotEmpty
                      ? Image.network(
                    product.image!,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        color: Colors.grey[200],
                        child: const Center(child: CircularProgressIndicator()),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/default_product.png',
                        fit: BoxFit.cover,
                      );
                    },
                  )
                      : Image.asset(
                    'assets/default_product.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              Flexible(
                child: Text(
                  product.name ?? 'No Name',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              const SizedBox(height: 4.0),
              Flexible(
                child: Text(
                  product.description ?? 'No Description Available',
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                  maxLines: 2, // Limit the number of lines
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 12.0),
              // Uncomment and implement buttons if needed
              /*
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Add to Cart Button
                  ElevatedButton(
                    onPressed: () {
                      cartProvider.addToCart(product);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${product.name} added to cart!')),
                      );
                    },
                    child: const Text('Add to Cart'),
                  ),
                  // Favorite Button
                  IconButton(
                    icon: Icon(
                      favoriteProvider.isFavorite(product.id)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: favoriteProvider.isFavorite(product.id) ? Colors.red : null,
                    ),
                    onPressed: () {
                      favoriteProvider.toggleFavorite(product);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(favoriteProvider.isFavorite(product.id)
                              ? '${product.name} added to favorites!'
                              : '${product.name} removed from favorites!'),
                        ),
                      );
                    },
                  ),
                ],
              ),
              */
            ],
          ),
        ),
      ),
    );
  }
}
