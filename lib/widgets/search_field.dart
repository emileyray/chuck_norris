import 'package:chuck_norris/api/dio_client.dart';
import 'package:chuck_norris/constants/colors.dart';
import 'package:chuck_norris/constants/variable_constants.dart';
import 'package:chuck_norris/models/joke_model.dart';
import 'package:flutter/material.dart';

import 'joke/joke_widget.dart';

class SearchField extends StatefulWidget {
  const SearchField({Key? key}) : super(key: key);

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  bool _resultsVisible = false;
  List<JokeModel>? _searchResults = [];
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        setState(() {
          _resultsVisible = false;
        });

        return true as Future<bool>;
      },
      child: Container(
          height: _resultsVisible ? MediaQuery.of(context).size.height : null,
          width: MediaQuery.of(context).size.width,
          padding: commonEdgeInstes,
          decoration:
              BoxDecoration(color: primaryColor, borderRadius: commonRadius),
          child: Column(children: [
            _isSearching
                ? Padding(
                    padding: commonBottomEdgeInsets,
                    child: const CircularProgressIndicator(color: Colors.white),
                  )
                : _resultsVisible
                    ? Expanded(
                        child: Container(
                          padding: commonBottomEdgeInsets,
                          decoration: BoxDecoration(borderRadius: smallRadius),
                          child: ListView.separated(
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(),
                            itemCount: _searchResults!.length,
                            itemBuilder: (_, index) =>
                                JokeWidget(model: _searchResults![index]),
                          ),
                        ),
                      )
                    : Wrap(),
            IntrinsicHeight(
              child: TextField(
                decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white54,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    )),
                onChanged: (value) async {
                  if (value != '') {
                    setState(() {
                      _isSearching = true;
                      _resultsVisible = false;
                    });
                    var searchModel = await DioClient().search(value);
                    setState(() {
                      if (searchModel != null) {
                        _searchResults = searchModel.result;
                        if (_searchResults!.isNotEmpty) {
                          _resultsVisible = true;
                        } else {
                          _resultsVisible = false;
                        }
                      } else {
                        _resultsVisible = false;
                      }
                      _isSearching = false;
                    });
                  } else {
                    _resultsVisible = false;
                  }
                },
              ),
            ),
          ])),
    );
  }
}
