import 'package:json_annotation/json_annotation.dart';

part 'g/node_model.g.dart';

@JsonSerializable()
class NodeTab {
  String name;
  String href;

  NodeTab({required this.name, required this.href});

  factory NodeTab.fromJson(Map<String, dynamic> json) =>
      _$NodeTabFromJson(json);

  Map<String, dynamic> toJson() => _$NodeTabToJson(this);
}

@JsonSerializable()
class Node {
  String name;
  String title;
  int topics;

  Node({required this.title, required this.name, required this.topics});

  factory Node.fromJson(Map<String, dynamic> json) =>
      _$NodeFromJson(json);

  Map<String, dynamic> toJson() => _$NodeToJson(this);
}

@JsonSerializable()
class Plan {
  String name;
  List<Node> nodes;
  int qty;

  Plan(this.name, this.nodes, this.qty);

  factory Plan.fromJson(Map<String, dynamic> json) =>
      _$PlanFromJson(json);

  Map<String, dynamic> toJson() => _$PlanToJson(this);
}
