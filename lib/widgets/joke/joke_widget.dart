import 'package:chuck_norris/api/dio_client.dart';
import 'package:chuck_norris/constants/variable_constants.dart';
import 'package:chuck_norris/models/joke_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class JokeWidget extends StatefulWidget {
  final String? category;
  final JokeModel? model;
  const JokeWidget({this.category, this.model, Key? key}) : super(key: key);

  @override
  State<JokeWidget> createState() => _JokeWidgetState();
}

class _JokeWidgetState extends State<JokeWidget> {
  bool _dataFetched = false;
  late JokeModel? model;

  @override
  void initState() {
    super.initState();
    if (widget.category != null) {
      fetchData();
    } else {
      model = widget.model;
      _dataFetched = true;
    }
  }

  void fetchData() async {
    model = await DioClient().getRandomJoke(widget.category!);

    if (mounted) {
      setState(() {
        _dataFetched = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _dataFetched
        ? Container(
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                borderRadius: smallRadius),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IntrinsicHeight(
                      child: Padding(
                        padding: smallEdgeInstes,
                        child: Image.network(model!.icon_url),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: smallEdgeInstes,
                        child: Text(
                          model!.value,
                          maxLines: 10,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
                  alignment: Alignment.centerRight,
                  child: RichText(
                      text: TextSpan(
                          text: 'open in web browser',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              color: Colors.white),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              try {
                                await launch(model!.url, forceSafariVC: false);
                              } catch (_) {
                                throw 'Could not launch ${model!.url}';
                              }
                            })),
                ),
              ],
            ),
          )
        : Container(
            alignment: Alignment.center,
            padding: commonEdgeInstes,
            child: const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(color: Colors.white)),
          );
  }
}

// _launchURL(String url)  {
//   if (awaircanLaunch(url)) {
//     launch(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }
