import 'package:json_annotation/json_annotation.dart';

part 'joke_model.g.dart';

@JsonSerializable()
class JokeModel {
  final String iconUrl;
  final String id;
  final String url;
  final String value;

  JokeModel(this.iconUrl, this.id, this.url, this.value);

  factory JokeModel.fromJson(Map<String, dynamic> json) =>
      _$JokeModelFromJson(json);
  Map<String, dynamic> toJson() => _$JokeModelToJson(this);
}
