// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
  userId: json['userId'] as String,
  nickname: json['nickname'] as String,
  createdAt: _timestampFromJson(json['createdAt']),
  totalMatches: (json['totalMatches'] as num?)?.toInt() ?? 0,
  wins: (json['wins'] as num?)?.toInt() ?? 0,
  winRate: (json['winRate'] as num?)?.toDouble() ?? 0.0,
);

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'nickname': instance.nickname,
      'createdAt': _timestampToJson(instance.createdAt),
      'totalMatches': instance.totalMatches,
      'wins': instance.wins,
      'winRate': instance.winRate,
    };
