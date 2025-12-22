import 'package:equatable/equatable.dart';
import 'package:superlabs_ecommerce/features/product/presentation/data/models/product_model.dart';

abstract class ProductState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final ProductModel product;
  final Map<String, dynamic> fullDetails;

  ProductLoaded({
    required this.product,
    required this.fullDetails,
  });

  @override
  List<Object?> get props => [product, fullDetails];
}

class ProductError extends ProductState {
  final String message;
  ProductError(this.message);

  @override
  List<Object?> get props => [message];
}