// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../config_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProxyParams _$ProxyParamsFromJson(Map<String, dynamic> json) => ProxyParams(
      proxyEnable: json['proxyEnable'] as bool,
      proxyType: json['proxyType'] as String,
      proxyHost: json['proxyHost'] as String,
      proxyPort: json['proxyPort'] as int,
      username: json['username'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$ProxyParamsToJson(ProxyParams instance) =>
    <String, dynamic>{
      'proxyEnable': instance.proxyEnable,
      'proxyType': instance.proxyType,
      'proxyHost': instance.proxyHost,
      'proxyPort': instance.proxyPort,
      'username': instance.username,
      'password': instance.password,
    };
