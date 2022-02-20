import 'dart:math';

import 'package:chuck_norris/constants/variable_constants.dart';
import 'package:chuck_norris/widgets/carousel/carousel_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import 'joke/joke_widget.dart';

class CategoryItem extends StatefulWidget {
  final String value;
  const CategoryItem({
    Key? key,
    required this.value,
  }) : super(key: key);

  @override
  _CategoryItemState createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  late double _width = 0;

  @override
  void initState() {
    super.initState();

    var keyboardVisibilityController = KeyboardVisibilityController();

    keyboardVisibilityController.onChange.listen((bool visible) {
      if (visible && mounted) {
        setState(() {
          if (BlocProvider.of<CarouselBloc>(context).state
              is CarouselOpenState) {
            BlocProvider.of<CarouselBloc>(context).add(CloseCarouselEvent());
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    CarouselBloc _bloc = BlocProvider.of<CarouselBloc>(context);
    _width = MediaQuery.of(context).size.width * 0.8;

    return GestureDetector(
      onTap: () {
        setState(() {
          FocusScope.of(context).unfocus();
          if (_bloc.state is CarouselOpenState) {
            _bloc.add(CloseCarouselEvent());
          } else if (_bloc.state is CarouselClosedState) {
            _bloc.add(OpenCarouselEvent());
          }
        });
      },
      child: Container(
        width: _width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: textToColors(widget.value),
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              AnimatedPositioned(
                duration: animationDuration,
                top: _bloc.state is CarouselOpenState ? 0 : 20,
                child: AnimatedDefaultTextStyle(
                  child: Text(widget.value),
                  duration: animationDuration,
                  style: TextStyle(
                      fontSize: _bloc.state is CarouselOpenState ? 25 : 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
              ),
              _bloc.state is CarouselOpenState
                  ? Column(
                      children: [
                        const SizedBox(height: 40),
                        Expanded(
                          child: ListView.separated(
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const Divider(),
                              itemCount: 50,
                              itemBuilder: (_, index) => JokeWidget(
                                    category: widget.value,
                                  )),
                        ),
                      ],
                    )
                  : Wrap()
            ],
          ),
        ),
      ),
    );
  }
}

List<Color> textToColors(String str) {
  var arr = List<double>.filled(6, 0);

  for (int i = 0; i < str.length; i++) {
    arr[i % 6] += str.codeUnitAt(i);
  }

  for (int i = 0; i < 6; i++) {
    arr[i] /= arr.reduce(max);
  }

  return [
    Color.fromRGBO((arr[0] * 255).toInt(), (arr[1] * 100).toInt(),
        (arr[2] * 200).toInt(), 0.8),
    Color.fromRGBO((arr[3] * 255).toInt(), (arr[4] * 200).toInt(),
        (arr[5] * 100).toInt(), 0.8),
  ];
}
