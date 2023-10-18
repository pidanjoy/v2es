import 'package:json_annotation/json_annotation.dart';

part 'g/config_model.g.dart';

@JsonSerializable()
class ProxyParams {
  bool proxyEnable = false;
  String proxyType = "http";
  String proxyHost = "127.0.0.1";
  int proxyPort = 7890;
  String username = "";
  String password = "";

  ProxyParams(
      {required this.proxyEnable,
      required this.proxyType,
      required this.proxyHost,
      required this.proxyPort,
      required this.username,
      required this.password});

  factory ProxyParams.fromJson(Map<String, dynamic> json) =>
      _$ProxyParamsFromJson(json);

  Map<String, dynamic> toJson() => _$ProxyParamsToJson(this);
}
