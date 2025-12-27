// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:superlabs_ecommerce/core/services/api_services.dart';

// class NetworkImageWithFallback extends StatefulWidget {
//   final String imageUrl;
//   final BoxFit fit;
//   final double? width;
//   final double? height;

//   const NetworkImageWithFallback({
//     super.key,
//     required this.imageUrl,
//     this.fit = BoxFit.cover,
//     this.width,
//     this.height,
//   });

//   @override
//   State<NetworkImageWithFallback> createState() => _NetworkImageWithFallbackState();
// }

// class _NetworkImageWithFallbackState extends State<NetworkImageWithFallback> {
//   late List<String> imageUrls;
//   int currentUrlIndex = 0;
//   bool hasError = false;

//   @override
//   void initState() {
//     super.initState();
//     imageUrls = ApiService().getImageUrlVariations(widget.imageUrl);
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (imageUrls.isEmpty || currentUrlIndex >= imageUrls.length) {
//       return _buildPlaceholder();
//     }

//     return CachedNetworkImage(
//       imageUrl: imageUrls[currentUrlIndex],
//       width: widget.width,
//       height: widget.height,
//       fit: widget.fit,
//       placeholder: (context, url) => Container(
//         width: widget.width,
//         height: widget.height,
//         color: Colors.grey[200],
//         child: const Center(
//           child: CircularProgressIndicator(
//             color: Colors.pink,
//             strokeWidth: 2,
//           ),
//         ),
//       ),
//       errorWidget: (context, url, error) {
//         debugPrint('❌ Image failed to load: $url');
//         debugPrint('Error: $error');
        
//         // Try next URL variation
//         if (currentUrlIndex < imageUrls.length - 1) {
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             if (mounted) {
//               setState(() {
//                 currentUrlIndex++;
//                 debugPrint('🔄 Trying next URL: ${imageUrls[currentUrlIndex]}');
//               });
//             }
//           });
//           return Container(
//             width: widget.width,
//             height: widget.height,
//             color: Colors.grey[200],
//             child: const Center(
//               child: CircularProgressIndicator(
//                 color: Colors.pink,
//                 strokeWidth: 2,
//               ),
//             ),
//           );
//         }
        
//         // All URLs failed, show error
//         return _buildPlaceholder();
//       },
//     );
//   }

//   Widget _buildPlaceholder() {
//     return Container(
//       width: widget.width,
//       height: widget.height,
//       color: Colors.grey[200],
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.image_not_supported,
//             size: widget.height != null ? widget.height! * 0.3 : 50,
//             color: Colors.grey[400],
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Image not available',
//             style: TextStyle(
//               fontSize: 10,
//               color: Colors.grey[600],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
