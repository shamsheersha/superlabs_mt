import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superlabs_ecommerce/core/services/api_services.dart';
import 'package:superlabs_ecommerce/features/product/presentation/bloc/product_bloc_bloc.dart';
import 'package:superlabs_ecommerce/features/search/presentation/bloc/search_bloc_bloc.dart';
import 'features/search/presentation/pages/search_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final apiService = ApiService();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SearchBloc(apiService),
        ),
        BlocProvider(
          create: (context) => ProductBloc(apiService),
        ),
      ],
      child: MaterialApp(
        title: 'BeautyBarn',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.pink,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        home: const SearchPage(),
      ),
    );
  }
}