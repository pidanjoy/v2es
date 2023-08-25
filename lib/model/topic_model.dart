import 'dart:ffi';

class Topic {}

class Tag {}

class GoogleSearchTopic {
  String title;
  String href;
  String subtitle;

  var isClick = false;

  GoogleSearchTopic(this.title, this.href, this.subtitle);
}
