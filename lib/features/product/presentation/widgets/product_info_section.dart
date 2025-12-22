import 'package:flutter/material.dart';
import 'package:superlabs_ecommerce/features/product/presentation/data/models/product_model.dart';

class ProductInfoSection extends StatelessWidget {
  final ProductModel product;

  const ProductInfoSection({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Subtitle/Brand
          if (product.subtitle != null && product.subtitle!.isNotEmpty)
            Text(
              product.subtitle!,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),

          const SizedBox(height: 8),

          // Title
          Text(
            product.title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          // Rating
          if (product.averageRating != null)
            Row(
              children: [
                ...List.generate(5, (index) {
                  return Icon(
                    index < product.averageRating!.floor()
                        ? Icons.star
                        : Icons.star_border,
                    color: Colors.amber[700],
                    size: 20,
                  );
                }),
                const SizedBox(width: 8),
                Text(
                  product.averageRating!.toStringAsFixed(1),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (product.reviewsCount > 0) ...[
                  const SizedBox(width: 4),
                  Text(
                    '(${product.reviewsCount} reviews)',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ],
            ),

          const SizedBox(height: 16),

          // Price Information
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '₹${product.priceStart.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              if (product.priceEnd != null && product.priceEnd! > product.priceStart)
                Text(
                  ' - ₹${product.priceEnd!.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
            ],
          ),

          const SizedBox(height: 12),

          // Stock Status based on variants
          _buildStockStatus(),

          // Categories
          if (product.productCategories.isNotEmpty) ...[
            const SizedBox(height: 16),
            const Text(
              'Categories',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: product.productCategories
                  .where((pc) => pc.category != null)
                  .map((pc) => Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          pc.category!.name,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ))
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStockStatus() {
    bool hasStock = product.variants.any((v) => v.inventoryQuantity > 0);
    int totalStock = product.variants.fold(0, (sum, v) => sum + v.inventoryQuantity);

    return Row(
      children: [
        Icon(
          hasStock ? Icons.check_circle : Icons.cancel,
          color: hasStock ? Colors.green : Colors.red,
          size: 20,
        ),
        const SizedBox(width: 8),
        Text(
          hasStock ? 'In Stock ($totalStock units available)' : 'Out of Stock',
          style: TextStyle(
            fontSize: 14,
            color: hasStock ? Colors.green : Colors.red,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}