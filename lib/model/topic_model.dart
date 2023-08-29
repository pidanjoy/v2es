class Topic {}

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

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'href': href,
      'authorName': authorName,
      'authorHref': authorHref,
      'avatar': avatar,
      'nodeTitle': nodeTitle,
      'nodeHref': nodeHref,
      'replyQty': replyQty,
      'rankUp': rankUp,
      'lastReplyTime': lastReplyTime?.toIso8601String(),
      'lastReplyName': lastReplyName,
      'lastReplyHref': lastReplyHref,
    };
  }
}

class TopicTab {

}
