import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superlabs_ecommerce/core/services/api_services.dart';
import 'package:superlabs_ecommerce/features/product/presentation/data/models/product_model.dart';
import 'package:superlabs_ecommerce/features/search/presentation/bloc/search_bloc_event.dart';
import 'package:superlabs_ecommerce/features/search/presentation/bloc/search_bloc_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final ApiService apiService;

  SearchBloc(this.apiService) : super(SearchInitial()) {
    on<SearchQueryChanged>(_onSearchQueryChanged);
    on<LoadMoreProducts>(_onLoadMoreProducts);
    on<LoadAllProducts>(_onLoadAllProducts);
    on<ClearSearch>(_onClearSearch);
  }

  Future<void> _onSearchQueryChanged(
    SearchQueryChanged event,
    Emitter<SearchState> emit,
  ) async {
    if (event.query.isEmpty) {
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());

    try {
      final response = await apiService.searchProducts(event.query, page: 1);
      final List<ProductModel> products = [];

      if (response['data'] != null && response['data']['products'] is List) {
        for (var item in response['data']['products']) {
          products.add(ProductModel.fromJson(item));
        }
      }

      emit(SearchLoaded(
        products: products,
        query: event.query,
        hasMore: products.length >= 20,
        currentPage: 1,
      ));
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }

  Future<void> _onLoadMoreProducts(
    LoadMoreProducts event,
    Emitter<SearchState> emit,
  ) async {
    if (state is SearchLoaded) {
      final currentState = state as SearchLoaded;
      if (!currentState.hasMore) return;

      try {
        final nextPage = currentState.currentPage + 1;
        final response = await apiService.searchProducts(
          currentState.query,
          page: nextPage,
        );

        final List<ProductModel> newProducts = [];
        if (response['data'] != null && response['data']['products'] is List) {
          for (var item in response['data']['products']) {
            newProducts.add(ProductModel.fromJson(item));
          }
        }

        emit(currentState.copyWith(
          products: [...currentState.products, ...newProducts],
          hasMore: newProducts.length >= 20,
          currentPage: nextPage,
        ));
      } catch (e) {
        throw Exception(e);
      }
    }
  }

  Future<void> _onLoadAllProducts(
    LoadAllProducts event,
    Emitter<SearchState> emit,
  ) async {
    emit(SearchLoading());

    try {
      final response = await apiService.getAllProducts(page: 1);
      final List<ProductModel> products = [];

      if (response['data'] != null && response['data'] is List) {
        for (var item in response['data']) {
          products.add(ProductModel.fromJson(item));
        }
      }

      emit(SearchLoaded(
        products: products,
        query: '',
        hasMore: products.length >= 20,
        currentPage: 1,
      ));
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }


  void _onClearSearch(ClearSearch event, Emitter<SearchState> emit) {
    emit(SearchInitial());
  }
}  