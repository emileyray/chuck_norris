import 'package:chuck_norris/models/joke_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_model.g.dart';

@JsonSerializable()
class SearchModel {
  final int total;
  final List<JokeModel> result;

  SearchModel(this.total, this.result);

  factory SearchModel.fromJson(Map<String, dynamic> json) =>
      _$SearchModelFromJson(json);
  Map<String, dynamic> toJson() => _$SearchModelToJson(this);
}
