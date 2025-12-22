import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://api.virgincodes.com';
  static const String cdnUrl = 'https://cdn.virgincodes.com'; // CDN base URL


  String getFullImageUrl(String assetPath) {
    if (assetPath.isEmpty) return '';
    
    if (assetPath.startsWith('http://') || assetPath.startsWith('https://')) {
      return assetPath;
    }
    
    if (assetPath.startsWith('assets/')) {
      return '$cdnUrl/$assetPath';
    }
    
    return '$cdnUrl/$assetPath';
  }

  Future<Map<String, dynamic>> searchProducts(String query, {int page = 1, int limit = 20}) async {
    try {
      final url = Uri.parse('$baseUrl/store/product-search?q=$query&page=$page&limit=$limit');
      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to search products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error searching products: $e');
    }
  }

  Future<Map<String, dynamic>> getSearchSuggestions(String query) async {
    try {
      final url = Uri.parse('$baseUrl/store/product-search/suggestions?q=$query');
      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to get suggestions: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error getting suggestions: $e');
    }
  }

  Future<Map<String, dynamic>> getProductDetails(String handle) async {
    try {
      final url = Uri.parse('$baseUrl/store/product/$handle');
      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to get product details: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error getting product details: $e');
    }
  }

  Future<Map<String, dynamic>> getAllProducts({int page = 1, int limit = 20}) async {
    try {
      final url = Uri.parse('$baseUrl/store/product?page=$page&limit=$limit');
      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to get products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error getting products: $e');
    }
  }

  Future<Map<String, dynamic>> getBrands() async {
    try {
      final url = Uri.parse('$baseUrl/store/brand');
      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to get brands: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error getting brands: $e');
    }
  }

  Future<Map<String, dynamic>> getCategories() async {
    try {
      final url = Uri.parse('$baseUrl/store/product-category');
      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to get categories: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error getting categories: $e');
    }
  }
}