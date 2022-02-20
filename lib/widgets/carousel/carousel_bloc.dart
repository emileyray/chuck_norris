import 'package:equatable/equatable.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CarouselEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class OpenCarouselEvent extends CarouselEvent {}

class CloseCarouselEvent extends CarouselEvent {}

class PageChangedEvent extends CarouselEvent {
  String currentCategory;
  PageChangedEvent(this.currentCategory);
}

abstract class CarouselState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class CarouselInitialState extends CarouselState {}

class CarouselClosedState extends CarouselState {}

class CarouselOpenState extends CarouselState {}

class CarouselBloc extends Bloc<CarouselEvent, CarouselState> {
  late String selectedCategory;
  late AnimationController animController;
  late Animation widthAnimation;
  late Animation heightAnimation;

  CarouselBloc(
      {required this.animController,
      required this.widthAnimation,
      required this.heightAnimation,
      required this.selectedCategory})
      : super(CarouselInitialState()) {
    on<CloseCarouselEvent>((event, emit) {
      animController.reverse();
      emit(CarouselClosedState());
    });
    on<OpenCarouselEvent>((event, emit) {
      animController.forward();
      emit(CarouselOpenState());
    });
    on<PageChangedEvent>((event, emit) {
      selectedCategory = event.currentCategory;
    });
  }
}
