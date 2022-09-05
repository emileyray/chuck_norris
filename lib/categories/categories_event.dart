import 'package:equatable/equatable.dart';

abstract class CategoriesEvent extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class CategoriesRequestedEvent extends CategoriesEvent {}
