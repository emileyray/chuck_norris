import 'package:chuck_norris/api/dio_client.dart';
import 'package:chuck_norris/categories/categories_bloc.dart';
import 'package:chuck_norris/categories/categories_event.dart';
import 'package:chuck_norris/categories/categories_state.dart';
import 'package:chuck_norris/constants/variable_constants.dart';
import 'package:chuck_norris/widgets/carousel/carousel.dart';
import 'package:chuck_norris/widgets/search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CategoriesBloc()..add(CategoriesRequestedEvent()),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Colors.orange.shade700,
            secondary: Colors.orange.shade800,
          ),
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Jokes by Chuck Norris"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.info,
              color: Colors.white,
            ),
            onPressed: () {
              showAboutDialog(
                context: context,
                applicationName: 'Emil Khabibullin',
                applicationVersion: '3-rd year IU student',
              );
            },
          )
        ],
      ),
      body: SafeArea(minimum: largeEdgeInsets, child: const Search()),
    );
  }
}

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CategoriesBloc>().state;
    if (state is CategoriesInitialState) {
      return const Center(child: CircularProgressIndicator(color: Colors.grey));
    } else if (state is CategoriesLoadingState) {
      return const Center(child: CircularProgressIndicator(color: Colors.grey));
    } else if (state is CategoriesLoadedState) {
      return Stack(alignment: Alignment.bottomCenter, children: [
        Container(
          alignment: Alignment.topCenter,
          child: Carousel(categories: state.categories),
        ),
        const IntrinsicHeight(child: SearchField()),
      ]);
    }
    return Container();
  }
}
