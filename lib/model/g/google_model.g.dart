// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../google_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoogleSearchTopic _$GoogleSearchTopicFromJson(Map<String, dynamic> json) =>
    GoogleSearchTopic(
      json['title'] as String,
      json['href'] as String,
      json['subtitle'] as String,
    )..isClick = json['isClick'] as bool;

Map<String, dynamic> _$GoogleSearchTopicToJson(GoogleSearchTopic instance) =>
    <String, dynamic>{
      'title': instance.title,
      'href': instance.href,
      'subtitle': instance.subtitle,
      'isClick': instance.isClick,
    };
