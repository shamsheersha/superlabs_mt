import 'package:equatable/equatable.dart';
import 'package:superlabs_ecommerce/features/product/presentation/data/models/product_model.dart';

abstract class SearchState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<ProductModel> products;
  final String query;
  final bool hasMore;
  final int currentPage;

  SearchLoaded({
    required this.products,
    required this.query,
    this.hasMore = true,
    this.currentPage = 1,
  });

  @override
  List<Object?> get props => [products, query, hasMore, currentPage];

  SearchLoaded copyWith({
    List<ProductModel>? products,
    String? query,
    bool? hasMore,
    int? currentPage,
  }) {
    return SearchLoaded(
      products: products ?? this.products,
      query: query ?? this.query,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

class SearchError extends SearchState {
  final String message;
  SearchError(this.message);

  @override
  List<Object?> get props => [message];
}