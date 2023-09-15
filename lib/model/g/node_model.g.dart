// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../node_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NodeTab _$NodeTabFromJson(Map<String, dynamic> json) => NodeTab(
      name: json['name'] as String,
      href: json['href'] as String,
    );

Map<String, dynamic> _$NodeTabToJson(NodeTab instance) => <String, dynamic>{
      'name': instance.name,
      'href': instance.href,
    };

Node _$NodeFromJson(Map<String, dynamic> json) => Node(
      title: json['title'] as String,
      name: json['name'] as String,
      topics: json['topics'] as int,
    );

Map<String, dynamic> _$NodeToJson(Node instance) => <String, dynamic>{
      'name': instance.name,
      'title': instance.title,
      'topics': instance.topics,
    };

Plan _$PlanFromJson(Map<String, dynamic> json) => Plan(
      json['name'] as String,
      json['subName'] as String,
      (json['nodes'] as List<dynamic>)
          .map((e) => Node.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['qty'] as int,
      json['icon'] as String,
      json['color'] as String,
    );

Map<String, dynamic> _$PlanToJson(Plan instance) => <String, dynamic>{
      'name': instance.name,
      'subName': instance.subName,
      'nodes': instance.nodes,
      'qty': instance.qty,
      'icon': instance.icon,
      'color': instance.color,
    };
