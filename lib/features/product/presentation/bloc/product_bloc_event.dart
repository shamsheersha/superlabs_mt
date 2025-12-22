import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadProductDetails extends ProductEvent {
  final String handle;
  LoadProductDetails(this.handle);

  @override
  List<Object?> get props => [handle];
}