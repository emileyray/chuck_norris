import 'package:chuck_norris/constants/variable_constants.dart';
import 'package:chuck_norris/widgets/carousel/carousel_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Logo extends StatefulWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  _LogoState createState() => _LogoState();
}

class _LogoState extends State<Logo> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarouselBloc, CarouselState>(
        builder: (context, state) => AnimatedContainer(
              height: state is CarouselClosedState ? logoHeight : 0,
              duration: animationDuration,
              child: Image.network(
                'https://api.chucknorris.io/img/chucknorris_logo_coloured_small@2x.png',
              ),
            ));
  }
}
