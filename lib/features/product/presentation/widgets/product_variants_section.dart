import 'package:flutter/material.dart';
import 'package:superlabs_ecommerce/features/product/presentation/data/models/product_model.dart';

class ProductVariantsSection extends StatefulWidget {
  final List<ProductVariant> variants;

  const ProductVariantsSection({super.key, required this.variants});

  @override
  State<ProductVariantsSection> createState() => _ProductVariantsSectionState();
}

class _ProductVariantsSectionState extends State<ProductVariantsSection> {
  int _selectedVariantIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.variants.isEmpty) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select Variant',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          
          // Variant Options
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(
              widget.variants.length,
              (index) {
                final variant = widget.variants[index];
                final isSelected = _selectedVariantIndex == index;
                final isOutOfStock = variant.inventoryQuantity <= 0;
                
                return GestureDetector(
                  onTap: isOutOfStock ? null : () {
                    setState(() {
                      _selectedVariantIndex = index;
                    });
                  },
                  child: Opacity(
                    opacity: isOutOfStock ? 0.5 : 1.0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.pink : Colors.white,
                        border: Border.all(
                          color: isSelected ? Colors.pink : Colors.grey[300]!,
                          width: isSelected ? 2 : 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Variant Title/Options
                          Text(
                            _buildVariantLabel(variant),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          
                          // Price
                          if (variant.currentPrice > 0)
                            Row(
                              children: [
                                Text(
                                  '₹${variant.currentPrice.toStringAsFixed(0)}',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: isSelected ? Colors.white : Colors.black,
                                  ),
                                ),
                                if (variant.originalPrice > variant.currentPrice) ...[
                                  const SizedBox(width: 6),
                                  Text(
                                    '₹${variant.originalPrice.toStringAsFixed(0)}',
                                    style: TextStyle(
                                      fontSize: 11,
                                      decoration: TextDecoration.lineThrough,
                                      color: isSelected ? Colors.white70 : Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          
                          // Stock status
                          if (isOutOfStock)
                            Text(
                              'Out of Stock',
                              style: TextStyle(
                                fontSize: 11,
                                color: isSelected ? Colors.white : Colors.red,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Selected Variant Details
          if (_selectedVariantIndex < widget.variants.length)
            _buildSelectedVariantDetails(),
        ],
      ),
    );
  }

  String _buildVariantLabel(ProductVariant variant) {
    if (variant.optionValues.isNotEmpty) {
      return variant.optionValues
          .map((opt) => opt.value)
          .where((v) => v.isNotEmpty)
          .join(' / ');
    }
    
    if (variant.title.isNotEmpty) {
      return variant.title;
    }
    
    return variant.sku.isNotEmpty ? variant.sku : 'Option';
  }

  Widget _buildSelectedVariantDetails() {
    final selectedVariant = widget.variants[_selectedVariantIndex];
    
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SKU
          if (selectedVariant.sku.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'SKU:',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  selectedVariant.sku,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          
          const SizedBox(height: 8),
          
          // Price Details
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Price:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '₹${selectedVariant.currentPrice.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (selectedVariant.originalPrice > selectedVariant.currentPrice)
                    Text(
                      'Was ₹${selectedVariant.originalPrice.toStringAsFixed(0)}',
                      style: TextStyle(
                        fontSize: 12,
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey[600],
                      ),
                    ),
                ],
              ),
            ],
          ),
          
          // Special Price
          if (selectedVariant.specialPrice != null && selectedVariant.specialPrice! > 0) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Special Price: ₹${selectedVariant.specialPrice!.toStringAsFixed(0)}',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.green[700],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
          
          const SizedBox(height: 8),
          
          // Stock
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Available:',
                style: TextStyle(fontSize: 14),
              ),
              Text(
                '${selectedVariant.inventoryQuantity} units',
                style: TextStyle(
                  fontSize: 14,
                  color: selectedVariant.inventoryQuantity > 0 
                      ? Colors.green[700] 
                      : Colors.red[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          
          // Option Values Details
          if (selectedVariant.optionValues.isNotEmpty) ...[
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 8),
            ...selectedVariant.optionValues.map((optVal) {
              if (optVal.productOption != null) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${optVal.productOption!.title}:',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        optVal.value,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            }),
          ],
        ],
      ),
    );
  }
}