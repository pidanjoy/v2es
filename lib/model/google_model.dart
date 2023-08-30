import 'package:json_annotation/json_annotation.dart';

part 'g/google_model.g.dart';

@JsonSerializable()
class GoogleSearchTopic {
  String title;
  String href;
  String subtitle;

  var isClick = false;

  GoogleSearchTopic(this.title, this.href, this.subtitle);

  factory GoogleSearchTopic.fromJson(Map<String, dynamic> json) =>
      _$GoogleSearchTopicFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleSearchTopicToJson(this);
}
