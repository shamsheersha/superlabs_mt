import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:superlabs_ecommerce/features/product/presentation/data/models/product_model.dart';

class ImageCarousel extends StatefulWidget {
  final List<ProductImage> productImages;
  final String thumbnail;

  const ImageCarousel({
    super.key,
    required this.productImages,
    required this.thumbnail,
  });

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  List<String> _getImageUrls() {
    List<String> images = [];
    
    // Add product images
    if (widget.productImages.isNotEmpty) {
      images.addAll(
        widget.productImages
            .map((img) => _buildImageUrl(img.image))
            .where((url) => url.isNotEmpty),
      );
    }
    
    // If no product images, use thumbnail
    if (images.isEmpty && widget.thumbnail.isNotEmpty) {
      images.add(_buildImageUrl(widget.thumbnail));
    }
    
    return images;
  }

  String _buildImageUrl(String imagePath) {
    if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
      return imagePath;
    }
    
    // Convert relative path to full URL
    return 'https://api.virgincodes.com/$imagePath';
  }

  @override
  Widget build(BuildContext context) {
    final imageUrls = _getImageUrls();

    if (imageUrls.isEmpty) {
      return Container(
        height: 400,
        color: Colors.grey[200],
        child: const Center(
          child: Icon(Icons.image_not_supported, size: 80),
        ),
      );
    }

    return SizedBox(
      height: 400,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: imageUrls.length,
            itemBuilder: (context, index) {
              return CachedNetworkImage(
                imageUrl: imageUrls[index],
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey[200],
                  child: const Center(child: CircularProgressIndicator(color: Colors.pink,)),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[200],
                  child: const Icon(Icons.error, size: 60),
                ),
              );
            },
          ),
          if (imageUrls.length > 1)
            Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  imageUrls.length,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentPage == index
                          ? Colors.white
                          : Colors.white.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}