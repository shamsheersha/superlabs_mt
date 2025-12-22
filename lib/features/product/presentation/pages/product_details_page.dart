import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superlabs_ecommerce/features/product/presentation/bloc/product_bloc_bloc.dart';
import 'package:superlabs_ecommerce/features/product/presentation/bloc/product_bloc_event.dart';
import 'package:superlabs_ecommerce/features/product/presentation/bloc/product_bloc_state.dart';
import 'package:superlabs_ecommerce/features/product/presentation/widgets/image_carousal.dart';
import 'package:superlabs_ecommerce/features/product/presentation/widgets/product_info_section.dart';
import 'package:superlabs_ecommerce/features/product/presentation/widgets/product_variants_section.dart';


class ProductDetailsPage extends StatefulWidget {
  final String productHandle;

  const ProductDetailsPage({super.key, required this.productHandle});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(LoadProductDetails(widget.productHandle));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator(color: Colors.pink,));
          }

          if (state is ProductError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 60, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${state.message}',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<ProductBloc>()
                          .add(LoadProductDetails(widget.productHandle));
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is ProductLoaded) {
            final product = state.product;
            
            // Check if any variant has stock
            final hasStock = product.variants.any((v) => v.inventoryQuantity > 0);

            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image Carousel
                        ImageCarousel(
                          productImages: product.productImages,
                          thumbnail: product.thumbnail,
                        ),

                        const SizedBox(height: 16),

                        // Product Info
                        ProductInfoSection(product: product),

                        const Divider(height: 32),

                        // Variants
                        if (product.variants.isNotEmpty)
                          ProductVariantsSection(
                            variants: product.variants,
                          ),

                        const Divider(height: 32),

                        // Description
                        if (product.description.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Description',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  product.description,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[700],
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),

                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                ),

                // Bottom Action Bar
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: hasStock ? () {} : null,
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            side: BorderSide(
                              color: hasStock
                                  ? Colors.pink
                                  : Colors.grey,
                            ),
                          ),
                          child: const Text(
                            'Add to Cart',
                            style: TextStyle(fontSize: 16,color: Colors.pink),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: hasStock ? () {} : null,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            backgroundColor: Colors.pink,
                            disabledBackgroundColor: Colors.grey,
                          ),
                          child: Text(
                            hasStock ? 'Buy Now' : 'Out of Stock',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}