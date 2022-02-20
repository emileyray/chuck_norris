import 'package:equatable/equatable.dart';

abstract class CategoriesEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class CategoriesRequestedEvent extends CategoriesEvent {}
