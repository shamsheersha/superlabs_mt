// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:superlabs_ecommerce/core/services/api_services.dart';
// import 'package:superlabs_ecommerce/features/product/presentation/data/models/product_model.dart';
// import 'package:superlabs_ecommerce/features/product/presentation/pages/product_details_page.dart';

// class ProductGridItem extends StatelessWidget {
//   final ProductModel product;

//   const ProductGridItem({super.key, required this.product});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => ProductDetailsPage(
//               productHandle: product.handle,
//             ),
//           ),
//         );
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.1),
//               spreadRadius: 1,
//               blurRadius: 5,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Product Image
//             Expanded(
//               child: ClipRRect(
//                 borderRadius: const BorderRadius.vertical(
//                   top: Radius.circular(12),
//                 ),
//                 child: product.thumbnail.isNotEmpty
//                     ? CachedNetworkImage(
//                         imageUrl: ApiService().getFullImageUrl(
//                           product.productImages.isNotEmpty
//                               ? product.productImages.first.image
//                               : product.thumbnail,
//                         ),
//                         width: double.infinity,
//                         fit: BoxFit.cover,
//                         placeholder: (context, url) => Container(
//                           color: Colors.grey[200],
//                           child: const Center(
//                             child: CircularProgressIndicator(color: Colors.pink,),
//                           ),
//                         ),
//                         errorWidget: (context, url, error) => Container(
//                           color: Colors.grey[200],
//                           child: const Icon(Icons.image_not_supported),
//                         ),
//                       )
//                     : Container(
//                         color: Colors.grey[200],
//                         child: const Icon(Icons.image_not_supported, size: 50),
//                       ),
//               ),
//             ),
            
//             // Product Info
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Subtitle (if available)
//                   if (product.subtitle != null && product.subtitle!.isNotEmpty)
//                     Text(
//                       product.subtitle!,
//                       style: TextStyle(
//                         fontSize: 11,
//                         color: Colors.grey[600],
//                         fontWeight: FontWeight.w500,
//                       ),
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
                  
//                   const SizedBox(height: 4),
                  
//                   // Product Title
//                   Text(
//                     product.title,
//                     style: const TextStyle(
//                       fontSize: 13,
//                       fontWeight: FontWeight.w600,
//                     ),
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
                  
//                   const SizedBox(height: 4),
                  
//                   // Rating and Reviews
//                   Row(
//                     children: [
//                       if (product.averageRating != null) ...[
//                         Icon(
//                           Icons.star,
//                           size: 14,
//                           color: Colors.amber[700],
//                         ),
//                         const SizedBox(width: 2),
//                         Text(
//                           product.averageRating!.toStringAsFixed(1),
//                           style: const TextStyle(fontSize: 11),
//                         ),
//                         const SizedBox(width: 4),
//                       ],
//                       if (product.reviewsCount > 0)
//                         Text(
//                           '(${product.reviewsCount})',
//                           style: TextStyle(
//                             fontSize: 11,
//                             color: Colors.grey[600],
//                           ),
//                         ),
//                     ],
//                   ),
                  
//                   const SizedBox(height: 4),
                  
//                   // Price Information
//                   Row(
//                     children: [
//                       // Current Price
//                       Text(
//                         '₹${product.priceStart.toStringAsFixed(0)}',
//                         style: const TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         ),
//                       ),
                      
//                       // Price Range (if priceEnd exists and different)
//                       if (product.priceEnd != null && 
//                           product.priceEnd! > product.priceStart) ...[
//                         Text(
//                           ' - ₹${product.priceEnd!.toStringAsFixed(0)}',
//                           style: const TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black,
//                           ),
//                         ),
//                       ],
//                     ],
//                   ),
                  
//                   // Stock Status (based on variants)
//                   const SizedBox(height: 4),
//                   _buildStockStatus(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }


//   Widget _buildStockStatus() {
//     // Check if any variant has stock
//     bool hasStock = product.variants.any((variant) => variant.inventoryQuantity > 0);
    
