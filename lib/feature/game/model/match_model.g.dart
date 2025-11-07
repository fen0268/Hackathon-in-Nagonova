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
  startedAt: const DateTimeConverter().fromJson(json['startedAt'] as Object),
  finishedAt: const NullableDateTimeConverter().fromJson(json['finishedAt']),
  currentRound: (json['currentRound'] as num?)?.toInt() ?? 1,
  round1: json['round1'] == null
      ? null
      : RoundModel.fromJson(json['round1'] as Map<String, dynamic>),
  round2: json['round2'] == null
      ? null
      : RoundModel.fromJson(json['round2'] as Map<String, dynamic>),
  finalWinner: json['finalWinner'] as String?,
  createdAt: const DateTimeConverter().fromJson(json['createdAt'] as Object),
);

Map<String, dynamic> _$MatchModelToJson(
  _MatchModel instance,
) => <String, dynamic>{
  'matchId': instance.matchId,
  'player1': instance.player1,
  'player2': instance.player2,
  'status': instance.status,
  'startedAt': const DateTimeConverter().toJson(instance.startedAt),
  'finishedAt': const NullableDateTimeConverter().toJson(instance.finishedAt),
  'currentRound': instance.currentRound,
  'round1': instance.round1,
  'round2': instance.round2,
  'finalWinner': instance.finalWinner,
  'createdAt': const DateTimeConverter().toJson(instance.createdAt),
};
