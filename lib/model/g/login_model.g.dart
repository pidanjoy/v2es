// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginKey _$LoginKeyFromJson(Map<String, dynamic> json) => LoginKey(
      cookie: json['cookie'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
      captcha: json['captcha'] as String,
      once: json['once'] as String,
      next: json['next'] as String,
    );

Map<String, dynamic> _$LoginKeyToJson(LoginKey instance) => <String, dynamic>{
      'cookie': instance.cookie,
      'username': instance.username,
      'password': instance.password,
      'captcha': instance.captcha,
      'once': instance.once,
      'next': instance.next,
    };

LoginParams _$LoginParamsFromJson(Map<String, dynamic> json) => LoginParams(
      json['usernameKey'] as String,
      json['usernameValue'] as String,
      json['passwordKey'] as String,
      json['passwordValue'] as String,
      json['captchaKey'] as String,
      json['captchaValue'] as String,
      json['once'] as String,
      json['next'] as String,
    );

Map<String, dynamic> _$LoginParamsToJson(LoginParams instance) =>
    <String, dynamic>{
      'usernameKey': instance.usernameKey,
      'usernameValue': instance.usernameValue,
      'passwordKey': instance.passwordKey,
      'passwordValue': instance.passwordValue,
      'captchaKey': instance.captchaKey,
      'captchaValue': instance.captchaValue,
      'once': instance.once,
      'next': instance.next,
    };