//     if (!hasStock && product.variants.isNotEmpty) {
//       return Container(
//         margin: const EdgeInsets.only(top: 4),
//         padding: const EdgeInsets.symmetric(
//           horizontal: 6,
//           vertical: 2,
//         ),
//         decoration: BoxDecoration(
//           color: Colors.red[50],
//           borderRadius: BorderRadius.circular(4),
//         ),
//         child: Text(
//           'Out of Stock',
//           style: TextStyle(
//             fontSize: 10,
//             color: Colors.red[700],
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       );
//     }
    
//     return const SizedBox.shrink();
//   }
// }


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:superlabs_ecommerce/core/services/api_services.dart';
import 'package:superlabs_ecommerce/features/product/presentation/data/models/product_model.dart';
import 'package:superlabs_ecommerce/features/product/presentation/pages/product_details_page.dart';

class ProductGridItem extends StatelessWidget {
  final ProductModel product;

  const ProductGridItem({super.key, required this.product});

  // Method to get the best available image
  String _getProductImageUrl() {
    // Priority: productImages > thumbnail
    if (product.productImages.isNotEmpty && 
        product.productImages.first.image.isNotEmpty) {
      return product.productImages.first.image;
    }
    
    if (product.thumbnail.isNotEmpty) {
      return product.thumbnail;
    }
    
    return ''; // No image available
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = _getProductImageUrl();
    
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsPage(
              productHandle: product.handle,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: imageUrl.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: ApiService().getFullImageUrl(imageUrl),
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: Colors.grey[200],
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: Colors.pink,
                              strokeWidth: 2,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) {
                          debugPrint('Image load error: $url');
                          debugPrint('Error: $error');
                          
                          return Container(
                            color: Colors.grey[200],
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.image_not_supported,
                                  size: 40,
                                  color: Colors.grey[400],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Image not available',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    : Container(
                        color: Colors.grey[200],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image_not_supported,
                              size: 50,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'No image',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
            
            // Product Info
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Subtitle (if available)
                  if (product.subtitle != null && product.subtitle!.isNotEmpty)
                    Text(
                      product.subtitle!,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  
                  const SizedBox(height: 4),
                  
                  // Product Title
                  Text(
                    product.title,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  const SizedBox(height: 4),
                  
                  // Rating and Reviews
                  Row(
                    children: [
                      if (product.averageRating != null) ...[
                        Icon(
                          Icons.star,
                          size: 14,
                          color: Colors.amber[700],
                        ),
                        const SizedBox(width: 2),
                        Text(
                          product.averageRating!.toStringAsFixed(1),
                          style: const TextStyle(fontSize: 11),
                        ),
                        const SizedBox(width: 4),
                      ],
                      if (product.reviewsCount > 0)
                        Text(
                          '(${product.reviewsCount})',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[600],
                          ),
                        ),
                    ],
                  ),
                  
                  const SizedBox(height: 4),
                  
                  // Price Information
                  Row(
                    children: [
                      // Current Price
                      Text(
                        '₹${product.priceStart.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      
                      // Price Range (if priceEnd exists and different)
                      if (product.priceEnd != null && 
                          product.priceEnd! > product.priceStart) ...[
                        Text(
                          ' - ₹${product.priceEnd!.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ],
                  ),
                  
                  // Stock Status (based on variants)
                  const SizedBox(height: 4),
                  _buildStockStatus(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStockStatus() {
    // Check if any variant has stock
    bool hasStock = product.variants.any((variant) => variant.inventoryQuantity > 0);
    
    if (!hasStock && product.variants.isNotEmpty) {
      return Container(
        margin: const EdgeInsets.only(top: 4),
        padding: const EdgeInsets.symmetric(
          horizontal: 6,
          vertical: 2,
        ),
        decoration: BoxDecoration(
          color: Colors.red[50],
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          'Out of Stock',
          style: TextStyle(
            fontSize: 10,
            color: Colors.red[700],
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }
    
    return const SizedBox.shrink();
  }
}