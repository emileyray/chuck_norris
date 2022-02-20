import 'package:json_annotation/json_annotation.dart';

part 'joke_model.g.dart';

@JsonSerializable()
class JokeModel {
  final String icon_url;
  final String id;
  final String url;
  final String value;

  JokeModel(this.icon_url, this.id, this.url, this.value);

  factory JokeModel.fromJson(Map<String, dynamic> json) =>
      _$JokeModelFromJson(json);
  Map<String, dynamic> toJson() => _$JokeModelToJson(this);
}
