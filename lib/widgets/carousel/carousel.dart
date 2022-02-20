import 'package:carousel_slider/carousel_slider.dart';
import 'package:chuck_norris/constants/variable_constants.dart';
import 'package:chuck_norris/widgets/carousel/carousel_bloc.dart';
import 'package:chuck_norris/widgets/category_item.dart';
import 'package:chuck_norris/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Pair<T1, T2> {
  final T1 a;
  final T2 b;

  Pair(this.a, this.b);
}

class Carousel extends StatefulWidget {
  const Carousel({required this.categories, Key? key}) : super(key: key);

  final List<String> categories;

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel>
    with SingleTickerProviderStateMixin {
  late bool _open;
  late AnimationController _animController;
  late Animation _widthAnimation;
  late Animation _heightAnimation;
  late List<CategoryItem> _categoryItems;

  void reverseOpen() {
    _open = !_open;
  }

  @override
  void initState() {
    super.initState();

    _open = false;
    _animController =
        AnimationController(vsync: this, duration: animationDuration);

    _categoryItems = widget.categories
        .map(
          (item) => CategoryItem(value: item),
        )
        .toList();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _widthAnimation =
        Tween<double>(begin: 0.6, end: 1).animate(_animController);
    _heightAnimation = Tween<double>(
            begin: categoryHeight,
            end: MediaQuery.of(context).size.height -
                logoHeight -
                logoOffset -
                categoryHeight)
        .animate(_animController);

    return BlocProvider(
        create: (_) => CarouselBloc(
            animController: _animController,
            heightAnimation: _heightAnimation,
            widthAnimation: _widthAnimation,
            selectedCategory: widget.categories[0])
          ..add(CloseCarouselEvent()),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            AnimatedBuilder(
                animation: _animController,
                builder: (context, _) {
                  var _bloc = BlocProvider.of<CarouselBloc>(context);
                  return CarouselSlider(
                      options: CarouselOptions(
                        pageSnapping:
                            _bloc.animController.isAnimating ? false : true,
                        viewportFraction: _bloc.widthAnimation.value,
                        height: _bloc.heightAnimation.value,
                        enlargeCenterPage: true,
                        onPageChanged: (index, reason) {
                          _bloc.add(PageChangedEvent(widget.categories[index]));
                        },
                      ),
                      items: _categoryItems
                          .map((e) => Padding(
                                padding: commonEdgeInstes,
                                child: e,
                              ))
                          .toList());
                }),
            const Spacer(),
            const Logo(),
            SizedBox(height: logoOffset)
          ],
        ));
  }
}
