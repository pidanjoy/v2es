import 'package:json_annotation/json_annotation.dart';

part 'g/topic_model.g.dart';

@JsonSerializable()
class Topic {
  String title;
  String href;
  String context;
  String authorName;
  String authorHref;
  String avatar;
  DateTime? releaseTime;
  String? nodeTitle;
  String? nodeHref;
  int? likeCount;
  int? clickCount;
  int? favoriteCount;
  int? thanksCount;
  int? replyCount;
  DateTime? lastReplyTime;
  List<TopicTag>? tags;
  int pageNo;
  int pageSize;

  Topic(
      {required this.title,
      required this.href,
      required this.context,
      required this.authorName,
      required this.authorHref,
      required this.avatar,
      this.releaseTime,
      this.nodeTitle,
      this.nodeHref,
      this.likeCount,
      this.clickCount,
      this.favoriteCount,
      this.thanksCount,
      this.replyCount,
      this.lastReplyTime,
      this.tags,
      required this.pageNo,
      required this.pageSize});

  factory Topic.fromJson(Map<String, dynamic> json) => _$TopicFromJson(json);

  Map<String, dynamic> toJson() => _$TopicToJson(this);
}

@JsonSerializable()
class TopicHead {
  String title;
  String href;
  String? authorName;
  String? authorHref;
  String? avatar;
  String? nodeTitle;
  String? nodeHref;
  int? replyQty;
  int? rankUp;
  DateTime? lastReplyTime;
  String? lastReplyName;
  String? lastReplyHref;

  TopicHead(this.title, this.href,
      {this.authorName,
      this.authorHref,
      this.avatar,
      this.nodeTitle,
      this.nodeHref,
      this.replyQty,
      this.rankUp,
      this.lastReplyTime,
      this.lastReplyName,
      this.lastReplyHref});

  factory TopicHead.fromJson(Map<String, dynamic> json) =>
      _$TopicHeadFromJson(json);

  Map<String, dynamic> toJson() => _$TopicHeadToJson(this);
}

class TopicTab {}

@JsonSerializable()
class TopicTag {
  String name;
  String href;

  TopicTag(this.name, this.href);

  factory TopicTag.fromJson(Map<String, dynamic> json) =>
      _$TopicTagFromJson(json);

  Map<String, dynamic> toJson() => _$TopicTagToJson(this);
}

@JsonSerializable()
class TopicReply {
  String context;
  String replyName;
  String replyHref;
  String avatar;
  DateTime? replyTime;
  int? thanksCount;
  int? level;

  TopicReply(
      {required this.context,
      required this.replyName,
      required this.replyHref,
      required this.avatar,
      this.replyTime,
      this.thanksCount,
      this.level});

  factory TopicReply.fromJson(Map<String, dynamic> json) =>
      _$TopicReplyFromJson(json);

  Map<String, dynamic> toJson() => _$TopicReplyToJson(this);
}
