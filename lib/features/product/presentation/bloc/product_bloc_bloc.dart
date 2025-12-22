import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superlabs_ecommerce/core/services/api_services.dart';
import 'package:superlabs_ecommerce/features/product/presentation/bloc/product_bloc_event.dart';
import 'package:superlabs_ecommerce/features/product/presentation/bloc/product_bloc_state.dart';
import 'package:superlabs_ecommerce/features/product/presentation/data/models/product_model.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ApiService apiService;

  ProductBloc(this.apiService) : super(ProductInitial()) {
    on<LoadProductDetails>(_onLoadProductDetails);
  }

  Future<void> _onLoadProductDetails(
    LoadProductDetails event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());

    try {
      final response = await apiService.getProductDetails(event.handle);

      if (response['data'] != null) {
        final product = ProductModel.fromJson(response['data']);
        emit(ProductLoaded(
          product: product,
          fullDetails: response['data'],
        ));
      } else {
        emit(ProductError('Product not found'));
      }
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}