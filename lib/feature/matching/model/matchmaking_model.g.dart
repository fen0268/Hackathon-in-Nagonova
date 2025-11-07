// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matchmaking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MatchmakingModel _$MatchmakingModelFromJson(Map<String, dynamic> json) =>
    _MatchmakingModel(
      userId: json['userId'] as String,
      status: json['status'] as String? ?? 'waiting',
      createdAt: _timestampFromJson(json['createdAt']),
      matchedWith: json['matchedWith'] as String?,
      matchId: json['matchId'] as String?,
    );

Map<String, dynamic> _$MatchmakingModelToJson(_MatchmakingModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'status': instance.status,
      'createdAt': _timestampToJson(instance.createdAt),
      'matchedWith': instance.matchedWith,
      'matchId': instance.matchId,
    };
