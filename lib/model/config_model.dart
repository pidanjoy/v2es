import 'package:json_annotation/json_annotation.dart';

part 'g/config_model.g.dart';

@JsonSerializable()
class ProxyParams {
  bool proxyEnable;
  String proxyType;
  String proxyHost;
  int proxyPort;
  String username;
  String password;

  ProxyParams(
      {this.proxyEnable = false,
      this.proxyType = "http",
      this.proxyHost = "127.0.0.1",
      this.proxyPort = 7890,
      this.username = "",
      this.password = ""});

  factory ProxyParams.fromJson(Map<String, dynamic> json) =>
      _$ProxyParamsFromJson(json);

  Map<String, dynamic> toJson() => _$ProxyParamsToJson(this);
}
