import 'dart:async';
import 'package:chuck_norris/api/dio_client.dart';
import 'package:chuck_norris/categories/categories_state.dart';
import 'categories_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  var categories;
  CategoriesBloc() : super(CategoriesInitialState()) {
    on<CategoriesRequestedEvent>((event, emit) async {
      emit(CategoriesLoadingState());
      categories = await DioClient().getCategories();
      emit(CategoriesLoadedState(categories: categories));
    });
  }
}
