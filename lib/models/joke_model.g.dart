// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'joke_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JokeModel _$JokeModelFromJson(Map<String, dynamic> json) => JokeModel(
      json['icon_url'] as String,
      json['id'] as String,
      json['url'] as String,
      json['value'] as String,
    );

Map<String, dynamic> _$JokeModelToJson(JokeModel instance) => <String, dynamic>{
      'icon_url': instance.icon_url,
      'id': instance.id,
      'url': instance.url,
      'value': instance.value,
    };
