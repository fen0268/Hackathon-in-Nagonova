// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MatchModel _$MatchModelFromJson(Map<String, dynamic> json) => _MatchModel(
  matchId: json['matchId'] as String,
  player1: json['player1'] as String,
  player2: json['player2'] as String,
  status: json['status'] as String? ?? 'waiting',
  startedAt: DateTime.parse(json['startedAt'] as String),
  finishedAt: json['finishedAt'] == null
      ? null
      : DateTime.parse(json['finishedAt'] as String),
  currentRound: (json['currentRound'] as num?)?.toInt() ?? 1,
  round1: json['round1'] == null
      ? null
      : RoundModel.fromJson(json['round1'] as Map<String, dynamic>),
  round2: json['round2'] == null
      ? null
      : RoundModel.fromJson(json['round2'] as Map<String, dynamic>),
  finalWinner: json['finalWinner'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$MatchModelToJson(_MatchModel instance) =>
    <String, dynamic>{
      'matchId': instance.matchId,
      'player1': instance.player1,
      'player2': instance.player2,
      'status': instance.status,
      'startedAt': instance.startedAt.toIso8601String(),
      'finishedAt': instance.finishedAt?.toIso8601String(),
      'currentRound': instance.currentRound,
      'round1': instance.round1,
      'round2': instance.round2,
      'finalWinner': instance.finalWinner,
      'createdAt': instance.createdAt.toIso8601String(),
    };
