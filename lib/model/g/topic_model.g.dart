// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../topic_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Topic _$TopicFromJson(Map<String, dynamic> json) => Topic(
      title: json['title'] as String,
      href: json['href'] as String,
      context: json['context'] as String,
      authorName: json['authorName'] as String,
      authorHref: json['authorHref'] as String,
      avatar: json['avatar'] as String,
      releaseTime: json['releaseTime'] == null
          ? null
          : DateTime.parse(json['releaseTime'] as String),
      nodeTitle: json['nodeTitle'] as String?,
      nodeHref: json['nodeHref'] as String?,
      likeCount: json['likeCount'] as int?,
      clickCount: json['clickCount'] as int?,
      favoriteCount: json['favoriteCount'] as int?,
      thanksCount: json['thanksCount'] as int?,
      replyCount: json['replyCount'] as int?,
      tags: (json['tags'] as List<dynamic>?)
          ?.map((e) => TopicTag.fromJson(e as Map<String, dynamic>))
          .toList(),
      pageNo: json['pageNo'] as int,
      pageSize: json['pageSize'] as int,
);

Map<String, dynamic> _$TopicToJson(Topic instance) => <String, dynamic>{
      'title': instance.title,
      'href': instance.href,
      'context': instance.context,
      'authorName': instance.authorName,
      'authorHref': instance.authorHref,
      'avatar': instance.avatar,
      'releaseTime': instance.releaseTime?.toIso8601String(),
      'nodeTitle': instance.nodeTitle,
      'nodeHref': instance.nodeHref,
      'likeCount': instance.likeCount,
      'clickCount': instance.clickCount,
      'favoriteCount': instance.favoriteCount,
      'thanksCount': instance.thanksCount,
      'replyCount': instance.replyCount,
      'tags': instance.tags,
      'pageNo': instance.pageNo,
      'pageSize': instance.pageSize,
};

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

TopicTag _$TopicTagFromJson(Map<String, dynamic> json) => TopicTag(
      json['name'] as String,
      json['href'] as String,
);

Map<String, dynamic> _$TopicTagToJson(TopicTag instance) => <String, dynamic>{
      'name': instance.name,
      'href': instance.href,
};

TopicReply _$TopicReplyFromJson(Map<String, dynamic> json) => TopicReply(
      context: json['context'] as String,
      replyName: json['replyName'] as String,
      replyHref: json['replyHref'] as String,
      avatar: json['avatar'] as String,
      replyTime: json['replyTime'] == null
          ? null
          : DateTime.parse(json['replyTime'] as String),
      thanksCount: json['thanksCount'] as int?,
      level: json['level'] as int?,
);

Map<String, dynamic> _$TopicReplyToJson(TopicReply instance) =>
    <String, dynamic>{
          'context': instance.context,
          'replyName': instance.replyName,
          'replyHref': instance.replyHref,
          'avatar': instance.avatar,
          'replyTime': instance.replyTime?.toIso8601String(),
          'thanksCount': instance.thanksCount,
          'level': instance.level,
    };
