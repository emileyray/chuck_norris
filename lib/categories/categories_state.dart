import 'package:equatable/equatable.dart';

abstract class CategoriesState extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class CategoriesInitialState extends CategoriesState {}

class CategoriesLoadingState extends CategoriesState {}

class CategoriesLoadedState extends CategoriesState {
  final List<String> categories;

  CategoriesLoadedState({required this.categories});
}
