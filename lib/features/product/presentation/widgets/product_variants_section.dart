import 'package:flutter/material.dart';
import 'package:superlabs_ecommerce/features/product/presentation/data/models/product_model.dart';

class ProductVariantsSection extends StatefulWidget {
  final List<ProductVariant> variants;

  const ProductVariantsSection({super.key, required this.variants});

  @override
  State<ProductVariantsSection> createState() => _ProductVariantsSectionState();
}

class _ProductVariantsSectionState extends State<ProductVariantsSection> {
  int? _selectedVariantIndex;

  @override
  Widget build(BuildContext context) {
    if (widget.variants.isEmpty) return const SizedBox();

    final hasOptions = widget.variants.any((v) => v.optionValues.isNotEmpty);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Available Options',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

          if (hasOptions)
            _buildVariantsWithOptions()
          else
            _buildSimpleVariants(),
        ],
      ),
    );
  }

  Widget _buildVariantsWithOptions() {
    final variantsByOption = <String, List<ProductVariant>>{};
    
    for (var variant in widget.variants) {
      for (var optionValue in variant.optionValues) {
        final optionTitle = optionValue.productOption?.title ?? 'Option';
        variantsByOption.putIfAbsent(optionTitle, () => []);
        if (!variantsByOption[optionTitle]!.contains(variant)) {
          variantsByOption[optionTitle]!.add(variant);
        }
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: variantsByOption.entries.map((entry) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                entry.key,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: entry.value.asMap().entries.map((variantEntry) {
                  final index = widget.variants.indexOf(variantEntry.value);
                  final variant = variantEntry.value;
                  final isSelected = _selectedVariantIndex == index;
                  final hasStock = variant.inventoryQuantity > 0;

                  final optionValue = variant.optionValues.firstWhere(
                    (ov) => ov.productOption?.title == entry.key,
                    orElse: () => variant.optionValues.first,
                  );

                  return _buildVariantChip(
                    label: optionValue.value,
                    isSelected: isSelected,
                    hasStock: hasStock,
                    onTap: hasStock
                        ? () {
                            setState(() {
                              _selectedVariantIndex = index;
                            });
                          }
                        : null,
                  );
                }).toList(),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSimpleVariants() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: widget.variants.asMap().entries.map((entry) {
        final index = entry.key;
        final variant = entry.value;
        final isSelected = _selectedVariantIndex == index;
        final hasStock = variant.inventoryQuantity > 0;

        return _buildVariantChip(
          label: variant.title,
          isSelected: isSelected,
          hasStock: hasStock,
          onTap: hasStock
              ? () {
                  setState(() {
                    _selectedVariantIndex = index;
                  });
                }
              : null,
        );
      }).toList(),
    );
  }

  Widget _buildVariantChip({
    required String label,
    required bool isSelected,
    required bool hasStock,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.pink
              : (hasStock ? Colors.white : Colors.grey[200]),
          border: Border.all(
            color: isSelected
                ? Colors.pink
                : (hasStock ? Colors.grey[300]! : Colors.grey[400]!),
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            color: isSelected
                ? Colors.white
                : (hasStock ? Colors.black : Colors.grey[600]),
          ),
        ),
      ),
    );
  }
}