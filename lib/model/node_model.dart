class NodeTab {
  String name;
  String href;

  NodeTab(this.name, this.href);
}

class Node {
  String name;
  String title;
  int topics;

  Node({required this.title, required this.name, required this.topics});

  factory Node.fromJson(Map<String, dynamic> json) {
    return Node(
      name: json['name'],
      title: json['title'],
      topics: json['topics'],
    );
  }
}

class Plan {
  String name;
  List<Node> nodes;
  int qty;

  Plan(this.name, this.nodes, this.qty);
}
