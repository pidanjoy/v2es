import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class UserInfo {

  String username;
  String password;

  UserInfo(this.username, this.password);
}
