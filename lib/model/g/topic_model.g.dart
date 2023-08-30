// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../topic_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopicHead _$TopicHeadFromJson(Map<String, dynamic> json) => TopicHead(
      json['title'] as String,
      json['href'] as String,
      authorName: json['authorName'] as String?,
      authorHref: json['authorHref'] as String?,
      avatar: json['avatar'] as String?,
      nodeTitle: json['nodeTitle'] as String?,
      nodeHref: json['nodeHref'] as String?,
      replyQty: json['replyQty'] as int?,
      rankUp: json['rankUp'] as int?,
      lastReplyTime: json['lastReplyTime'] == null
          ? null
          : DateTime.parse(json['lastReplyTime'] as String),
      lastReplyName: json['lastReplyName'] as String?,
      lastReplyHref: json['lastReplyHref'] as String?,
    );

Map<String, dynamic> _$TopicHeadToJson(TopicHead instance) => <String, dynamic>{
      'title': instance.title,
      'href': instance.href,
      'authorName': instance.authorName,
      'authorHref': instance.authorHref,
      'avatar': instance.avatar,
      'nodeTitle': instance.nodeTitle,
      'nodeHref': instance.nodeHref,
      'replyQty': instance.replyQty,
      'rankUp': instance.rankUp,
      'lastReplyTime': instance.lastReplyTime?.toIso8601String(),
      'lastReplyName': instance.lastReplyName,
      'lastReplyHref': instance.lastReplyHref,
    };
