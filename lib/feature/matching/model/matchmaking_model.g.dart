// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matchmaking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MatchmakingModel _$MatchmakingModelFromJson(Map<String, dynamic> json) =>
    _MatchmakingModel(
      userId: json['userId'] as String,
      status: json['status'] as String? ?? 'waiting',
      createdAt: DateTime.parse(json['createdAt'] as String),
      matchedWith: json['matchedWith'] as String?,
      matchId: json['matchId'] as String?,
    );

Map<String, dynamic> _$MatchmakingModelToJson(_MatchmakingModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'status': instance.status,
      'createdAt': instance.createdAt.toIso8601String(),
      'matchedWith': instance.matchedWith,
      'matchId': instance.matchId,
    };
