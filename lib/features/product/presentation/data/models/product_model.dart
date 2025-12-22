class ProductModel {
  final String id;
  final String title;
  final String? subtitle;
  final String description;
  final String thumbnail;
  final String handle;
  final int reviewsCount;
  final double? averageRating;
  final List<ProductImage> productImages;
  final List<ProductVariant> variants;
  final List<ProductCategory> productCategories;
  final double priceStart;
  final double? priceEnd;

  ProductModel({
    required this.id,
    required this.title,
    this.subtitle,
    required this.description,
    required this.thumbnail,
    required this.handle,
    required this.reviewsCount,
    this.averageRating,
    required this.productImages,
    required this.variants,
    required this.productCategories,
    required this.priceStart,
    this.priceEnd,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      subtitle: json['subtitle'],
      description: json['description'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      handle: json['handle'] ?? '',
      reviewsCount: json['reviewsCount'] ?? 0,
      averageRating: json['averageRating']?.toDouble(),
      productImages: (json['productImages'] as List?)
          ?.map((i) => ProductImage.fromJson(i))
          .toList() ?? [],
      variants: (json['variants'] as List?)
          ?.map((v) => ProductVariant.fromJson(v))
          .toList() ?? [],
      productCategories: (json['productCategories'] as List?)
          ?.map((c) => ProductCategory.fromJson(c))
          .toList() ?? [],
      priceStart: json['priceStart']?.toDouble() ?? 0.0,
      priceEnd: json['priceEnd']?.toDouble(),
    );
  }
}


class ProductVariant {
  final String id;
  final String sku;
  final String title;
  final double price;
  final int inventoryQuantity;
  final double originalPrice;
  final double currentPrice;
  final double? specialPrice;
  final List<OptionValue> optionValues;

  ProductVariant({
    required this.id,
    required this.sku,
    required this.title,
    required this.price,
    required this.inventoryQuantity,
    required this.originalPrice,
    required this.currentPrice,
    this.specialPrice,
    required this.optionValues,
  });

  factory ProductVariant.fromJson(Map<String, dynamic> json) {
    return ProductVariant(
      id: json['id'] ?? '',
      sku: json['sku'] ?? '',
      title: json['title'] ?? '',
      price: json['price']?.toDouble() ?? 0.0,
      inventoryQuantity: json['inventoryQuantity'] ?? 0,
      originalPrice: json['originalPrice']?.toDouble() ?? 0.0,
      currentPrice: json['currentPrice']?.toDouble() ?? 0.0,
      specialPrice: json['specialPrice']?.toDouble(),
      optionValues: (json['optionValues'] as List?)
          ?.map((o) => OptionValue.fromJson(o))
          .toList() ?? [],
    );
  }
}

class OptionValue {
  final String id;
  final String value; // e.g., "Red"
  final ProductOption? productOption;

  OptionValue({required this.id, required this.value, this.productOption});

  factory OptionValue.fromJson(Map<String, dynamic> json) {
    return OptionValue(
      id: json['id'] ?? '',
      value: json['value'] ?? '',
      productOption: json['productOption'] != null 
          ? ProductOption.fromJson(json['productOption']) 
          : null,
    );
  }
}

class ProductOption {
  final String title; // e.g., "Colour"

  ProductOption({required this.title});

  factory ProductOption.fromJson(Map<String, dynamic> json) {
    return ProductOption(title: json['title'] ?? '');
  }
}

class ProductImage {
  final String image;

  ProductImage({required this.image});

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(image: json['image'] ?? '');
  }
}

class ProductCategory {
  final CategoryDetails? category;

  ProductCategory({this.category});

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    return ProductCategory(
      category: json['category'] != null ? CategoryDetails.fromJson(json['category']) : null,
    );
  }
}

class CategoryDetails {
  final String name;
  final String fullPath;

  CategoryDetails({required this.name, required this.fullPath});

  factory CategoryDetails.fromJson(Map<String, dynamic> json) {
    return CategoryDetails(
      name: json['name'] ?? '',
      fullPath: json['fullPath'] ?? '',
    );
  }
}