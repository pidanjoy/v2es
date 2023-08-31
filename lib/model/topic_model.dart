import 'package:json_annotation/json_annotation.dart';

part 'g/topic_model.g.dart';

@JsonSerializable()
class Topic {

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

class TopicTab {

}
