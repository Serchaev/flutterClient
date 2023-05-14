// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auths.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Auths _$AuthsFromJson(Map<String, dynamic> json) => Auths(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthsToJson(Auths instance) => <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'user': instance.user,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      userId: json['userId'] as String,
      userRole:
          (json['userRole'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userId': instance.userId,
      'userRole': instance.userRole,
    };
